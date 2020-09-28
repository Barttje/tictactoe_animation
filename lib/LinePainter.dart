import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class LinePainter extends CustomPainter {
  final double percentage;
  final Offset start;
  final Offset end;
  final double width;
  final Color color;
  LinePainter(this.percentage, this.start, this.end, this.width, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Offset to = Offset(start.dx + percentage / 100 * (end.dx - start.dx),
        start.dy + percentage / 100 * (end.dy - start.dy));
    createPath(canvas, start, to);
  }

  void createPath(final Canvas canvas, final Offset start, final Offset end) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = width;
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
