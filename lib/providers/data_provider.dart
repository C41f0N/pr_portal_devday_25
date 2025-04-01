import 'package:flutter/material.dart';
import '../models/team.dart';
import '../models/competition.dart';
import '../data/data.dart';

enum ViewMode { teams, competitions }

class DataProvider extends ChangeNotifier {
  List<Team> _teams = [];
  List<Competition> _competitions = [];
  List<Team> _filteredTeams = [];
  List<Competition> _filteredCompetitions = [];
  ViewMode _viewMode = ViewMode.teams;
  bool _isLoading = true;
  String? _error;

  // Getters
  List<Team> get teams => _teams;
  List<Competition> get competitions => _competitions;
  List<Team> get filteredTeams => _filteredTeams;
  List<Competition> get filteredCompetitions => _filteredCompetitions;
  ViewMode get viewMode => _viewMode;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadData() async {
    try {
      notifyListeners();

      final data = Data();
      // _teams = data.getTeamList();
      // _competitions = data.();
      _filteredTeams = _teams;
      _filteredCompetitions = _competitions;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load data: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  void setViewMode(ViewMode mode) {
    _viewMode = mode;
    notifyListeners();
  }

  void filterData(String query) {
    if (query.isEmpty) {
      _filteredTeams = _teams;
      _filteredCompetitions = _competitions;
      notifyListeners();
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    _filteredTeams =
        _teams.where((team) {
          return team.name.toLowerCase().contains(lowercaseQuery) ||
              team.leader.toLowerCase().contains(lowercaseQuery);
        }).toList();

    _filteredCompetitions =
        _competitions.where((competition) {
          return competition.name.toLowerCase().contains(lowercaseQuery);
        }).toList();

    notifyListeners();
  }
}
