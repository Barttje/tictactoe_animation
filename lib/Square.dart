import 'package:flutter/material.dart';
import 'package:tictactoe_animation/CirclePainter.dart';
import 'package:tictactoe_animation/CrossPainter.dart';
import 'package:tictactoe_animation/Player.dart';
import 'package:tictactoe_animation/TicTacToeHome.dart';

class SquareModel {
  final int x;
  final int y;
  final double width;
  Function(int, int) callback;
  Player player = Player.empty;
  SquareModel(this.x, this.y, this.callback, this.width);
}

class Square extends StatefulWidget {
  final SquareModel model;
  Square({this.model}) : super(key: GlobalKey<SquareState>());
  @override
  SquareState createState() => SquareState();
}

class SquareState extends State<Square> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  double top;
  double left;

  @override
  void initState() {
    super.initState();
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    left = widget.model.x * (axisWidth + widget.model.width);
    top = widget.model.y * (axisWidth + widget.model.width);
  }

  void update(Player player) {
    setState(() {
      widget.model.player = player;
    });
    controller.forward();
  }

  Widget getChild() {
    switch (widget.model.player) {
      case Player.empty:
        return emptySquare();
        break;
      case Player.player_one:
        return cross();
        break;
      case Player.player_two:
        return circle();
        break;
    }
    throw UnsupportedError("${widget.model.player} is not supported");
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: getChild(),
    );
  }

  Widget emptySquare() => GestureDetector(
        onTap: () {
          print('tap');
          widget.model.callback(widget.model.x, widget.model.y);
        },
        child: Container(
          color: Colors.transparent,
          width: widget.model.width,
          height: widget.model.width,
        ),
      );

  Widget circle() => CustomPaint(
        painter: CirclePainter(animation.value),
        child: Container(
          width: widget.model.width,
          height: widget.model.width,
        ),
      );

  Widget cross() => CustomPaint(
        painter: CrossPainter(animation.value),
        child: Container(
          width: widget.model.width,
          height: widget.model.width,
        ),
      );
}
