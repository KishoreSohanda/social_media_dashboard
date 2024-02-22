import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              child: Image.asset('assets/images/cameraIconImage.png')),
          TextFormField(
            style: const TextStyle(
              color: Color.fromRGBO(64, 171, 251, 1),
            ),
            decoration: const InputDecoration(
              hintStyle: TextStyle(color: Color.fromRGBO(64, 171, 251, 0.2)),
              labelStyle: TextStyle(
                  color: Color.fromRGBO(64, 171, 251, 1), fontSize: 18),
              hintText: 'Enter user email.',
              labelText: 'Email',
            ),
          ),
          TextFormField(
            style: const TextStyle(
              color: Color.fromRGBO(64, 171, 251, 1),
            ),
            decoration: const InputDecoration(
              hintStyle: TextStyle(color: Color.fromRGBO(64, 171, 251, 0.2)),
              labelStyle: TextStyle(
                  color: Color.fromRGBO(64, 171, 251, 1), fontSize: 18),
              hintText: 'Enter user email.',
              labelText: 'Email',
            ),
          ),
          TextFormField(
            style: const TextStyle(
              color: Color.fromRGBO(64, 171, 251, 1),
            ),
            decoration: const InputDecoration(
              hintStyle: TextStyle(color: Color.fromRGBO(64, 171, 251, 0.2)),
              labelStyle: TextStyle(
                  color: Color.fromRGBO(64, 171, 251, 1), fontSize: 18),
              hintText: 'Enter user email.',
              labelText: 'Email',
            ),
          ),
          TextFormField(
            style: const TextStyle(
              color: Color.fromRGBO(64, 171, 251, 1),
            ),
            decoration: const InputDecoration(
              hintStyle: TextStyle(color: Color.fromRGBO(64, 171, 251, 0.2)),
              labelStyle: TextStyle(
                  color: Color.fromRGBO(64, 171, 251, 1), fontSize: 18),
              hintText: 'Enter user email.',
              labelText: 'Email',
            ),
          ),
        ],
      ),
    );
  }
}
