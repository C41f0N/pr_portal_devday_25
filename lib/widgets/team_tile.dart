/*
  Participant Tile
  ---

  Holds information about a team and can modify it's attendance
*/

import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/constants/colors.dart';
import 'package:pr_portal_devday_25/models/team.dart';

class TeamTile extends StatefulWidget {
  const TeamTile({
    super.key,
    required this.team,
    required this.onTap,
    required this.onChanged,
  });

  final VoidCallback onTap;
  final Team team;
  final Function(bool) onChanged;

  @override
  State<TeamTile> createState() => _TeamTileState();
}

class _TeamTileState extends State<TeamTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 28),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 92, 6, 0), strokeAlign: 1.5),
          borderRadius: BorderRadius.circular(22),
          color:
              widget.team.attendance
                  ? CustomColors().lightRed
                  : Color.fromARGB(255, 39, 5, 5).withAlpha(250)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.team.name, style: TextStyle(fontSize: 24)),
                SizedBox(height: 5),
                Text(
                  widget.team.leader,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
            Transform.scale(
              scale: 0.9,
              child: Switch(
                value: widget.team.attendance,
                activeColor: Colors.grey[200],
                onChanged: widget.onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
