/*
  Holds the class model for the competition object.
*/

class Competition {
  late DateTime startTime, endTime;
  late String name;

  Competition({
    required this.startTime,
    required this.endTime,
    required this.name,
  });

  Competition.fromJson(Map<String, dynamic> json) {
    this.name = json["competitionName"];
    this.startTime = json["start_time"];
    this.endTime = json["end_time"];
  }
}
