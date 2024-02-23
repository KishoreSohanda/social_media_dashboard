// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginForm extends StatefulWidget {
  final void Function(String email, String password) submitFn;
  const LoginForm(this.submitFn, {super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String? _enteredEmail;
  String? _enteredPassword;

  void _submitLoginForm() {
    var isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(_enteredEmail!.trim(), _enteredPassword!.trim());
      // print('formSaved');
    } else {
      // print('form not valid');
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      UserCredential authResult;
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      authResult = await _auth.signInWithProvider(googleAuthProvider);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user?.uid)
          .set({
        'username': authResult.user?.displayName,
        'email': authResult.user?.email,
        'image_url': authResult.user?.photoURL,
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
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
            key: _formKey,
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
                        validator: (value) {
                          _enteredEmail = value;
                          var msg = 'Enter valid email address.';
                          if (value!.isEmpty) {
                            return msg;
                          }
                          if (!(value.contains('@'))) {
                            return msg;
                          }
                          if (!(value.contains('.com'))) {
                            return msg;
                          }
                          return null;
                        },
                        onSaved: (newValue) => _enteredEmail = newValue,
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
                        validator: (value) {
                          _enteredPassword = value;
                          var msg =
                              'Password should be atleast 7 characters long.';
                          if (value!.length < 7) {
                            return msg;
                          }
                          if (value.isEmpty) {
                            return msg;
                          }
                          return null;
                        },
                        onSaved: (newValue) => _enteredPassword = newValue,
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
                        onPressed: _submitLoginForm,
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
