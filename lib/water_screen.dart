import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  int _ouncesDrunk = 0;
  int _ouncesInput = 24;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Doing this conversion because there is a bug in the rendering library
    return Scaffold(
      appBar: AppBar(title: const Text('Water Reminder')),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: const Icon(Icons.water_drop),
        onPressed: () => _displayWaterInputDialog(context),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        var maxHeight = constraints.biggest.height - waveHeight;
        int height = ((_ouncesDrunk / _maxOunces) * maxHeight)
            .clamp(0, maxHeight - 10)
            .toInt();
        return Stack(children: [
          getWater(height),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Text(
                          _ouncesDrunk.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 50),
                        ),
                        Text(
                          _maxOunces.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 50),
                        )
                      ],
                    ),
                    Text(
                      ((_ouncesDrunk / _maxOunces) * 100).toStringAsFixed(0) +
                          "%",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 105),
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
    int ouncesDrunk = _ouncesDrunk + (positive ? 1 : -1) * _ouncesInput;
    if (ouncesDrunk < 0) ouncesDrunk = 0;
    setState(() {
      _ouncesDrunk = ouncesDrunk;
    });
  }

  Column getWater(int height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedWater(height: waveHeight, color: waterColor),
        AnimatedContainer(
          duration: const Duration(milliseconds: 900),
          height: height.toDouble(),
          color: waterColor,
        ),
      ],
    );
  }

  Future<void> _displayWaterInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('How much water?'),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _ouncesInput = int.tryParse(value) ?? 0;
                });
              },
              controller: _textEditingController,
              decoration:
                  const InputDecoration(hintText: 'amount of water'),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            actions: <Widget>[
              TextButton(
                child:
                    const Text('REMOVE', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  setState(() {
                    addWater(false);
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('CANCEL', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('ADD', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  setState(() {
                    addWater(true);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
