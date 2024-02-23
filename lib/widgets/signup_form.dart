import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 560,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: Form(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Image.asset('assets/images/cameraIconImage.png'),
                      TextButton.icon(
                        style: const ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(64, 171, 251, 0.7))),
                        onPressed: () {},
                        icon: const Icon(Icons.add_a_photo_outlined),
                        label: const Text('Add Image.'),
                      ),
                    ],
                  ),
                ),
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
                          hintText: 'Enter username.',
                          labelText: 'Username',
                        ),
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
                          hintText: 'Enter password.',
                          labelText: 'Password',
                        ),
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
                          hintText: 'Re-enter password.',
                          labelText: 'Repeat password',
                        ),
                      ),
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
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          )),
    );
  }
}
