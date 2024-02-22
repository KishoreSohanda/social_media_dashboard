import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
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
                        style: const TextStyle(
                          color: Color.fromRGBO(64, 171, 251, 1),
                        ),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(64, 171, 251, 0.2)),
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(64, 171, 251, 1),
                              fontSize: 18),
                          hintText: 'Enter email address.',
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Color.fromRGBO(64, 171, 251, 1),
                        ),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(64, 171, 251, 0.2)),
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(64, 171, 251, 1),
                              fontSize: 18),
                          hintText: 'Enter Password.',
                          labelText: 'Password',
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                        fixedSize:
                            const MaterialStatePropertyAll(Size(300, 20))),
                    onPressed: () {},
                    icon: const Icon(Icons.done),
                    label: const Text(
                      'LOG IN',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          )),
    );
  }
}
