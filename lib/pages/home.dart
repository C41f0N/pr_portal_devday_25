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
import 'package:pr_portal_devday_25/models/team.dart';
import 'package:pr_portal_devday_25/widgets/competition_tile.dart';
import 'package:pr_portal_devday_25/widgets/mode_switcher.dart';
import 'package:pr_portal_devday_25/widgets/search_bar.dart';
import 'package:pr_portal_devday_25/widgets/team_tile.dart';

import '../data/data.dart';

enum ViewMode { teams, competitions }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Team> teamList = [];
  List<Competition> compList = [];
  List<Team> filteredTeamList = [];
  List<Competition> filteredCompList = [];
  final TextEditingController controller = TextEditingController();
  ViewMode viewMode = ViewMode.teams;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final data = Data();
      final teams = data.getTeamList();
      final competitions = data.getSampleCompetitions();

      setState(() {
        print(
          '-------------------------------------Setstate called-------------------------------------',
        );
        teamList = teams;
        compList = competitions;
        filteredTeamList = teams;
        filteredCompList = competitions;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to load data: $e';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void filterLists(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredTeamList = teamList;
        filteredCompList = compList;
      });
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    setState(() {
      filteredTeamList =
          teamList.where((team) {
            return team.name.toLowerCase().contains(lowercaseQuery) ||
                team.teamLeader.toLowerCase().contains(lowercaseQuery);
          }).toList();

      filteredCompList =
          compList.where((competition) {
            return competition.name.toLowerCase().contains(lowercaseQuery);
          }).toList();
    });
  }

  Widget _buildTeamsList() {
    if (filteredTeamList.isEmpty) {
      return Center(
        child: Text(
          'No teams found',
          style: TextStyle(color: CustomColors().searchBarText, fontSize: 18),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom: 20),
      itemCount: filteredTeamList.length,
      itemBuilder: (context, index) {
        return TeamTile(
          team: filteredTeamList[index],
          onTap: () {
            // TODO: Implement team selection logic
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 16);
      },
    );
  }

  Widget _buildCompetitionsList() {
    if (filteredCompList.isEmpty) {
      return Center(
        child: Text(
          'No competitions found',
          style: TextStyle(color: CustomColors().searchBarText, fontSize: 18),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom: 20),
      itemCount: filteredCompList.length,
      itemBuilder: (context, index) {
        return CompetitionTile(competition: filteredCompList[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 16);
      },
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error!, style: TextStyle(color: Colors.red, fontSize: 16)),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _loadData, child: Text('Retry')),
          ],
        ),
      );
    }

    return viewMode == ViewMode.teams
        ? _buildTeamsList()
        : _buildCompetitionsList();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors().bg,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ModeSwitcher(
                width: MediaQuery.of(context).size.width - width * 0.1,
                thumbColor: Theme.of(context).colorScheme.primary,
                mode: viewMode == ViewMode.teams,
                onChanged: (x) {
                  setState(() {
                    viewMode = x ? ViewMode.teams : ViewMode.competitions;
                  });
                },
              ),

              CustomSearchBar(controller: controller, onChanged: filterLists),

              SizedBox(
                height: height * 0.75,
                child: Container(child: _buildContent()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
