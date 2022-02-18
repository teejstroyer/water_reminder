import 'package:flutter/widgets.dart';

class WaterPainter extends CustomPainter {
  final double y1;
  final double y2;
  final double y3;
  final double y4;
  final Color color;

  WaterPainter({required this.y1, required this.y2, required this.y3, required this.y4, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height - y1)
      ..cubicTo(
        size.width * .3,
        size.height - y2,
        size.width * .7,
        size.height - y3,
        size.width,
        size.height - y4,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height - y1);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
