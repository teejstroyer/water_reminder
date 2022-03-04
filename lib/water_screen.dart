import 'package:flutter/material.dart';
import 'package:water_reminder/animated_water.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({Key? key}) : super(key: key);

  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  final Color waterColor = const Color(0xFF1E90FF);
  final double waveHeight = 100;

  final int _maxOunces = 240;

  int _ouncesDrunk = 580;
  int _ouncesInput = 24;

  @override
  Widget build(BuildContext context) {
    //Doing this conversion because there is a bug in the rendering library
    return Scaffold(
      appBar: AppBar(title: const Text('Water Reminder')),
      body: LayoutBuilder(builder: (context, constraints) {
        var maxHeight = constraints.biggest.height - waveHeight;
        int height = ((_ouncesDrunk / _maxOunces) * maxHeight)
            .clamp(0, maxHeight - 10)
            .toInt();
        return Stack(children: [
          getWater(height),
          Align(
						alignment:Alignment.center,
            child: Column(
							mainAxisSize: MainAxisSize.min,
              children: [
                Row(
							mainAxisSize: MainAxisSize.min,
                  children: [
											Column(children: [
												Text(_ouncesDrunk.toString(), style: const TextStyle(color: Colors.black, fontSize: 50),),
												Text(_maxOunces.toString(), style: const TextStyle(color: Colors.black, fontSize: 50),)
											],),
                    Text(
                      ((_ouncesDrunk / _maxOunces) * 100).toStringAsFixed(0) + "%",
                      style: const TextStyle(color: Colors.black, fontSize: 105),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]);
      }),
    );
  }

  void addWater(bool positive) {
    setState(() => _ouncesDrunk += (positive ? 1 : -1) * _ouncesInput);
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
