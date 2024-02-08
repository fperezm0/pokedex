import 'package:flutter/material.dart';
import 'package:pk/pages/HomeScreen.dart';
import 'package:pk/pages/DetailsScreen.dart';
import "package:get/get.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
