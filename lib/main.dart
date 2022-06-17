import 'package:attendance_gps/views/attendace.dart';
import 'package:attendance_gps/views/home.dart';
import 'package:attendance_gps/views/test.dart';
import 'package:flutter/material.dart';
import 'package:attendance_gps/views/user.dart';
import 'package:provider/provider.dart';

import 'model/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyLocation(),
      // AttendancePage(),
      routes: {
        AttendancePage.routeName: ((context) => AttendancePage()),
        HomePage.routeName: (context) => HomePage(),
        UserPage.routeName: (context) => UserPage()
      },
    );
  }
}
