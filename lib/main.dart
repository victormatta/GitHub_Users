import 'package:flutter/material.dart';
import 'pages/home/MainScreen.dart';

void main() => runApp(const GtApp());

class GtApp extends StatelessWidget {
  const GtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}