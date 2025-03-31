/*
  LOGIN PAGE
  ---

  Login page for the PR ppl.
*/

import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/data/authentication.dart';
import 'package:pr_portal_devday_25/models/pr_portal.dart';
import 'package:pr_portal_devday_25/widgets/heading.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? usernameError;
  String? passwordError;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Consumer<PRPortal>(
      builder: (context, prPortal, widget1) {
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
                      style: TextStyle(
                        color: Color.fromARGB(255, 182, 177, 177),
                      ),
                      controller: usernameController,
                      autocorrect: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        errorText: passwordError,
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 182, 177, 177),
                        ),
                        fillColor: Color.fromARGB(255, 63, 63, 63),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(
                              255,
                              63,
                              63,
                              63,
                            ), // Border color
                            width: 1.0, // Border width
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                      ),
                    ),
                  ), //Username Text Field
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    width: width * 0.75,
                    child: TextField(
                      style: TextStyle(
                        color: Color.fromARGB(255, 182, 177, 177),
                      ),
                      controller: passwordController,
                      obscureText: true,
                      autocorrect: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        errorText: passwordError,
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 182, 177, 177),
                        ),
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
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                      ),
                    ),
                  ), //Password Text Field
                  SizedBox(
                    width: width * 0.75,
                    height: 55,
                    child: TextButton(
                      onPressed: () async {
                        // Giving error messages
                        usernameError =
                            usernameController.text.isEmpty
                                ? "Enter a username"
                                : null;
                        passwordError =
                            passwordController.text.isEmpty
                                ? "Enter a password"
                                : null;
                        setState(() {});

                        // Login logic
                        if (usernameError == null && passwordError == null) {
                          String result = await authenticate(
                            usernameController.text,
                            passwordController.text,
                          );

                          if (result == "UNAUTHORIZED") {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: Text(
                                      "Username or password incorrect.",
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                        child: Text("Okay"),
                                      ),
                                    ],
                                  ),
                            );
                          } else if (result == "FAILED") {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: Text("An unknown error occoured"),
                                    actions: [
                                      ElevatedButton(
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                        child: Text("Okay"),
                                      ),
                                    ],
                                  ),
                            );
                          } else {
                            prPortal.setToken(result);
                            prPortal.setLoggedIn(true);
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Go', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 14, 14, 14),
        );
      },
    );
  }
}
