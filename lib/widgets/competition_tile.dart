/*
  Competition Tile
  ---

  Holds information about a competition and can modify it's timings
*/

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pr_portal_devday_25/constants/colors.dart';
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

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(competition.name),
                // content: Column(
                //   children: [
                //     DatePickerDialog(firstDate: firstDate, lastDate: lastDate);
                //   ],
                // ),
              ),
        );
      },

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: isGoingOn ? CustomColors().lightRed : CustomColors().darkRed,
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
                    width: constraints.maxWidth * 0.6,
                    child: AutoSizeText(
                      competition.name,
                      maxLines: 2,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: constraints.maxWidth * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 3),
                        Opacity(
                          opacity: notStarted ? 0.9 : 0.6,
                          child: Transform.scale(
                            alignment: Alignment.centerRight,
                            scale: notStarted ? 1 : 0.9,
                            child: AutoSizeText(
                              DateFormat(
                                "hh:mm a",
                              ).format(competition.startTime),
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Opacity(
                          opacity: isGoingOn ? 0.9 : 0.6,
                          child: Transform.scale(
                            scale: isGoingOn ? 1 : 0.9,
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              DateFormat("hh:mm a").format(competition.endTime),
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
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
