/*
  LOGIN PAGE
  ---

  Login page for the PR ppl.
*/

import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/widgets/heading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, height * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.66,
                child: Image.asset("assets/logo.png"),
              ),
              SizedBox(height: height * 0.08),
              HeadingWidget(),
              SizedBox(height: height * 0.08),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                width: width * 0.75,
                child: TextField(
                  style: TextStyle(color: Color.fromARGB(255, 182, 177, 177)),
                  controller: _username,
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 182, 177, 177)),
                    fillColor: Color.fromARGB(255, 63, 63, 63),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 63, 63, 63), // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ), //Username Text Field
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                width: width * 0.75,
                child: TextField(
                  style: TextStyle(color: Color.fromARGB(255, 182, 177, 177)),
                  controller: _password,
                  obscureText: true,
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 182, 177, 177)),
                    fillColor: Color.fromARGB(255, 63, 63, 63),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 63, 63, 63),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ), //Password Text Field
              SizedBox(
                width: width * 0.75,
                height: 55,
                child: TextButton(
                  onPressed: () async {
                    final username = _username.text;
                    final password = _password.text;
                    if (username.isEmpty || password.isEmpty) {
                      await showErrorDialog(context: context);
                    }
                    //Login logic
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white),
                  child: const Text('Go', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 14, 14, 14),
    );
  }
}

Future<void> showErrorDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Error"),
        content: Text("Please Enter Username and Password"),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

