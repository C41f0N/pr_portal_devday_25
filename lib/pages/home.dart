/*
  HOME PAGE
  ---

  Shows tables for attendance and competition timings.
*/

import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/models/competition.dart';
import 'package:pr_portal_devday_25/models/team.dart';
import 'package:pr_portal_devday_25/widgets/competition_tile.dart';
import 'package:pr_portal_devday_25/widgets/mode_switcher.dart';
import 'package:pr_portal_devday_25/widgets/team_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool state = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CompetitionTile(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  competition: Competition(
                    name: "Tech Heist",
                    startTime: DateTime.now().subtract(Duration(hours: 1)),
                    endTime: DateTime.now().subtract(Duration(hours: 2)),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TeamTile(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  team: Team(
                    name: "Proxima",
                    teamLeader: "Abdul Ahad",
                    present: false,
                  ),
                ),
              ),
              ModeSwitcher(
                width: MediaQuery.of(context).size.width * 0.7,
                thumbColor: Theme.of(context).colorScheme.primary,
                mode: state,
                onChanged: (x) {
                  setState(() {
                    state = x;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
