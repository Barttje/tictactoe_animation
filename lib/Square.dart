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
  double top;
  double left;

  @override
  void initState() {
    super.initState();
    left = widget.model.x * (axisWidth + widget.model.width);
    top = widget.model.y * (axisWidth + widget.model.width);
  }

  void update(Player player) {
    setState(() {
      widget.model.player = player;
    });
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
          widget.model.callback(widget.model.x, widget.model.y);
        },
        child: Container(
          color: Colors.transparent,
          width: widget.model.width,
          height: widget.model.width,
        ),
      );

  Widget circle() => CustomPaint(
        painter: CirclePainter(),
        child: Container(
          width: widget.model.width,
          height: widget.model.width,
        ),
      );

  Widget cross() => CustomPaint(
        painter: CrossPainter(),
        child: Container(
          width: widget.model.width,
          height: widget.model.width,
        ),
      );
}
