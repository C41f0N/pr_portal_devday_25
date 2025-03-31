import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pr_portal_devday_25/constants/config.dart';

// Takes username and password and returns a jwt token
Future<String> authenticate(String username, String password) async {
  try {
  var response = await http.post(
    Uri.parse("$serverUrl/api/auth/login"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"username": username, "password": password}),
  );

  if (response.statusCode == 200) {
    if (response.headers['set-cookie'] != null) {
      String token =
          response.headers['set-cookie']!
              .split(";")
              .where((x) {
                return x.split("=")[0] == "token";
              })
              .toList()[0]
              .split("=")[1];

      return "$token";
    }
  } else if (response.statusCode == 401) {
    return "UNAUTHORIZED";
  }

  return "FAILED";} catch (e) {
    print(e);
    return "FAILED";
  }
}
