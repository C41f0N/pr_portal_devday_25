/*
  Holds the class model for the competition object.
*/

class Competition {
  DateTime startTime, endTime;
  String name;

  Competition({
    required this.startTime,
    required this.endTime,
    required this.name,
  });
}
