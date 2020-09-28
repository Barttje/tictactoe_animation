import 'package:flutter/material.dart';
import 'package:tictactoe_animation/LinePainter.dart';

class WinningLineModel {
  final Offset start;
  final Offset end;

  WinningLineModel(this.start, this.end);
}

class WinningLine extends StatefulWidget {
  final WinningLineModel model;
  const WinningLine({Key key, this.model}) : super(key: key);
  @override
  _WinningLineState createState() => _WinningLineState();
}

class _WinningLineState extends State<WinningLine>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 100),
        duration: Duration(seconds: 1),
        builder: (BuildContext context, double percentage, Widget child) {
          return CustomPaint(
            painter: LinePainter(percentage, widget.model.start,
                widget.model.end, 30, Colors.green),
            child: Container(),
          );
        });
  }
}
