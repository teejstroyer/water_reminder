import 'package:flutter/widgets.dart';
import 'package:water_reminder/water_painter.dart';

class WaterContainer extends StatelessWidget {
  const WaterContainer({
    Key? key,
    required this.y1,
    required this.y2,
    required this.y3,
    required this.y4,
    required this.color,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double y1;
  final double y2;
  final double y3;
  final double y4;
  final Color color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaterPainter(
        color: color,
        y1: y1,
        y2: y2,
        y3: y3,
        y4: y4,
      ),
      child: SizedBox(height: height, width: width),
    );
  }
}
