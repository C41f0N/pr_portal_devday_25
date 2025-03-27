/*
  Competition Tile
  ---

  Holds information about a competition and can modify it's timings
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pr_portal_devday_25/models/competition.dart';

class CompetitionTile extends StatelessWidget {
  const CompetitionTile({
    super.key,
    // required this.backgroundColor,
    required this.competition,
  });

  // final Color backgroundColor;
  final Competition competition;

  @override
  Widget build(BuildContext context) {
    bool notStarted = DateTime.now().isBefore(competition.startTime);
    bool isGoingOn =
        DateTime.now().isAfter(competition.startTime) &&
        DateTime.now().isBefore(competition.endTime);
    bool hasEnded = DateTime.now().isAfter(competition.endTime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: isGoingOn? Colors.green.withValues(alpha: 1) : Colors.green.withValues(alpha: 0.3)
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: constraints.maxWidth * 0.7,
                    child: Text(competition.name, style: TextStyle(fontSize: 25)),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: constraints.maxWidth * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 3),
                        Text(
                          DateFormat("hh:mm a").format(competition.startTime),
                          style:
                              notStarted
                                  ? TextStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 18,
                                  )
                                  : TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 18,
                                  ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          DateFormat("hh:mm a").format(competition.endTime),
                          style:
                              isGoingOn
                                  ? TextStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 18,
                                  )
                                  : TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 18,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
