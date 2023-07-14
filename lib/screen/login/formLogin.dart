// ignore_for_file: camel_case_types, unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virgil_app/screen/utils/auth.dart';

bool containsUpperCase(String str) {
  return str
      .split('')
      .any((char) => char.toUpperCase() == char && char.toLowerCase() != char);
}

bool containsBlackList(String str) {
  List<String> blackList = [
    '/',
    '&',
    '|',
    '<',
    '>',
    '-',
    ';',
    '"',
    "'",
    "%",
    ")",
    "]",
    "(",
    "[",
    "{",
    "}",
    " ",
    '*'
  ];
  for (var i = 0; i < str.length; i++) {
    for (var char in str.split('')) {
      if (blackList.contains(char)) {
        return true;
      }
    }
  }
  return false;
}

class formLogin extends StatefulWidget {
  const formLogin({super.key});

  @override
  State<formLogin> createState() => _formLoginState();
}

class _formLoginState extends State<formLogin> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLogin = true;

  Future<void> signIn() async {
    print(_email.text);
    print(_password.text);

    try {
      await Auth().signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
    } on FirebaseAuthException catch (error) {
      print(error);
      if (error.toString().contains('no user record')) {
        setState(() {
          _notExist = true;
          _badlyFormatted = false;
          _passwordInvalid = false;
          _disable = false;
        });
      } else if (error
          .toString()
          .contains('The email address is badly formatted')) {
        setState(() {
          _badlyFormatted = true;
          _notExist = false;
          _passwordInvalid = false;
          _disable = false;
        });
      } else if (error.toString().contains(
          'The password is invalid or the user does not have a password.')) {
        setState(() {
          _passwordInvalid = true;
          _badlyFormatted = false;
          _notExist = false;
          _disable = false;
        });
      } else if (error
          .toString()
          .contains("We have blocked all requests from this device due to unusual activity.")) {
        setState(() {
          _disable = true;
          _passwordInvalid = false;
          _badlyFormatted = false;
          _notExist = false;
        });
      } else {
        _disable = false;
        _passwordInvalid = false;
        _badlyFormatted = false;
        _notExist = false;
      }
    }
  }

  //KEY FORM
  final formKey = GlobalKey<FormState>();

  //Varible for FORM
  bool obscure = true;
  String confirmPassword = "";
  bool _notExist = false;
  bool _badlyFormatted = false;
  bool _passwordInvalid = false;
  bool _disable = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            //EMAIL
            TextFormField(
              //VALIDATE
              maxLength: 100,
              maxLines: 1,
              textInputAction: TextInputAction.next,
              controller: _email,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return "Insert a valid email";
                }
                return null;
              },
              //STYLE
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.email),
                  suffixIconColor: Colors.white,
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'example@email.com',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, color: Colors.deepPurple))),
            ),

            //PASSWORD
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                  //VALIDATOR
                  controller: _password,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        containsBlackList(value)) {
                      return "Password not valid";
                    }
                  },
                  //STYLE
                  cursorColor: Colors.white,
                  obscureText: obscure,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '',
                      labelStyle: const TextStyle(color: Colors.white),
                      suffixIconColor: Colors.white,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: obscure
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2.0, color: Colors.deepPurpleAccent)))),
            ),
            //BUTTON
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    signIn();
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                ),
                child: const Text('Sign in'),
              ),
            ),
            Builder(builder: (context) {
              if (_badlyFormatted) {
                return const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("The email is invalid",
                        style: TextStyle(
                          color: Colors.red,
                        )));
              } else if (_notExist) {
                return const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("The user does not exist",
                        style: TextStyle(
                          color: Colors.red,
                        )));
              } else if (_passwordInvalid) {
                return const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("Password wrong",
                        style: TextStyle(
                          color: Colors.red,
                        )));
              } else if (_disable) {
                return const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("Too many attempts wait a few minutes",
                        style: TextStyle(
                          color: Colors.red,
                        )));
              } else {
                return Container();
              }
            })
          ],
        ),
      ),
    );
  }
}
