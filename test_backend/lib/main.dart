import 'dart:async';
import 'dart:convert';
import 'package:test_backend/services/remote_services.dart';

import 'model/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<User>? users;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    users = (await RemoteService().getUsers());
    if (users != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fetch Data Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Fetch Data Example'),
          ),
          body: Visibility(
            visible: isLoaded,
            child: ListView.builder(
                itemCount: users?.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Text(users![index].email),
                    // child: Text("hihihihi"),
                  );
                }),
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ));
  }
}
