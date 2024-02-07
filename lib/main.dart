// main.dart
import 'package:flutter/material.dart';
import 'call_log_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Log App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CallLogScreen(),
    );
  }
}

