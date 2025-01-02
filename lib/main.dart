import 'package:flutter/material.dart';
import 'package:placement_tasks/task2/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login System App',
      home: LoginScreen(),
    );
  }
}
