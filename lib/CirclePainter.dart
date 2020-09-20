import 'dart:math';

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  double outerBorder = 15;

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => false;

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.height, size.width) / 2 - 10;
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(
        center,
        radius - (outerBorder) / 2,
        Paint()
          ..color = Colors.orange
          ..strokeWidth = outerBorder
          ..style = PaintingStyle.stroke);
  }
}
