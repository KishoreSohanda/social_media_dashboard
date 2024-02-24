import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../providers/connection_info.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestoreDatabase = FirebaseFirestore.instance;
  User? currentUser;
  String? userId;
  String? currentUserImageUrl;
  String? currentUserUsername;
  int init = 0;
  bool internetConnection = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentUser = auth.currentUser;
      userId = currentUser?.uid;
    });
  }

  void editUserProfile() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            height: 350,
            width: double.infinity,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(currentUserImageUrl!),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          label: Text(
                            'Add New Image',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    initialValue: currentUserUsername,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    style: const TextStyle(
                      color: Color.fromRGBO(64, 171, 251, 1),
                    ),
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                      labelText: 'Username',
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(64, 171, 251, 0.2)),
                      hintText: 'Enter new username.',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void checkNetworkConnectivity() async {
    internetConnection =
        await Provider.of<ConnectionInfo>(context).internetConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    if (init == 0) {
      checkNetworkConnectivity();
      init++;
    }

    return !internetConnection
        ? AlertDialog(
            title: Text(
              'Network Error !',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            content: const Text('Check your internet connection.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )),
            ],
          )
        : Drawer(
            child: Scaffold(
            appBar: AppBar(
              title: FutureBuilder(
                  future:
                      firestoreDatabase.collection('users').doc(userId).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      currentUserImageUrl = snapshot.data?['image_url'];
                      currentUserUsername = snapshot.data?['username'];
                      // print(currentUserUsername);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // NetworkImage(snapshot.data?['image_url'])

                          FadeInImage(
                            imageErrorBuilder: (context, error, stackTrace) {
                              return const CircleAvatar(
                                radius: 30,
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
            body: ListView(
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
