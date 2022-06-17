import 'package:attendance_gps/views/attendace.dart';
import 'package:flutter/material.dart';
import 'package:attendance_gps/views/history.dart';

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
      home: AttendancePage(),
      routes: {
        AttendancePage.routeName: ((context) => AttendancePage()),
        HistoryPage.routeName: (context) => HistoryPage()
      },
    );
  }
}
