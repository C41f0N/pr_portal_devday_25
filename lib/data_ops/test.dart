import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  Future<void> authenticate() async {
    var response = await http.post(
      Uri.parse("http://localhost:4000/api/auth/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"username": "admin2", "password": "admin2"}),
    );

    String token = "NONE";

    if (response.headers['set-cookie'] != null) {
      token =
          response.headers['set-cookie']!
              .split(";")
              .where((x) {
                return x.split("=")[0] == "token";
              })
              .toList()[0]
              .split("=")[1];
    }

    String requestUrl = "http://localhost:4000/getallteams";

    response = await http.get(
      Uri.parse(requestUrl),
      headers: {'Content-Type': 'application/json', "Cookie": "token=$token;"},
    );

    print(response.statusCode);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authenticate();
          },
          child: Text("Go"),
        ),
      ),
    );
  }
}
