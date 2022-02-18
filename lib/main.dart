import 'dart:async';

import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int maxOunces = 120;

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(title: Text(widget.title));
    var maxHeight =
        MediaQuery.of(context).size.height - appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          //growingContainer(_counter / maxOunces, maxHeight),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedWater(
                color: Colors.blue,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  width: double.infinity,
                  height:
                      (_counter / maxOunces * maxHeight).clamp(0, maxHeight),
                  curve: Curves.linear,
                  //decoration: const BoxDecoration(color: Colors.blue
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  AnimatedContainer growingContainer(double percentage, double maxHeight) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: double.infinity,
      height: (percentage * maxHeight).clamp(0, maxHeight),
      curve: Curves.linear,
    );
  }

  void _incrementCounter() => setState(() => _counter += 10);
}

class AnimatedWater extends StatefulWidget {
  final Color color;
  final Widget child;
  const AnimatedWater({Key? key, required this.color, required this.child})
      : super(key: key);

  @override
  _AnimatedWaterState createState() => _AnimatedWaterState();
}

class _AnimatedWaterState extends State<AnimatedWater>
    with TickerProviderStateMixin {
  late AnimationController firstController;
  late Animation<double> firstAnimation;

  late AnimationController secondController;
  late Animation<double> secondAnimation;

  late AnimationController thirdController;
  late Animation<double> thirdAnimation;

  late AnimationController fourthController;
  late Animation<double> fourthAnimation;

  @override
  void initState() {
    super.initState();

    firstController = AnimationController( vsync: this, duration: const Duration(milliseconds: 1500));
    secondController = AnimationController( vsync: this, duration: const Duration(milliseconds: 1500));
    thirdController = AnimationController( vsync: this, duration: const Duration(milliseconds: 1500));
    fourthController = AnimationController( vsync: this, duration: const Duration(milliseconds: 1500));

		firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(CurvedAnimation(parent: firstController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          firstController.forward();
        }
      });

    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: secondController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController.forward();
        }
      });

    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: thirdController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          thirdController.forward();
        }
      });

    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: fourthController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fourthController.forward();
        }
      });

    Timer(const Duration(seconds: 2), () {
      firstController.forward();
    });

    Timer(const Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(const Duration(milliseconds: 800), () {
      thirdController.forward();
    });

    fourthController.forward();
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
            painter: WaterPainter(
              firstAnimation.value,
              secondAnimation.value,
              thirdAnimation.value,
              fourthAnimation.value,
              widget.color,
            ),
            child: widget.child),
      ],
    );
  }
}

class WaterPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;
  final Color color;

  WaterPainter(this.firstValue, this.secondValue, this.thirdValue, this.fourthValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var path = Path()
			..moveTo(0, 0)
      ..lineTo(0, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7, size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
