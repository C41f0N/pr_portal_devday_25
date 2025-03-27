/*
  HOME PAGE
  ---

  Shows tables for attendance and competition timings.
*/

import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/constants/colors.dart';
import 'package:pr_portal_devday_25/models/competition.dart';
import 'package:pr_portal_devday_25/models/team.dart';
import 'package:pr_portal_devday_25/widgets/competition_tile.dart';
import 'package:pr_portal_devday_25/widgets/mode_switcher.dart';
import 'package:pr_portal_devday_25/widgets/search_bar.dart';
import 'package:pr_portal_devday_25/widgets/team_tile.dart';

import '../data/data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Team> teamList = [];
  List<Competition> compList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Data data = Data();
    teamList = data.getTeamList();
    compList = data.getSampleCompetitions();
  }

  TextEditingController controller = TextEditingController();
  bool state = true;

  Widget Teams() {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 20),
      itemCount: teamList.length,
      itemBuilder: (context, index) {
        return TeamTile(
          team: teamList[index],
          onTap: () {
            //?
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: MediaQuery.of(context).size.height * 0.018);
      },
    );
  }

  Widget Competitions() {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 20),
      itemCount: compList.length,
      itemBuilder: (context, index) {
        return CompetitionTile(competition: compList[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: MediaQuery.of(context).size.height * 0.018);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CustomColors().bg,
      body: Column(
        children: [
          SizedBox(height: height * 0.1),
          Expanded(
            flex: 1,
            child: ModeSwitcher(
              width: MediaQuery.of(context).size.width * 0.7,
              // thumbColor: Theme.of(context).colorScheme.primary,
              thumbColor:
                  state
                      ? Theme.of(context).colorScheme.primary
                      : Colors.green.withValues(alpha: 0.5),
              mode: state,
              onChanged: (x) {
                setState(() {
                  state = x;
                  print(state);
                });
              },
            ),
          ),
          SizedBox(height: 10),
          CustomSearchBar(controller: controller),
          SizedBox(height: 20),
          Expanded(
            flex: 8,
            child: Container(child: state ? Teams() : Competitions()),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: SizedBox(
    //       height: MediaQuery.of(context).size.height * 0.5,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           SizedBox(
    //             width: MediaQuery.of(context).size.width * 0.8,
    //             child: CompetitionTile(
    //               backgroundColor: Theme.of(context).colorScheme.primary,
    //               competition: Competition(
    //                 name: "Tech Heist",
    //                 startTime: DateTime.now().subtract(Duration(hours: 1)),
    //                 endTime: DateTime.now().subtract(Duration(hours: 2)),
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             width: MediaQuery.of(context).size.width * 0.8,
    //             child: TeamTile(
    //               backgroundColor: Theme.of(context).colorScheme.primary,
    //               team: Team(
    //                 name: "Proxima",
    //                 teamLeader: "Abdul Ahad",
    //                 present: false,
    //               ),
    //             ),
    //           ),
    //           ModeSwitcher(
    //             width: MediaQuery.of(context).size.width * 0.7,
    //             thumbColor: Theme.of(context).colorScheme.primary,
    //             mode: state,
    //             onChanged: (x) {
    //               setState(() {
    //                 state = x;
    //               });
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
