/*
  HOME PAGE
  ---
  Shows tables for attendance and competition timings.
  Allows switching between team attendance and competition views.
  Includes search functionality for both views.
*/

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/constants/colors.dart';
import 'package:pr_portal_devday_25/models/competition.dart';
import 'package:pr_portal_devday_25/models/pr_portal.dart';
import 'package:pr_portal_devday_25/models/team.dart';
import 'package:pr_portal_devday_25/utils/utilities.dart';
import 'package:pr_portal_devday_25/widgets/competition_tile.dart';
import 'package:pr_portal_devday_25/widgets/mode_switcher.dart';
import 'package:pr_portal_devday_25/widgets/search_bar.dart';
import 'package:pr_portal_devday_25/widgets/team_description_dialogue.dart';
import 'package:pr_portal_devday_25/widgets/team_tile.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';

enum ViewMode { teams, competitions }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Competition>? competitions = [];
  final TextEditingController controller = TextEditingController();
  ViewMode viewMode = ViewMode.teams;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Team>?> getTeamList() async {
    var data = Data();
    return await data.getTeamList(context);
  }

  Future<List<Competition>?> getCompetitionsList() async {
    var data = Data();
    return await data.getCompetitionsList(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget teamsListView = FutureBuilder(
      future: getTeamList(),
      builder: (context, future) {
        if (future.connectionState == ConnectionState.done) {
          if (future.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("An unknown error occcoured"),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          } else {
            List<Team> teams = future.data!;

            teams.removeWhere((team) {
              return !team.name.toLowerCase().contains(
                    controller.text.toLowerCase(),
                  ) &&
                  !team.leader.toLowerCase().contains(
                    controller.text.toLowerCase(),
                  );
            });

            return ListView.separated(
              padding: EdgeInsets.only(bottom: 20),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return TeamTile(
                  team: teams[index],
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) =>
                              TeamDescriptionDialogue(team: teams[index]),
                    );
                  },
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
                                teams[index].attendance
                                    ? Text(
                                      'Mark ${teams[index].name} as ABSENT??',
                                    )
                                    : Text(
                                      'Mark ${teams[index].name} as PRESENT?',
                                    ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  String? result =
                                      teams[index].attendance
                                          ? await Data().unmarkAttendance(
                                            context,
                                            teams[index],
                                          )
                                          : await Data().markAttendance(
                                            context,
                                            teams[index],
                                          );

                                  if (result == "FAILED") {
                                    Navigator.pop(context); // Close dialog
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            title: Text(
                                              "Something went wrong.",
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                    context,
                                                  ); // Close dialog
                                                },
                                                child: Text("Okay"),
                                              ),
                                            ],
                                          ),
                                    );
                                  } else {
                                    setState(() {});
                                    Navigator.pop(context); // Close dialog
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColors().lightRed,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text('Yes'),
                              ),
                              TextButton(
                                onPressed:
                                    () =>
                                        Navigator.pop(context), // Cancel action
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 16);
              },
            );
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );

    Widget competitionsListView = FutureBuilder(
      future: getCompetitionsList(),
      builder: (context, future) {
        if (future.connectionState == ConnectionState.done) {
          if (future.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("An unknown error occcoured"),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          } else {
            List<Competition> competitions = future.data!;
            competitions.removeWhere((competition) {
              return !competition.name.toLowerCase().contains(
                controller.text.toLowerCase(),
              );
            });
            return ListView.separated(
              padding: EdgeInsets.only(bottom: 20),
              itemCount: competitions.length,
              itemBuilder: (context, index) {
                return CompetitionTile(
                  competition: competitions[index],
                  onTimeUpdate: (
                    DateTime newStartTime,
                    DateTime newEndTime,
                  ) async {
                    // show loading indicator
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Updating competition time...')),
                    );

                    // call the API to update the competition time
                    bool success = await Data().updateCompetitionTime(
                      context,
                      competitions[index].name,
                      newStartTime,
                      newEndTime,
                    );

                    if (success) {
                      // refresh the list to show updated times
                      setState(() {
                        // force refresh
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Competition time updated successfully',
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to update competition time'),
                        ),
                      );
                    }
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 16);
              },
            );
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );

    return Consumer<PRPortal>(
      builder: (context, prPortal, widget1) {
        double paddingRatio = isHorizontal(context) ? 0.4 : 0.1;

        return SafeArea(
          child: Scaffold(
            backgroundColor: CustomColors().bg,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * paddingRatio / 2,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.scale(
                          alignment: Alignment.centerLeft,
                          scale: isHorizontal(context) ? 1.25 : 1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: CircleAvatar(
                                  foregroundColor: Colors.white,
                                  child: Transform.translate(
                                    offset: Offset(0, 5),
                                    child: Transform.scale(
                                      scale: 1.8,
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Text(
                                "${prPortal.username!}",
                                style: TextStyle(
                                  color: CustomColors().lightRed,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.scale(
                          alignment: Alignment.centerRight,
                          scale: isHorizontal(context) ? 1.25 : 1,
                          child: CircleAvatar(
                            backgroundColor: CustomColors().darkRed,
                            child: IconButton(
                              color: Colors.white,
                              iconSize: 20,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: Text(
                                          "Are you sure you want to logout?",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  CustomColors().lightRed,
                                            ),
                                            onPressed: () {
                                              prPortal.setLoggedIn(false, null);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Yes"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("No"),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              icon: Icon(Icons.logout),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.2,
                    // color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ModeSwitcher(
                          width:
                              MediaQuery.of(context).size.width -
                              width * paddingRatio,

                          thumbColor: Theme.of(context).colorScheme.primary,
                          mode: viewMode == ViewMode.teams,
                          onChanged: (x) {
                            setState(() {
                              viewMode =
                                  x ? ViewMode.teams : ViewMode.competitions;
                            });
                          },
                        ),

                        CustomSearchBar(
                          controller: controller,
                          onChanged: (s) {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),

                  ClipRect(
                    child: Container(
                      // color: Colors.blue,
                      height: height * 0.65,
                      child: CustomMaterialIndicator(
                        onRefresh: () async {
                          setState(() {});
                        },
                        // backgroundColor: Colors.transparent,
                        indicatorBuilder: (context, controller) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              // backgroundColor: Colors.transparent,
                              color: Colors.redAccent,
                            ),
                          );
                        },
                        child: Container(
                          child:
                              viewMode == ViewMode.teams
                                  ? teamsListView
                                  : competitionsListView,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
