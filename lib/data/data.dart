import 'package:flutter/material.dart';

import '../models/competition.dart';
import '../models/team.dart';

class Data{

  List<Team> getTeamList() {
    return [
      Team(name: "Alpha Warriors", teamLeader: "John Doe", present: true),
      Team(name: "Beta Strikers", teamLeader: "Alice Smith", present: false),
      Team(name: "Gamma Titans", teamLeader: "Robert Brown", present: true),
      Team(name: "Delta Knights", teamLeader: "Sophia Johnson", present: false),
      Team(name: "Epsilon Guardians", teamLeader: "Michael Lee", present: true),
      Team(name: "Alpha Warriors", teamLeader: "John Doe", present: true),
      Team(name: "Beta Strikers", teamLeader: "Alice Smith", present: false),
      Team(name: "Gamma Titans", teamLeader: "Robert Brown", present: true),
      Team(name: "Delta Knights", teamLeader: "Sophia Johnson", present: false),
      Team(name: "Epsilon Guardians", teamLeader: "Michael Lee", present: true),
    ];
  }

  List<Competition> getSampleCompetitions() {
    return [
      Competition(
        name: "National Chess Tournament",
        startTime: DateTime(2024, 7, 10, 9, 0),  // July 10, 2024, 9:00 AM
        endTime: DateTime(2024, 7, 10, 17, 0),   // July 10, 2024, 5:00 PM
      ),
      Competition(
        name: "Scrabble Championship",
        startTime: DateTime(2024, 8, 15, 10, 0), // August 15, 2024, 10:00 AM
        endTime: DateTime(2024, 8, 15, 18, 0),   // August 15, 2024, 6:00 PM
      ),
      Competition(
        name: "CodeFest 2024",
        startTime: DateTime(2024, 9, 20, 14, 0), // September 20, 2024, 2:00 PM
        endTime: DateTime(2024, 9, 20, 20, 0),   // September 20, 2024, 8:00 PM
      ),
      Competition(
        name: "Marathon Challenge",
        startTime: DateTime(2024, 10, 5, 6, 30), // October 5, 2024, 6:30 AM
        endTime: DateTime(2024, 10, 5, 12, 0),   // October 5, 2024, 12:00 PM
      ),
      Competition(
        name: "Hackathon 2024",
        startTime: DateTime(2024, 11, 12, 9, 0), // November 12, 2024, 9:00 AM
        endTime: DateTime(2025, 11, 12, 23, 59), // November 12, 2024, 11:59 PM
      ),
    ];
  }

}