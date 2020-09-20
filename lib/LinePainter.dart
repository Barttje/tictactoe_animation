import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class LinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final double width;
  final Color color;
  LinePainter(this.start, this.end, this.width, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    createPath(canvas, start, end);
  }

  void createPath(final Canvas canvas, final Offset start, final Offset end) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = width;
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
