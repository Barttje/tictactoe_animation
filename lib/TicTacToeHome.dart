import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe_animation/GameLogic.dart';
import 'package:tictactoe_animation/LinePainter.dart';
import 'package:tictactoe_animation/Player.dart';
import 'package:tictactoe_animation/RestartWidget.dart';
import 'package:tictactoe_animation/Square.dart';

class TicTacToeHome extends StatefulWidget {
  TicTacToeHome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TicTacToeHomeState createState() => _TicTacToeHomeState();
}

const double axisWidth = 20;

class _TicTacToeHomeState extends State<TicTacToeHome> {
  List<Square> squares = [];
  List<Widget> widgets = [];
  bool isPlayerOne = true;
  double length;
  double size = 0;
  @override
  void initState() {
    super.initState();
  }

  void init(double width, double height) {
    if (widgets.isEmpty) {
      size = min(width, height);
      length = (size - (2 * axisWidth)) / 3;
      resetWidgets();
    }
  }

  void resetWidgets() {
    isPlayerOne = true;
    widgets.clear();
    squares.clear();
    addLines();
    for (int x = 0; x < 3; x++) {
      for (int y = 0; y < 3; y++) {
        squares.add(Square(model: SquareModel(x, y, handleClick, length)));
      }
    }
    widgets.addAll(squares);
  }

  Square getSquare(int x, int y) {
    return squares
        .firstWhere((element) => element.model.x == x && element.model.y == y);
  }

  void addLines() {
    double h1 = length + axisWidth / 2;
    double h2 = 2 * length + axisWidth + axisWidth / 2;

    addLine(new Offset(0, h1), new Offset(size, h1));
    addLine(new Offset(0, h2), new Offset(size, h2));
    addLine(new Offset(h1, 0), new Offset(h1, size));
    addLine(new Offset(h2, 0), new Offset(h2, size));
  }

  void addLine(final Offset start, final Offset end) {
    widgets.add(CustomPaint(
        painter: LinePainter(start, end, axisWidth, Colors.grey[400]),
        child: Container()));
  }

  void handleClick(int x, int y) {
    setState(() {
      GlobalKey<SquareState> key = getSquare(x, y).key;
      if (isPlayerOne) {
        key.currentState.update(Player.player_one);
      } else {
        key.currentState.update(Player.player_two);
      }
    });
    checkIfPlayerWon(Player.player_one);
    checkIfPlayerWon(Player.player_two);
    isPlayerOne = !isPlayerOne;
  }

  void checkIfPlayerWon(Player player) {
    Result result = playerWon(squares, player, length);
    if (result.won) {
      setState(() {
        widgets.add(CustomPaint(
          painter:
              LinePainter(result.begin, result.end, axisWidth, Colors.green),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[RestartWidget(this.resetWidgets)],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: LayoutBuilder(builder: (context, constraints) {
          init(constraints.maxWidth, constraints.maxHeight);
          return Container(
            child: Stack(
              children: widgets,
            ),
          );
        }),
      ),
    );
  }
}
