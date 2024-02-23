// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/login_form.dart';
import '../widgets/signup_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _auth = FirebaseAuth.instance;

  void _submitLoginAuthForm(String email, String password) async {
    // ignore: unused_local_variable
    UserCredential authResult;
    try {
      authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      if (error.toString().contains(
          'The supplied auth credential is incorrect, malformed or has expired.')) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(
              'Authentication credentials are incorrect.',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    }
  }

  void _submitSignUpAuthForm(
      String email, String password, String username, File? image) async {
    UserCredential authResult;
    try {
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final ref = FirebaseStorage.instance
          .ref()
          .child('all_user_images')
          .child('${authResult.user?.uid}.jpg');
      await ref.putFile(image!);
      final userImageUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user?.uid)
          .set({
        'username': username,
        'email': email,
        'image_url': userImageUrl,
      });
    } catch (e) {
      // print(e);
    }
  }

  Widget expandedTextButton(
      VoidCallback onPressed, String text, double fontSize) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: const Color.fromRGBO(64, 171, 251, 1),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              // margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  expandedTextButton(() {
                    setState(() {
                      isLogin = true;
                    });
                  }, 'Login', (isLogin) ? 30 : 20),
                  expandedTextButton(() {
                    setState(() {
                      isLogin = false;
                    });
                  }, 'SignUp', (!isLogin) ? 30 : 20),
                ],
              ),
            ),
            isLogin
                ? LoginForm(_submitLoginAuthForm)
                : SignupForm(_submitSignUpAuthForm),
          ],
        ),
      ),
    );
  }
}
