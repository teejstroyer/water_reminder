import 'package:flutter/material.dart';
import 'package:water_reminder/animated_water.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({Key? key}) : super(key: key);

  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  double ouncesDrunk = 0;
  double maxOunces = 240;
  final Color waterColor = const Color(0xFF1E90FF);
  final double waveHeight = 100;

  @override
  Widget build(BuildContext context) {
    //Doing this conversion because there is a bug in the rendering library
    return Scaffold(
      appBar: AppBar(title: const Text('Water Reminder')),
      body: LayoutBuilder(builder: (context, constraints) {
        var maxHeight = constraints.biggest.height - waveHeight;
        int height = ((ouncesDrunk / maxOunces) * maxHeight).clamp(0, maxHeight).toInt();
        return Stack(
          children: [
            getWater(height),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            ouncesDrunk += 20;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Column getWater(int height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedWater(height: waveHeight, color: waterColor),
        AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          height: height.toDouble(),
          color: waterColor,
        ),
      ],
    );
  }
}
