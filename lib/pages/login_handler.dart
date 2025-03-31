import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/models/pr_portal.dart';
import 'package:pr_portal_devday_25/pages/home.dart';
import 'package:pr_portal_devday_25/pages/login.dart';
import 'package:provider/provider.dart';

class LoginHandler extends StatelessWidget {
  const LoginHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PRPortal>(
      builder: (context, prPortal, widget1) {
        return prPortal.isLoggedIn ? Home() : LoginPage();
      },
    );
  }
}
