/*
  Participant Tile
  ---

  Holds information about a team and can modify it's attendance
*/

import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/models/team.dart';

class TeamTile extends StatelessWidget {
  const TeamTile({
    super.key,
    required this.backgroundColor,
    required this.team,
  });

  final Color backgroundColor;
  final Team team;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: backgroundColor.withValues(alpha: team.present ? 1 : 0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Team Proxima", style: TextStyle(fontSize: 23)),
              Text(
                "Abdul Ahad",
                style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.9,
            child: Switch(
              value: team.present,
              onChanged: (x) {},
              activeColor: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
