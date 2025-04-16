import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pr_portal_devday_25/constants/config.dart';
import 'package:pr_portal_devday_25/models/pr_portal.dart';
import 'package:provider/provider.dart';

import '../models/competition.dart';
import '../models/team.dart';

class Data {
  // Takes buildcontext, returns null if error, or a list of teams if success
  Future<List<Team>?> getTeamList(BuildContext context) async {
    try {
      PRPortal prPortal = context.read<PRPortal>();

      // Sending request to api with the token
      var response = await http.get(
        Uri.parse("$serverUrl/api/admin/getAllTeams"),
        headers: {
          'Content-Type': 'application/json',
          "Cookie": "token=${prPortal.token};",
        },
      );

      // If success
      if (response.statusCode == 200) {
        // Decode json body to List of Team object and return
        return (jsonDecode(response.body) as List<dynamic>)
            .map((x) => Team.fromJson(x))
            .toList();
      }
      // If token expired
      else if (response.statusCode == 401) {
        // Log out the user
        prPortal.setLoggedIn(false, null);
        return null;
      }
      // if unknown error
      else {
        print(response.statusCode);
        return null;
      }
    }
    // if unknown error
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Competition>?> getCompetitionsList(BuildContext context) async {
    try {
      PRPortal prPortal = context.read<PRPortal>();

      // Sending request to api with the token
      var response = await http.get(
        Uri.parse("$serverUrl/api/admin/getAllCompetitions"),
        headers: {
          'Content-Type': 'application/json',
          "Cookie": "token=${prPortal.token};",
        },
      );

      // If success
      if (response.statusCode == 200) {
        // Decode json body to List of Competition object and return
        return (jsonDecode(response.body) as List<dynamic>)
            .map((x) => Competition.fromJson(x))
            .toList();
      }
      // If token expired
      else if (response.statusCode == 401) {
        // Log out the user
        prPortal.setLoggedIn(false, null);
        return null;
      }
      // if unknown error
      else {
        print(response.statusCode);
        return null;
      }
    }
    // if unknown error
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> markAttendance(BuildContext context, Team team) async {
    try {
      PRPortal prPortal = context.read<PRPortal>();

      // Sending request to api with the token
      var response = await http.post(
        Uri.parse("$serverUrl/api/admin/markAttendance"),
        headers: {
          'Content-Type': 'application/json',
          "Cookie": "token=${prPortal.token};",
        },
        body: jsonEncode({"att_code": team.att_code}),
      );

      // If success
      if (response.statusCode == 200) {
        return null;
      }
      // If token expired
      else if (response.statusCode == 401) {
        // Log out the user
        prPortal.setLoggedIn(false, null);
        return null;
      }
      // if unknown error
      else {
        print(response.statusCode);
        print("code: ${team.att_code}");
        return "FAILED";
      }
    }
    // if unknown error
    catch (e) {
      print(e);
      return "FAILED";
    }
  }

  Future<String?> unmarkAttendance(BuildContext context, Team team) async {
    try {
      PRPortal prPortal = context.read<PRPortal>();

      // Sending request to api with the token
      var response = await http.post(
        Uri.parse("$serverUrl/api/admin/unmarkAttendance"),
        headers: {
          'Content-Type': 'application/json',
          "Cookie": "token=${prPortal.token};",
        },
        body: jsonEncode({"att_code": team.att_code}),
      );

      // If success
      if (response.statusCode == 200) {
        return null;
      }
      // If token expired
      else if (response.statusCode == 401) {
        // Log out the user
        prPortal.setLoggedIn(false, null);
        return null;
      }
      // if unknown error
      else {
        print(response.statusCode);
        print("code: ${team.att_code}");
        return "FAILED";
      }
    }
    // if unknown error
    catch (e) {
      print(e);
      return "FAILED";
    }
  }

  Future<bool> updateCompetitionTime(
    BuildContext context,
    String competitionName,
    DateTime startTime,
    DateTime endTime,
  ) async {
    try {
      PRPortal prPortal = context.read<PRPortal>();

      // Subtracting 5 hours offset
      startTime = startTime.toUtc();
      endTime = endTime.toUtc();

      final startTimeUtc = DateTime.utc(
        startTime.year,
        startTime.month,
        startTime.day,
        startTime.hour,
        startTime.minute,
      );

      final endTimeUtc = DateTime.utc(
        endTime.year,
        endTime.month,
        endTime.day,
        endTime.hour,
        endTime.minute,
      );

      var response = await http.post(
        Uri.parse("$serverUrl/api/admin/updatetime"),
        headers: {
          'Content-Type': 'application/json',
          "Cookie": "token=${prPortal.token};",
        },
        body: jsonEncode({
          "competitionName": competitionName,
          "start_time": startTimeUtc.toIso8601String(),
          "end_time": endTimeUtc.toIso8601String(),
        }),
      );

      // Rest of the function unchanged
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        prPortal.setLoggedIn(false, null);
        return false;
      } else {
        print("Update competition time failed: ${response.statusCode}");
        print(response.body);
        return false;
      }
    } catch (e) {
      print("Exception in updateCompetitionTime: $e");
      return false;
    }
  }
}
