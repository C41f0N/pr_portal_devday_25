/*
  Holds the class model for the team object.
*/
class Team {
  late String consumerNumber;
  late String name;
  late String leader;
  late String leaderEmail;
  String? member1;
  String? member1Email;
  String? member2;
  String? member2Email;
  String? member3;
  String? member3Email;
  String? member4;
  String? member4Email;
  String? att_code;
  late String competition;
  late bool attendance;

  Team({
    required this.consumerNumber,
    required this.name,
    required this.leader,
    required this.leaderEmail,
    this.member1,
    this.member1Email,
    this.member2,
    this.member2Email,
    this.member3,
    this.member3Email,
    this.member4,
    this.member4Email,
    required this.att_code,
    required this.competition,
    required this.attendance,
  });

  Team.fromJson(Map<String, dynamic> json) {
    this.name = json["Team_Name"];
    this.consumerNumber = json["consumerNumber"];
    this.leader = json["Leader_name"];
    this.leaderEmail = json["Leader_email"];
    this.member1 = json["mem1_name"];
    this.member1Email = json['mem1_email'];
    this.member2 = json["mem2_name"];
    this.member2Email = json['mem2_email'];
    this.member3 = json["mem3_name"];
    this.member3Email = json['mem3_email'];
    this.member4 = json["mem4_name"];
    this.member4Email = json['mem4_email'];
    this.att_code = json["att_code"];
    this.competition = json["Competition"];
    this.attendance = json["attendance"] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      "consumerNumber": this.consumerNumber,
      "Team_Name": this.name,
      "Leader_name": this.leader,
      "Leader_email": this.leaderEmail,
      "mem1_name": this.member1,
      'mem1_email': this.member1Email,
      "mem2_name": this.member2,
      'mem2_email': this.member2Email,
      "mem3_name": this.member3,
      'mem3_email': this.member3Email,
      "mem4_name": this.member4,
      'mem4_email': this.member4Email,
      "att_code": this.att_code,
      "Competition": this.competition,
      "attendance": this.attendance,
    };
  }
}
