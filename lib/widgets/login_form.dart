// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await _auth.signInWithProvider(googleAuthProvider);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text('An error occured! $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: Form(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    child: Image.asset('assets/images/defaultUserImage.png')),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        style: const TextStyle(
                          color: Color.fromRGBO(64, 171, 251, 1),
                        ),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(64, 171, 251, 0.2)),
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                          hintText: 'Enter email address.',
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        style: const TextStyle(
                          color: Color.fromRGBO(64, 171, 251, 1),
                        ),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(64, 171, 251, 0.2)),
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                          hintText: 'Enter Password.',
                          labelText: 'Password',
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            fixedSize:
                                const MaterialStatePropertyAll(Size(300, 20))),
                        onPressed: () {},
                        icon: const Icon(Icons.done),
                        label: const Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            fixedSize:
                                const MaterialStatePropertyAll(Size(300, 20))),
                        onPressed: _handleGoogleSignIn,
                        child: Row(
                          children: [
                            Image.network(
                                'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
                            const Text(
                              'SignIn with Google',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
