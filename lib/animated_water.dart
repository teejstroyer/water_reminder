import 'dart:async';
import 'package:flutter/material.dart';
import 'package:water_reminder/water_container.dart';

class AnimatedWater extends StatefulWidget {
  final double height;
  final Color color;

  const AnimatedWater({Key? key, required this.height, required this.color}) : super(key: key);

  @override
  State<AnimatedWater> createState() => _AnimatedWaterState();
}

class _AnimatedWaterState extends State<AnimatedWater> with TickerProviderStateMixin {
  late AnimationController _controllerY1;
  late AnimationController _controllerY2;
  late AnimationController _controllerY3;
  late AnimationController _controllerY4;
  late Animation<double> _y1;
  late Animation<double> _y2;
  late Animation<double> _y3;
  late Animation<double> _y4;

  @override
  void initState() {
    super.initState();

    _controllerY1 = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _controllerY2 = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _controllerY3 = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _controllerY4 = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

    _y1 = Tween<double>(begin: 1, end: widget.height).animate(CurvedAnimation(parent: _controllerY1, curve: Curves.easeInOut))
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerY1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controllerY1.forward();
        }
      });

    _y2 = Tween<double>(begin: 1, end: widget.height).animate(CurvedAnimation(parent: _controllerY2, curve: Curves.easeInOut))
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerY2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controllerY2.forward();
        }
      });
    _y3 = Tween<double>(begin: 1, end: widget.height).animate(CurvedAnimation(parent: _controllerY3, curve: Curves.easeInOut))
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerY3.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controllerY3.forward();
        }
      });
    _y4 = Tween<double>(begin: 1, end: widget.height).animate(CurvedAnimation(parent: _controllerY4, curve: Curves.easeInOut))
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerY4.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controllerY4.forward();
        }
      });

    Timer(const Duration(seconds: 2), () {
      _controllerY1.forward();
    });

    Timer(const Duration(milliseconds: 1600), () {
      _controllerY2.forward();
    });

    Timer(const Duration(milliseconds: 800), () {
      _controllerY3.forward();
    });

    _controllerY4.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WaterContainer(
      color: widget.color,
      height: widget.height,
      width: double.infinity,
      y1: widget.height - _y1.value,
      y2: widget.height - _y2.value,
      y3: widget.height - _y3.value,
      y4: widget.height - _y4.value,
    );
  }
}
