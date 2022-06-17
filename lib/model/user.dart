class UserAttendance {
  int id;
  String name;
  String nim;
  String location;
  String subject;
  String date;

  UserAttendance(
      this.id, this.name, this.date, this.location, this.nim, this.subject);
  factory UserAttendance.fromJson(dynamic json) {
    return UserAttendance(
        json['id'] as int,
        json['name'] as String,
        json['nim'] as String,
        json['location'] as String,
        json['subject'] as String,
        json['date'] as String);
  }
  @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.date}, ${this.location}, ${this.nim}, ${this.subject} }';
  }
}
