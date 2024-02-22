import 'package:flutter/material.dart';

import '../widgets/login_form.dart';
import '../widgets/signup_form.dart';

class AuthScreen extends StatefulWidget {
  // static const routeName = '/auth-screen';
  static const routeName = '/';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
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
            isLogin ? const LoginForm() : const SignupForm(),
          ],
        ),
      ),
    );
  }
}
