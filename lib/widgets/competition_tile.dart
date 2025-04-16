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
    this.onTimeUpdate,
  });

  // final Color backgroundColor;
  final Competition competition;
  final Function(DateTime startTime, DateTime endTime)? onTimeUpdate;

  @override
  Widget build(BuildContext context) {
    bool notStarted = DateTime.now().isBefore(competition.startTime);
    bool isGoingOn =
        DateTime.now().isAfter(competition.startTime) &&
        DateTime.now().isBefore(competition.endTime);
    bool hasEnded = DateTime.now().isAfter(competition.endTime);

    return GestureDetector(
      onTap: () {
        _showTimeUpdateDialog(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 92, 6, 0),
            strokeAlign: 1.5,
          ),
          borderRadius: BorderRadius.circular(22),
          color:
              isGoingOn
                  ? CustomColors().lightRed
                  : Color.fromARGB(255, 39, 5, 5).withAlpha(250),
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
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
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

  void _showTimeUpdateDialog(BuildContext context) {
    DateTime newStartTime = competition.startTime;
    DateTime newEndTime = competition.endTime;

    print(competition.startTime);
    print(DateTime.now());

    print(competition.startTime.isBefore(DateTime.now()));

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  backgroundColor: CustomColors().darkRed.withOpacity(0.95),
                  title: Text(
                    competition.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTimePicker(context, "Start Time", newStartTime, (
                        time,
                      ) {
                        setState(() {
                          // Use setState to trigger rebuild
                          newStartTime = _combineDateAndTime(
                            competition.startTime,
                            time,
                          );
                        });
                      }),
                      SizedBox(height: 20),
                      _buildTimePicker(context, "End Time", newEndTime, (time) {
                        setState(() {
                          // use setState to trigger rebuild
                          newEndTime = _combineDateAndTime(
                            competition.endTime,
                            time,
                          );
                        });
                      }),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors().lightRed,
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (onTimeUpdate != null) {
                          onTimeUpdate!(newStartTime, newEndTime);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white70),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
          ),
    );
  }

  Widget _buildTimePicker(
    BuildContext context,
    String label,
    DateTime initialTime,
    Function(TimeOfDay) onTimeSelected,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label + ":", style: TextStyle(color: Colors.white, fontSize: 16)),
        InkWell(
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(initialTime),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.dark().copyWith(
                    colorScheme: ColorScheme.dark(
                      primary: CustomColors().lightRed,
                      onPrimary: Colors.white,
                      surface: CustomColors().darkRed,
                      onSurface: Colors.white,
                    ), dialogTheme: DialogThemeData(backgroundColor: CustomColors().darkRed),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              onTimeSelected(picked);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: CustomColors().lightRed,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              DateFormat("hh:mm a").format(initialTime),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  DateTime _combineDateAndTime(DateTime original, TimeOfDay timeOfDay) {
    return DateTime(
      original.year,
      original.month,
      original.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }
}
