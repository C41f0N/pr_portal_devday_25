// /*
//   HOME PAGE
//   ---
//   Shows tables for attendance and competition timings.
//   Allows switching between team attendance and competition views.
//   Includes search functionality for both views.
// */

// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:pr_portal_devday_25/constants/colors.dart';
// import 'package:pr_portal_devday_25/models/competition.dart';
// import 'package:pr_portal_devday_25/models/pr_portal.dart';
// import 'package:pr_portal_devday_25/models/team.dart';
// import 'package:pr_portal_devday_25/utils/utilities.dart';
// import 'package:pr_portal_devday_25/widgets/competition_tile.dart';
// import 'package:pr_portal_devday_25/widgets/mode_switcher.dart';
// import 'package:pr_portal_devday_25/widgets/search_bar.dart';
// import 'package:pr_portal_devday_25/widgets/team_description_dialogue.dart';
// import 'package:pr_portal_devday_25/widgets/team_tile.dart';
// import 'package:provider/provider.dart';

// import '../data/data.dart';

// enum ViewMode { teams, competitions }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<Competition>? competitions = [];
//   final TextEditingController controller = TextEditingController();
//   ViewMode viewMode = ViewMode.teams;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<List<Team>?> getTeamList() async {
//     var data = Data();
//     return await data.getTeamList(context);
//   }

//   Future<List<Competition>?> getCompetitionsList() async {
//     var data = Data();
//     return await data.getCompetitionsList(context);
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     Widget teamsListView = FutureBuilder(
//       future: getTeamList(),
//       builder: (context, future) {
//         if (future.connectionState == ConnectionState.done) {
//           if (future.data == null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("An unknown error occcoured"),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {});
//                     },
//                     child: Text("Retry"),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             List<Team> teams = future.data!;

//             teams.removeWhere((team) {
//               return !team.name.toLowerCase().contains(
//                     controller.text.toLowerCase(),
//                   ) &&
//                   !team.leader.toLowerCase().contains(
//                     controller.text.toLowerCase(),
//                   );
//             });

//             return ListView.separated(
//               padding: EdgeInsets.only(bottom: 20),
//               itemCount: teams.length,
//               itemBuilder: (context, index) {
//                 return TeamTile(
//                   team: teams[index],
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder:
//                           (context) =>
//                               TeamDescriptionDialogue(team: teams[index]),
//                     );
//                   },
//                   onChanged: (x) {
//                     showDialog(
//                       context: context,
//                       builder:
//                           (context) => AlertDialog(
//                             title: Text(
//                               'Are you sure?',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             content:
//                                 teams[index].attendance
//                                     ? Text(
//                                       'Mark ${teams[index].name} as ABSENT??',
//                                     )
//                                     : Text(
//                                       'Mark ${teams[index].name} as PRESENT?',
//                                     ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             actions: [
//                               ElevatedButton(
//                                 onPressed: () async {
//                                   String? result =
//                                       teams[index].attendance
//                                           ? await Data().unmarkAttendance(
//                                             context,
//                                             teams[index],
//                                           )
//                                           : await Data().markAttendance(
//                                             context,
//                                             teams[index],
//                                           );

//                                   if (result == "FAILED") {
//                                     Navigator.pop(context); // Close dialog
//                                     showDialog(
//                                       context: context,
//                                       builder:
//                                           (context) => AlertDialog(
//                                             title: Text(
//                                               "Something went wrong.",
//                                             ),
//                                             actions: [
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(
//                                                     context,
//                                                   ); // Close dialog
//                                                 },
//                                                 child: Text("Okay"),
//                                               ),
//                                             ],
//                                           ),
//                                     );
//                                   } else {
//                                     setState(() {});
//                                     Navigator.pop(context); // Close dialog
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: CustomColors().lightRed,
//                                   foregroundColor: Colors.white,
//                                 ),
//                                 child: Text('Yes'),
//                               ),
//                               TextButton(
//                                 onPressed:
//                                     () =>
//                                         Navigator.pop(context), // Cancel action
//                                 child: Text(
//                                   'Cancel',
//                                   style: TextStyle(color: Colors.red),
//                                 ),
//                               ),
//                             ],
//                           ),
//                     );
//                   },
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return SizedBox(height: 16);
//               },
//             );
//           }
//         }

//         return Center(child: CircularProgressIndicator());
//       },
//     );

//     Widget competitionsListView = FutureBuilder(
//       future: getCompetitionsList(),
//       builder: (context, future) {
//         if (future.connectionState == ConnectionState.done) {
//           if (future.data == null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("An unknown error occcoured"),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {});
//                     },
//                     child: Text("Retry"),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             List<Competition> competitions = future.data!;
//             competitions.removeWhere((competition) {
//               return !competition.name.toLowerCase().contains(
//                 controller.text.toLowerCase(),
//               );
//             });
//             return ListView.separated(
//               padding: EdgeInsets.only(bottom: 20),
//               itemCount: competitions.length,
//               itemBuilder: (context, index) {
//                 return CompetitionTile(
//                   competition: competitions[index],
//                   onTimeUpdate: (
//                     DateTime newStartTime,
//                     DateTime newEndTime,
//                   ) async {
//                     // show loading indicator
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Updating competition time...')),
//                     );

//                     // call the API to update the competition time
//                     bool success = await Data().updateCompetitionTime(
//                       context,
//                       competitions[index].name,
//                       newStartTime,
//                       newEndTime,
//                     );

//                     if (success) {
//                       // refresh the list to show updated times
//                       setState(() {
//                         // force refresh
//                       });

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             'Competition time updated successfully',
//                           ),
//                         ),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Failed to update competition time'),
//                         ),
//                       );
//                     }
//                   },
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return SizedBox(height: 16);
//               },
//             );
//           }
//         }

//         return Center(child: CircularProgressIndicator());
//       },
//     );

//     return Consumer<PRPortal>(
//       builder: (context, prPortal, widget1) {
//         double paddingRatio = isHorizontal(context) ? 0.4 : 0.1;

//         return SafeArea(
//           child: Scaffold(
//             backgroundColor: CustomColors().bg,
//             body: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: width * paddingRatio / 2,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: height * 0.15,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Transform.scale(
//                           alignment: Alignment.centerLeft,
//                           scale: isHorizontal(context) ? 1.25 : 1,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(90),
//                                 child: CircleAvatar(
//                                   foregroundColor: Colors.white,
//                                   child: Transform.translate(
//                                     offset: Offset(0, 5),
//                                     child: Transform.scale(
//                                       scale: 1.8,
//                                       child: Icon(Icons.person),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 15),
//                               Text(
//                                 "${prPortal.username!}",
//                                 style: TextStyle(
//                                   color: CustomColors().lightRed,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Transform.scale(
//                           alignment: Alignment.centerRight,
//                           scale: isHorizontal(context) ? 1.25 : 1,
//                           child: CircleAvatar(
//                             backgroundColor: CustomColors().darkRed,
//                             child: IconButton(
//                               color: Colors.white,
//                               iconSize: 20,
//                               onPressed: () {
//                                 showDialog(
//                                   context: context,
//                                   builder:
//                                       (context) => AlertDialog(
//                                         title: Text(
//                                           "Are you sure you want to logout?",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 24,
//                                           ),
//                                         ),
//                                         actions: [
//                                           ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                               foregroundColor: Colors.white,
//                                               backgroundColor:
//                                                   CustomColors().lightRed,
//                                             ),
//                                             onPressed: () {
//                                               prPortal.setLoggedIn(false, null);
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: Text("Yes"),
//                                           ),
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: Text("No"),
//                                           ),
//                                         ],
//                                       ),
//                                 );
//                               },
//                               icon: Icon(Icons.logout),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: height * 0.2,
//                     // color: Colors.pink,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ModeSwitcher(
//                           width:
//                               MediaQuery.of(context).size.width -
//                               width * paddingRatio,

//                           thumbColor: Theme.of(context).colorScheme.primary,
//                           mode: viewMode == ViewMode.teams,
//                           onChanged: (x) {
//                             setState(() {
//                               viewMode =
//                                   x ? ViewMode.teams : ViewMode.competitions;
//                             });
//                           },
//                         ),

//                         CustomSearchBar(
//                           controller: controller,
//                           onChanged: (s) {
//                             setState(() {});
//                           },
//                         ),
//                       ],
//                     ),
//                   ),

//                   ClipRect(
//                     child: Container(
//                       // color: Colors.blue,
//                       height: height * 0.65,
//                       child: CustomMaterialIndicator(
//                         onRefresh: () async {
//                           setState(() {});
//                         },
//                         // backgroundColor: Colors.transparent,
//                         indicatorBuilder: (context, controller) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: CircularProgressIndicator(
//                               // backgroundColor: Colors.transparent,
//                               color: Colors.redAccent,
//                             ),
//                           );
//                         },
//                         child: Container(
//                           child:
//                               viewMode == ViewMode.teams
//                                   ? teamsListView
//                                   : competitionsListView,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//------------------------------------------------------------------

// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:pr_portal_devday_25/constants/colors.dart';
// import 'package:pr_portal_devday_25/models/competition.dart';
// import 'package:pr_portal_devday_25/models/pr_portal.dart';
// import 'package:pr_portal_devday_25/models/team.dart';
// import 'package:pr_portal_devday_25/utils/utilities.dart';
// import 'package:pr_portal_devday_25/widgets/competition_tile.dart';
// import 'package:pr_portal_devday_25/widgets/mode_switcher.dart';
// import 'package:pr_portal_devday_25/widgets/search_bar.dart';
// import 'package:pr_portal_devday_25/widgets/team_description_dialogue.dart';
// import 'package:pr_portal_devday_25/widgets/team_tile.dart';
// import 'package:provider/provider.dart';

// import '../data/data.dart';

// enum ViewMode { teams, competitions }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<Competition>? competitions = [];
//   final TextEditingController controller = TextEditingController();
//   ViewMode viewMode = ViewMode.teams;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<List<Team>?> getTeamList() async {
//     var data = Data();
//     return await data.getTeamList(context);
//   }

//   Future<List<Competition>?> getCompetitionsList() async {
//     var data = Data();
//     return await data.getCompetitionsList(context);
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     Widget teamsListView = FutureBuilder(
//       future: getTeamList(),
//       builder: (context, future) {
//         if (future.connectionState == ConnectionState.done) {
//           if (future.data == null) {
//             return _buildErrorWidget();
//           } else {
//             List<Team> teams = future.data!;

//             teams.removeWhere((team) {
//               return !team.name.toLowerCase().contains(
//                     controller.text.toLowerCase(),
//                   ) &&
//                   !team.leader.toLowerCase().contains(
//                     controller.text.toLowerCase(),
//                   );
//             });

//             return ListView.separated(
//               padding: const EdgeInsets.only(bottom: 20),
//               itemCount: teams.length,
//               itemBuilder: (context, index) {
//                 return TeamTile(
//                   team: teams[index],
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => TeamDescriptionDialogue(team: teams[index]),
//                     );
//                   },
//                   onChanged: (x) {
//                     _showAttendanceConfirmDialog(teams[index]);
//                   },
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const SizedBox(height: 16);
//               },
//             );
//           }
//         }

//         return const Center(child: CircularProgressIndicator());
//       },
//     );

//     Widget competitionsListView = FutureBuilder(
//       future: getCompetitionsList(),
//       builder: (context, future) {
//         if (future.connectionState == ConnectionState.done) {
//           if (future.data == null) {
//             return _buildErrorWidget();
//           } else {
//             List<Competition> competitions = future.data!;
//             competitions.removeWhere((competition) {
//               return !competition.name.toLowerCase().contains(
//                 controller.text.toLowerCase(),
//               );
//             });
//             return ListView.separated(
//               padding: const EdgeInsets.only(bottom: 20),
//               itemCount: competitions.length,
//               itemBuilder: (context, index) {
//                 return CompetitionTile(
//                   competition: competitions[index],
//                   onTimeUpdate: (
//                     DateTime newStartTime,
//                     DateTime newEndTime,
//                   ) async {
//                     await _updateCompetitionTime(
//                       competitions[index].name,
//                       newStartTime,
//                       newEndTime,
//                     );
//                   },
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const SizedBox(height: 16);
//               },
//             );
//           }
//         }

//         return const Center(child: CircularProgressIndicator());
//       },
//     );

//     return Consumer<PRPortal>(

//       builder: (context, prPortal, _) {
//         double paddingRatio = isHorizontal(context) ? 0.4 : 0.1;

//         return SafeArea(
//           child: Scaffold(
//             backgroundColor: CustomColors().bg,
//             body: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: width * paddingRatio / 2,
//               ),
//               child: Column(
//                 children: [
//                   // Header section with profile and logout
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: height * 0.05),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildProfileSection(prPortal),
//                         _buildLogoutButton(prPortal),
//                       ],
//                     ),
//                   ),

//                   // Mode switcher and search bar section
//                   Padding(
//                     padding: EdgeInsets.only(top: height * 0.0025, bottom: height * 0.025),
//                     child: Column(
//                       children: [
//                         ModeSwitcher(
//                           width: MediaQuery.of(context).size.width - width * paddingRatio,
//                           thumbColor: Theme.of(context).colorScheme.primary,
//                           mode: viewMode == ViewMode.teams,
//                           onChanged: (x) {
//                             setState(() {
//                               viewMode = x ? ViewMode.teams : ViewMode.competitions;
//                             });
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         CustomSearchBar(
//                           controller: controller,
//                           onChanged: (s) {
//                             setState(() {});
//                           },
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Content list view - Expanded to take available space
//                   Expanded(
//                     child: CustomMaterialIndicator(
//                       onRefresh: () async {
//                         setState(() {});
//                       },
//                       indicatorBuilder: (context, controller) {
//                         return const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: CircularProgressIndicator(
//                             color: Colors.redAccent,
//                           ),
//                         );
//                       },
//                       child: viewMode == ViewMode.teams
//                         ? teamsListView
//                         : competitionsListView,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildProfileSection(PRPortal prPortal) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(90),
//           child: const CircleAvatar(
//             foregroundColor: Colors.white,
//             child: Icon(Icons.person, size: 24),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Text(
//           "${prPortal.username!}",
//           style: TextStyle(
//             color: CustomColors().lightRed,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLogoutButton(PRPortal prPortal) {
//     return CircleAvatar(
//       backgroundColor: CustomColors().darkRed,
//       child: IconButton(
//         color: Colors.white,
//         iconSize: 20,
//         onPressed: () => _showLogoutConfirmDialog(prPortal),
//         icon: const Icon(Icons.logout),
//       ),
//     );
//   }

//   Widget _buildErrorWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text("An unknown error occurred"),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {});
//             },
//             child: const Text("Retry"),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showLogoutConfirmDialog(PRPortal prPortal) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text(
//           "Are you sure you want to logout?",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//           ),
//         ),
//         actions: [
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.white,
//               backgroundColor: CustomColors().lightRed,
//             ),
//             onPressed: () {
//               prPortal.setLoggedIn(false, null);
//               Navigator.of(context).pop();
//             },
//             child: const Text("Yes"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text("No"),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAttendanceConfirmDialog(Team team) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text(
//           'Are you sure?',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: team.attendance
//             ? Text('Mark ${team.name} as ABSENT??')
//             : Text('Mark ${team.name} as PRESENT?'),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () async {
//               String? result = team.attendance
//                   ? await Data().unmarkAttendance(context, team)
//                   : await Data().markAttendance(context, team);

//               if (result == "FAILED") {
//                 Navigator.pop(context);
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: const Text("Something went wrong."),
//                     actions: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Okay"),
//                       ),
//                     ],
//                   ),
//                 );
//               } else {
//                 setState(() {});
//                 Navigator.pop(context);
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: CustomColors().lightRed,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Yes'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text(
//               'Cancel',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _updateCompetitionTime(
//     String competitionName,
//     DateTime newStartTime,
//     DateTime newEndTime,
//   ) async {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Updating competition time...')),
//     );

//     bool success = await Data().updateCompetitionTime(
//       context,
//       competitionName,
//       newStartTime,
//       newEndTime,
//     );

//     if (success) {
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Competition time updated successfully'),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Failed to update competition time'),
//         ),
//       );
//     }
//   }
// }
//-----------------------------------------------------------------------

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
  // Data lists
  List<Team> teamsList = [];
  List<Competition> competitionsList = [];
  List<Team> filteredTeams = [];
  List<Competition> filteredCompetitions = [];

  // UI state
  bool isLoading = true;
  bool isError = false;
  final TextEditingController controller = TextEditingController();
  ViewMode viewMode = ViewMode.teams;

  @override
  void initState() {
    super.initState();
    // Load data once when widget initializes
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    var data = Data();

    try {
      // Load teams data
      final teams = await data.getTeamList(context);
      if (teams != null) {
        setState(() {
          teamsList = teams;
          filteredTeams = teams;
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
        });
      }

      // Load competitions data
      final competitions = await data.getCompetitionsList(context);
      if (competitions != null) {
        setState(() {
          competitionsList = competitions;
          filteredCompetitions = competitions;
        });
      } else {
        setState(() {
          isError = true;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterData() {
    final searchTerm = controller.text.toLowerCase();

    setState(() {
      // Filter teams
      filteredTeams =
          teamsList.where((team) {
            return team.name.toLowerCase().contains(searchTerm) ||
                team.leader.toLowerCase().contains(searchTerm);
          }).toList();

      // Filter competitions
      filteredCompetitions =
          competitionsList.where((competition) {
            return competition.name.toLowerCase().contains(searchTerm);
          }).toList();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget teamsListView = _buildTeamsListView();
    Widget competitionsListView = _buildCompetitionsListView();

    return Consumer<PRPortal>(
      builder: (context, prPortal, _) {
        double paddingRatio = isHorizontal(context) ? 0.4 : 0.1;

        return SafeArea(
          child: Scaffold(
            backgroundColor: CustomColors().bg,
            body: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    Color(0xff3e0c0b), // Maroon in the middle
                    Colors.black, // Black on the outside
                  ],
                  stops: [0.3, 1.0],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * paddingRatio / 2,
                ),
                child: Column(
                  children: [
                    // Header section with profile and logout
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildProfileSection(prPortal),
                          _buildLogoutButton(prPortal),
                        ],
                      ),
                    ),

                    // Mode switcher and search bar section
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.0025,
                        bottom: height * 0.025,
                      ),
                      child: Column(
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
                          const SizedBox(height: 16),
                          CustomSearchBar(
                            controller: controller,
                            onChanged: (s) {
                              _filterData(); // Apply search filter to local data
                            },
                          ),
                        ],
                      ),
                    ),

                    // Content list view - Expanded to take available space
                    Expanded(
                      child: CustomMaterialIndicator(
                        onRefresh: () async {
                          await _loadData(); // Reload data from API on refresh
                        },
                        indicatorBuilder: (context, controller) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.redAccent,
                            ),
                          );
                        },
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
          ),
        );
      },
    );
  }

  Widget _buildTeamsListView() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return _buildErrorWidget();
    }

    if (filteredTeams.isEmpty) {
      return const Center(child: Text("No teams match your search"));
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: filteredTeams.length,
      itemBuilder: (context, index) {
        return TeamTile(
          team: filteredTeams[index],
          onTap: () {
            showDialog(
              context: context,
              builder:
                  (context) =>
                      TeamDescriptionDialogue(team: filteredTeams[index]),
            );
          },
          onChanged: (x) {
            _showAttendanceConfirmDialog(filteredTeams[index]);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16);
      },
    );
  }

  Widget _buildCompetitionsListView() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return _buildErrorWidget();
    }

    if (filteredCompetitions.isEmpty) {
      return const Center(child: Text("No competitions match your search"));
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: filteredCompetitions.length,
      itemBuilder: (context, index) {
        return CompetitionTile(
          competition: filteredCompetitions[index],
          onTimeUpdate: (DateTime newStartTime, DateTime newEndTime) async {
            await _updateCompetitionTime(
              filteredCompetitions[index].name,
              newStartTime,
              newEndTime,
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16);
      },
    );
  }

  Widget _buildProfileSection(PRPortal prPortal) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: const CircleAvatar(
            foregroundColor: Colors.white,
            child: Icon(Icons.person, size: 24),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          "${prPortal.username!}",
          style: TextStyle(
            color: CustomColors().lightRed,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(PRPortal prPortal) {
    return CircleAvatar(
      backgroundColor: CustomColors().darkRed,
      child: IconButton(
        color: Colors.white,
        iconSize: 20,
        onPressed: () => _showLogoutConfirmDialog(prPortal),
        icon: const Icon(Icons.logout),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("An unknown error occurred"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _loadData(); // Retry loading data
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmDialog(PRPortal prPortal) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              "Are you sure you want to logout?",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: CustomColors().lightRed,
                ),
                onPressed: () {
                  prPortal.setLoggedIn(false, null);
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
            ],
          ),
    );
  }

  void _showAttendanceConfirmDialog(Team team) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              'Are you sure?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content:
                team.attendance
                    ? Text('Mark ${team.name} as ABSENT??')
                    : Text('Mark ${team.name} as PRESENT?'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => Center(child: CircularProgressIndicator()),
                  );
                  String? result =
                      team.attendance
                          ? await Data().unmarkAttendance(context, team)
                          : await Data().markAttendance(context, team);

                  if (result == "FAILED") {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text("Something went wrong."),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Okay"),
                              ),
                            ],
                          ),
                    );
                  } else {
                    Navigator.pop(context);
                    // Update the team in our local lists
                    int teamIndex = teamsList.indexWhere(
                      (t) => t.name == team.name,
                    );
                    if (teamIndex != -1) {
                      setState(() {
                        teamsList[teamIndex].attendance = !team.attendance;
                        // Re-filter to update the filtered list
                        _filterData();
                      });
                    }
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors().lightRed,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _updateCompetitionTime(
    String competitionName,
    DateTime newStartTime,
    DateTime newEndTime,
  ) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Updating competition time...')),
    );

    bool success = await Data().updateCompetitionTime(
      context,
      competitionName,
      newStartTime,
      newEndTime,
    );

    if (success) {
      // Update the competition in our local lists
      int compIndex = competitionsList.indexWhere(
        (c) => c.name == competitionName,
      );
      if (compIndex != -1) {
        setState(() {
          competitionsList[compIndex].startTime = newStartTime;
          competitionsList[compIndex].endTime = newEndTime;
          // Re-filter to update the filtered list
          _filterData();
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Competition time updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update competition time')),
      );
    }
  }
}
