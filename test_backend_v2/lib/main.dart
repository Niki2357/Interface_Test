// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<User> createUser(String user_id, String name, String email,
    String profilePic, String teacher, String admin, String banned) async {
  final response = await http.post(
    Uri.parse('http://34.73.150.160:5000/user/post'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'user_id': user_id,
      'name': name,
      'email': email,
      'profile_pic': profilePic,
      'teacher': teacher,
      'admin': admin,
      'banned': banned
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class User {
  final String user_id;
  final String name;
  final String email;
  final String profile_pic;
  final String teacher;
  final String admin;
  final String banned;

  const User({
    required this.user_id,
    required this.name,
    required this.email,
    required this.profile_pic,
    required this.teacher,
    required this.admin,
    required this.banned,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json["user_id"],
      name: json["name"],
      email: json["email"],
      profile_pic: json["profile_pic"],
      teacher: json["teacher"],
      admin: json["admin"],
      banned: json["banned"],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Future<User>? _futureUser;

  @override
  TextEditingController userId_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController profilePic_controller = TextEditingController();
  TextEditingController teacher_controller = TextEditingController();
  TextEditingController admin_controller = TextEditingController();
  TextEditingController banned_controller = TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureUser == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Enter user_id"),
          controller: userId_controller,
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Enter name"),
          controller: name_controller,
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Enter email"),
          controller: email_controller,
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Enter profile_pic"),
          controller: profilePic_controller,
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Enter teacher"),
          controller: teacher_controller,
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Enter admin"),
          controller: admin_controller,
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Enter banned"),
          controller: banned_controller,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureUser = createUser(
                  userId_controller.text,
                  name_controller.text,
                  email_controller.text,
                  profilePic_controller.text,
                  teacher_controller.text,
                  admin_controller.text,
                  banned_controller.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}


// Future<User> createUser(String id, String name, String email, String profilePic,
//     String teacher, String admin, String banned) async {
//   final response =
//       await http.post(Uri.parse('http://34.73.150.160:5000/user/post'),
//           body: jsonEncode(<String, String>{
//             'id': id,
//             'name': name,
//             'email': email,
//             'profile_pic': profilePic,
//             'teacher': teacher,
//             'admin': admin,
//             'banned': banned
//           }));
//   var data = response.body;
//   print(data);
//   ;

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return User.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create user.');
//   }
// }

// class User {
//   final String id;
//   final String name;
//   final String email;
//   final String profile_pic;
//   final String teacher;
//   final String admin;
//   final String banned;

//   const User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.profile_pic,
//     required this.teacher,
//     required this.admin,
//     required this.banned,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json["id"],
//       name: json["name"],
//       email: json["email"],
//       profile_pic: json["profile_pic"],
//       teacher: json["teacher"],
//       admin: json["admin"],
//       banned: json["banned"],
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() {
//     return _MyAppState();
//   }
// }

// class _MyAppState extends State<MyApp> {
//   late User _user;

//   TextEditingController id_controller = TextEditingController();
//   TextEditingController name_controller = TextEditingController();
//   TextEditingController email_controller = TextEditingController();
//   TextEditingController profile_pic_controller = TextEditingController();
//   TextEditingController teacher_controller = TextEditingController();
//   TextEditingController admin_controller = TextEditingController();
//   TextEditingController banned_controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Create Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Create Data Example'),
//         ),
//         body: Container(
//             alignment: Alignment.center,
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: const [
//                 TextField(
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), hintText: "Enter id"),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), hintText: "Enter name"),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), hintText: "Enter email"),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter profile_pic"),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), hintText: "Enter teacher"),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), hintText: "Enter admin"),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), hintText: "Enter banned"),

//                 ),
//                 ElevatedButton(
//                     onPressed: () {}
//                     child: Text('Submit'))
//               ],
//             )),
//       ),
//     );
//   }

//   Column buildColumn() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         TextField(
//           controller: _controller,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//                String id = id_controller.text;
//                 String name = name_controller.text;
//                 String email = email_controller.text;
//                 String profile_pic = profile_pic_controller.text;
//                 String teacher = teacher_controller.text;
//                 String admin = admin_controller.text;
//                   String banned = banned_controller.text;
//             });
//           },
//           child: const Text('Create Data'),
//         ),
//       ],
//     );
//   }

//   FutureBuilder<User> buildFutureBuilder() {
//     return FutureBuilder<User>(
//       future: _futureUser,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data!.name);
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }

//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }

////////////////////// get data

// void main() => runApp(const MaterialApp(
//       home: HomePage(),
//       debugShowCheckedModeBanner: false,
//     ));

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   late Future<User> futureUser;

//   @override
//   void initState() {
//     super.initState();
//     futureUser = fetchUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('Fetch data')),
//         body: Center(
//             child: FutureBuilder<User>(
//                 future: futureUser,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Text(snapshot.data!.teacher);
//                   } else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   }
//                   return const CircularProgressIndicator();
//                 })));
//   }
// }

// class User {
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.profile_pic,
//     required this.teacher,
//     required this.admin,
//     required this.banned,
//   });

//   String id;
//   String name;
//   String email;
//   String profile_pic;
//   String teacher;
//   String admin;
//   String banned;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         profile_pic: json["profile_pic"],
//         teacher: json["teacher"],
//         admin: json["admin"],
//         banned: json["banned"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "profile_pic": profile_pic,
//         "teacher": teacher,
//         "admin": admin,
//         "banned": banned,
//       };
// }

// Future<User> fetchUser() async {
//   final response = await http.get(Uri.parse(''));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return User.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load User');
//   }
// }
