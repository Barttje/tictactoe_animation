import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class CrossPainter extends CustomPainter {
  final double percentage;
  double radius = 0;
  CrossPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    radius = min(size.height, size.width) / 2 - 10;
    Offset center = Offset(size.width / 2, size.height / 2);

    var crossAngle = (math.pi * 2) / 8;
    var crossAngle2 = crossAngle * 3;
    createPath(canvas, center, crossAngle, min(100, percentage * 2));
    createPath(canvas, center, crossAngle2, max(0, (percentage - 50) * 2));
  }

  void createPath(final Canvas canvas, final Offset center,
      final double startingAngle, final double percentage) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 15;
    var angle = math.pi;

    Offset firstPoint = Offset(
        radius * (percentage / 100) * math.cos(startingAngle),
        radius * (percentage / 100) * math.sin(startingAngle));
    Offset secondPoint = Offset(
        radius * (percentage / 100) * math.cos(startingAngle + angle),
        radius * (percentage / 100) * math.sin(startingAngle + angle));
    Offset firstActualPoint =
        Offset(firstPoint.dx + center.dx, firstPoint.dy + center.dy);
    Offset secondActualPoint =
        Offset(secondPoint.dx + center.dx, secondPoint.dy + center.dy);
    canvas.drawLine(firstActualPoint, secondActualPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
