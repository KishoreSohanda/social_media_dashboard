import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignupForm extends StatefulWidget {
  final void Function(
      String email, String password, String username, File? image) submitFn;
  const SignupForm(this.submitFn, {super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  File? _pickedImage;
  String? _enteredPassword;
  String? _enteredUsername;
  String? _enteredEmail;

  Future<void> _pickProfileImage() async {
    final imagePickerInstance = ImagePicker();
    final pickedImage = await imagePickerInstance.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    setState(() {
      _pickedImage = File(pickedImage!.path);
    });
  }

  void _submitSignUpForm() {
    var isValid = _formKey.currentState!.validate();
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(
            'Please take a profile picture.',
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(_enteredEmail!.trim(), _enteredPassword!.trim(),
          _enteredUsername!.trim(), _pickedImage ?? File(''));
      // print('formSaved');
    } else {
      // print('notSaved');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 620,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      _pickedImage == null
                          ? Image.asset('assets/images/cameraIconImage.png')
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(_pickedImage!),
                            ),
                      TextButton.icon(
                        style: const ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(64, 171, 251, 0.7))),
                        onPressed: _pickProfileImage,
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
                        validator: (value) {
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
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
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
                        validator: (value) {
                          var msg = 'Enter valid username.';
                          if (value!.isEmpty) {
                            return msg;
                          }

                          if (value.length < 4) {
                            return 'Atleast 4 characters are required';
                          }

                          return null;
                        },
                        onSaved: (newValue) => _enteredUsername = newValue,
                      ),
                      TextFormField(
                        obscureText: true,
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
                      ),
                      TextFormField(
                        obscureText: true,
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
                        validator: (value) {
                          var msg =
                              'Password should be atleast 7 characters long.';
                          if (_enteredPassword != value) {
                            return 'Passwords does not match.';
                          }
                          if (value!.length < 7) {
                            return msg;
                          }
                          if (value.isEmpty) {
                            return msg;
                          }
                          return null;
                        },
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
                    onPressed: _submitSignUpForm,
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
