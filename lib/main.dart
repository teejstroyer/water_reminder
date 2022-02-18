import 'package:flutter/material.dart';
import 'package:water_reminder/animated_water.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AnimatedWater(waveHeight: 100, height: 300, color: Colors.blue),
    );
  }
}
