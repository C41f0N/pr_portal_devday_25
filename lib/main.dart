import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Participant Relations Portal',
      theme: ThemeData(colorScheme: ColorScheme.dark(primary: Colors.red)),
      home: const LoginPage(),
    );
  }
}
