// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../providers/connection_info.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestoreDatabase = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  User? currentUser;
  String? userId;
  String? currentUserImageUrl;
  String? currentUserUsername;
  bool internetConnection = true;
  File? _pickedUpdatedImage;
  String? _pickedUpdatedUsername;
  bool _isLoading = false;
  bool onUserNameChanged = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentUser = auth.currentUser;
      userId = currentUser?.uid;
    });
  }

  Future<void> _onSaveEditUserProfile(BuildContext ctx) async {
    bool internetConnection = await checkNetworkConnectivity();
    if (!internetConnection) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Network Error !',
            style: TextStyle(color: Theme.of(ctx).colorScheme.secondary),
          ),
          content: const Text('Check your internet connection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Theme.of(ctx).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }
    final isFormValid = _formKey.currentState!.validate();
    if (isFormValid) {
      Navigator.of(context).pop();
      setState(() {
        _isLoading = true;
      });
      // print('Valid Form');
      _formKey.currentState!.save();
      await currentUser!.updateDisplayName(_pickedUpdatedUsername);
      await firestoreDatabase
          .collection('users')
          .doc(userId)
          .update({'username': _pickedUpdatedUsername});
      setState(() {
        onUserNameChanged = false;
      });
      if (_pickedUpdatedImage != null) {
        await FirebaseStorage.instance
            .ref()
            .child('all_user_images')
            .child('${currentUser!.uid}.jpg')
            .putFile(_pickedUpdatedImage!);
        final updatedImageUrl = await FirebaseStorage.instance
            .ref()
            .child('all_user_images')
            .child('${currentUser!.uid}.jpg')
            .getDownloadURL();
        await firestoreDatabase
            .collection('users')
            .doc(userId)
            .update({'image_url': updatedImageUrl});
        setState(() {});
        _pickedUpdatedImage = null;
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _pickUpdateProfileImage(StateSetter mySetState) async {
    final imagePickerInstance = ImagePicker();
    final pickedImage = await imagePickerInstance.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    mySetState(() {
      _pickedUpdatedImage = File(pickedImage!.path);
    });
  }

  void editUserProfile() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, mySetState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              height: 350,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiary,
                            foregroundImage: (_pickedUpdatedImage == null)
                                ? NetworkImage(currentUserImageUrl!)
                                : FileImage(_pickedUpdatedImage!)
                                    as ImageProvider,
                            backgroundImage: const AssetImage(
                                'assets/images/defaultUserImage.png'),
                          ),
                          TextButton.icon(
                            onPressed: () =>
                                _pickUpdateProfileImage(mySetState),
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            label: Text(
                              'Add New Image',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) => onUserNameChanged = true,
                      validator: (value) {
                        var msg = 'Enter valid username.';

                        if (value!.isEmpty) {
                          return msg;
                        }

                        if (value.length < 4) {
                          return 'Atleast 4 characters are required';
                        }

                        return null;
                      },
                      onSaved: (newValue) => _pickedUpdatedUsername = newValue,
                      initialValue: currentUserUsername,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      style: const TextStyle(
                        color: Color.fromRGBO(64, 171, 251, 1),
                      ),
                      decoration: const InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 18),
                        labelText: 'Username',
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(64, 171, 251, 0.2)),
                        hintText: 'Enter new username.',
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    // const SizedBox(height: 15),
                    ElevatedButton.icon(
                        onPressed:
                            (!onUserNameChanged && _pickedUpdatedImage == null)
                                ? () {
                                    if (!onUserNameChanged) {
                                      Navigator.of(context).pop();
                                    }
                                  }
                                : () => _onSaveEditUserProfile(context),
                        icon: const Icon(Icons.save),
                        label: const Text('Save'))
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Future<bool> checkNetworkConnectivity() async {
    return internetConnection =
        await Provider.of<ConnectionInfo>(context, listen: false)
            .internetConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
            future: firestoreDatabase.collection('users').doc(userId).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                currentUserImageUrl = snapshot.data?['image_url'];
                currentUserUsername = snapshot.data?['username'];
                return _isLoading
                    ? const Center(
                        child: Text('Loading....'),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // NetworkImage(snapshot.data?['image_url'])

                          FadeInImage(
                            imageErrorBuilder: (context, error, stackTrace) {
                              return const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                    'assets/images/defaultUserImage.png'),
                              );
                            },
                            height: 30,
                            width: 30,
                            placeholder: const AssetImage(
                                'assets/images/defaultUserImage.png'),
                            image: NetworkImage(
                              currentUserImageUrl!,
                            ),
                          ),
                          Text(snapshot.data?['username'] ?? 'Unknown'),
                          IconButton(
                              onPressed: editUserProfile,
                              icon: const Icon(Icons.edit))
                        ],
                      );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          : ListView(
              reverse: true,
              padding: EdgeInsets.zero,
              children: [
                const Divider(
                  thickness: 0.3,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  onTap: () {
                    auth.signOut();
                  },
                ),
                const Divider(thickness: 0.3),
              ],
            ),
    ));
  }
}
