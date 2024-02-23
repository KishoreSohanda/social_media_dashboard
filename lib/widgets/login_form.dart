import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

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
                        onPressed: () {},
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
