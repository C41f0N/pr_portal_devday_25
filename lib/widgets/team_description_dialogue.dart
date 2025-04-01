import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/models/team.dart';

class TeamDescriptionDialogue extends StatelessWidget {
  const TeamDescriptionDialogue({super.key, required this.team});

  final Team team;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(team.name, textAlign: TextAlign.center),

      content: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${team.leader} (Leader)", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("${team.member1}", style: TextStyle(fontSize: 16)),
            Text("${team.member2}", style: TextStyle(fontSize: 16)),
            Text("${team.member3}", style: TextStyle(fontSize: 16)),
            Text("${team.member4}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            Text("Competing in ${team.competition}"),
          ],
        ),
      ),
    );
  }
}
