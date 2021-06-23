import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac/Screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MaterialApp(
        home: Scaffold(
          body: SafeArea(child: HomeScreen()),
        ),
      ),
    );
  }
}
