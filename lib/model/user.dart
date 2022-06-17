class User {
  int? id;
  String name;
  String nim;
  String location;
  String subject;
  String date;

  User({
    this.id,
    required this.name,
    required this.nim,
    required this.location,
    required this.subject,
    required this.date,
  });

  User.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        name = data["name"],
        nim = data["nim"],
        location = data["location"],
        date = data["subject"],
        subject = data["date"];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "name": name,
      "nim": nim,
      "location": location,
      "subject": subject,
      "date": date,
    };
  }
}
