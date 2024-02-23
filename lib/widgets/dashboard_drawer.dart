import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
            height: 200,
            width: double.infinity,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    style: const TextStyle(
                      color: Color.fromRGBO(64, 171, 251, 1),
                    ),
                    decoration: const InputDecoration(
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(64, 171, 251, 0.2)),
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                      hintText: 'Enter new username.',
                      labelText: 'Username',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: firestoreDatabase.collection('users').doc(userId).get(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data?['image_url']),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 0.7,
                            ),
                          ),
                        ),

                        // const SizedBox(
                        //   width: 15,
                        // ),
                        Text(snapshot.data?['username'] ?? 'Unknown'),
                        IconButton(
                            onPressed: editUserProfile,
                            icon: const Icon(Icons.edit))
                      ],
                    ),
        ),
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
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
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
