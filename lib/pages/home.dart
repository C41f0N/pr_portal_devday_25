/*
  HOME PAGE
  ---
  Shows tables for attendance and competition timings.
  Allows switching between team attendance and competition views.
  Includes search functionality for both views.
*/

import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/constants/colors.dart';
import 'package:pr_portal_devday_25/models/competition.dart';
import 'package:pr_portal_devday_25/models/pr_portal.dart';
import 'package:pr_portal_devday_25/models/team.dart';
import 'package:pr_portal_devday_25/widgets/competition_tile.dart';
import 'package:pr_portal_devday_25/widgets/mode_switcher.dart';
import 'package:pr_portal_devday_25/widgets/search_bar.dart';
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
                    // TODO: Implement team selection logic
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
                              TextButton(
                                onPressed:
                                    () =>
                                        Navigator.pop(context), // Cancel action
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
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
                return CompetitionTile(competition: competitions[index]);
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

    double paddingRatio = 0.1;

    return Consumer<PRPortal>(
      builder: (context, prPortal, widget1) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: CustomColors().bg,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * paddingRatio / 2,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      ModeSwitcher(
                        width:
                            width < height
                                ? MediaQuery.of(context).size.width -
                                    width * paddingRatio
                                : 500,
                        thumbColor: Theme.of(context).colorScheme.primary,
                        mode: viewMode == ViewMode.teams,
                        onChanged: (x) {
                          setState(() {
                            viewMode =
                                x ? ViewMode.teams : ViewMode.competitions;
                          });
                        },
                      ),
                    ],
                  ),

                  CustomSearchBar(
                    controller: controller,
                    onChanged: (s) {
                      setState(() {});
                    },
                  ),

                  SizedBox(
                    height: height * 0.75,
                    child: Container(
                      child:
                          viewMode == ViewMode.teams
                              ? teamsListView
                              : competitionsListView,
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
