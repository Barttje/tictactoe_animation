import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class CrossPainter extends CustomPainter {
  double radius = 0;

  @override
  void paint(Canvas canvas, Size size) {
    radius = min(size.height, size.width) / 2 - 10;
    Offset center = Offset(size.width / 2, size.height / 2);

    var crossAngle = math.pi / 4;
    var crossAngle2 = math.pi / 4 * 3;
    createPath(canvas, center, crossAngle);
    createPath(canvas, center, crossAngle2);
  }

  void createPath(
      final Canvas canvas, final Offset center, final double startingAngle) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 15;
    var angle = math.pi;

    Offset firstPoint = Offset(
        radius * math.cos(startingAngle), radius * math.sin(startingAngle));
    Offset secondPoint = Offset(radius * math.cos(startingAngle + angle),
        radius * math.sin(startingAngle + angle));
    Offset firstActualPoint =
        Offset(firstPoint.dx + center.dx, firstPoint.dy + center.dy);
    Offset secondActualPoint =
        Offset(secondPoint.dx + center.dx, secondPoint.dy + center.dy);
    canvas.drawLine(firstActualPoint, secondActualPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
