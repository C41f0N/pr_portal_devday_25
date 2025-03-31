/*
  Participant Tile
  ---

  Holds information about a team and can modify it's attendance
*/

import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/constants/colors.dart';
import 'package:pr_portal_devday_25/models/team.dart';

class TeamTile extends StatefulWidget {
  const TeamTile({super.key, required this.team, required this.onTap});

  final VoidCallback onTap;
  final Team team;

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
          borderRadius: BorderRadius.circular(22),
          color:
              widget.team.present
                  ? CustomColors().lightRed
                  : CustomColors().darkRed,
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
                  widget.team.teamLeader,
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
                value: widget.team.present,
                activeColor: Colors.grey[200],
                onChanged: (x) {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text(
                            'Are you sure?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content:
                              widget.team.present
                                  ? Text('Mark ${widget.team.name} as ABSENT??')
                                  : Text(
                                    'Mark ${widget.team.name} as PRESENT?',
                                  ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          actions: [
                            TextButton(
                              onPressed:
                                  () => Navigator.pop(context), // Cancel action
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                                setState(() {
                                  widget.team.present =
                                      !widget
                                          .team
                                          .present; // Toggle attendance state
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Yes',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
