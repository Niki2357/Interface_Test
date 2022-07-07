import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.user_id,
    required this.name,
    required this.email,
    required this.profile_pic,
    required this.teacher,
    required this.admin,
    required this.banned,
  });

  int user_id;
  String name;
  String email;
  String profile_pic;
  int teacher;
  int admin;
  int banned;

  factory User.fromJson(Map<String, dynamic> json) => User(
        user_id: json["user_id"],
        name: json["name"],
        email: json["email"],
        profile_pic: json["profile_pic"],
        teacher: json["teacher"],
        admin: json["admin"],
        banned: json["banned"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "name": name,
        "email": email,
        "profile_pic": profile_pic,
        "teacher": teacher,
        "admin": admin,
        "banned": banned,
      };
}
