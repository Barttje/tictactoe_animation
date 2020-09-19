import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe_animation/CirclePainter.dart';
import 'package:tictactoe_animation/CrossPainter.dart';
import 'package:tictactoe_animation/LinePainter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Tic Tac Toe Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const double axisWidth = 20;

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
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
      resetWidgets();
    }
  }

  void resetWidgets() {
    widgets.clear();
    squares.clear();
    length = (size - (2 * axisWidth)) / 3;
    var lengthAxis = (size - (2 * axisWidth)) / 3;

    double h1 = length + axisWidth / 2;
    print(h1);
    print(lengthAxis);

    double h2 = 2 * length + axisWidth + axisWidth / 2;
    print(h2);
    print(2 * lengthAxis);

    widgets.add(CustomPaint(
        painter: LinePainter(
            100, Offset(0, h1), Offset(size, h1), axisWidth, Colors.grey[400]),
        child: Container()));
    widgets.add(CustomPaint(
        painter: LinePainter(
            100, Offset(0, h2), Offset(size, h2), axisWidth, Colors.grey[400]),
        child: Container()));
    widgets.add(CustomPaint(
        painter: LinePainter(
            100, Offset(h1, 0), Offset(h1, size), axisWidth, Colors.grey[400]),
        child: Container()));
    widgets.add(CustomPaint(
        painter: LinePainter(
            100, Offset(h2, 0), Offset(h2, size), axisWidth, Colors.grey[400]),
        child: Container()));

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

  Offset mapToCoordinate(int x, int y) {
    return Offset(x * (axisWidth + length), y * (axisWidth + length));
  }

  Offset moveToMiddle(Offset offset) {
    return Offset(offset.dx + 0.5 * length, offset.dy + 0.5 * length);
  }

  Offset changeHeight(Offset offset, double y) {
    return Offset(offset.dx, offset.dy + y);
  }

  Offset changeWidth(Offset offset, double x) {
    return Offset(offset.dx + x, offset.dy);
  }

  void handleClick(int x, int y) {
    setState(() {
      GlobalKey<_SquareState> key = getSquare(x, y).key;
      if (isPlayerOne) {
        key.currentState.update(Player.player_one);
      } else {
        key.currentState.update(Player.player_two);
      }
    });
    Result playerOne = playerWon(Player.player_one);
    if (playerOne.won) {
      setState(() {
        widgets.add(WinningLine(
            model: new WinningLineModel(playerOne.begin, playerOne.end)));
      });
    }
    Result playerTwo = playerWon(Player.player_two);

    if (playerTwo.won) {
      setState(() {
        widgets.add(WinningLine(
            model: new WinningLineModel(playerTwo.begin, playerTwo.end)));
      });
    }
    isPlayerOne = !isPlayerOne;
  }

  Result playerWon(Player player) {
    List<Square> playerSquares =
        squares.where((element) => element.model.player == player).toList();
    for (int i = 0; i < 3; i++) {
      if (playerSquares
              .where((element) => element.model.x == i)
              .toList()
              .length ==
          3) {
        Result result = Result(true);

        result.begin =
            changeHeight(moveToMiddle(mapToCoordinate(i, 0)), -length / 3);
        result.end =
            changeHeight(moveToMiddle(mapToCoordinate(i, 2)), length / 3);

        return result;
      }
      if (playerSquares
              .where((element) => element.model.y == i)
              .toList()
              .length ==
          3) {
        Result result = Result(true);
        result.begin =
            changeWidth(moveToMiddle(mapToCoordinate(0, i)), -length / 3);
        result.end =
            changeWidth(moveToMiddle(mapToCoordinate(2, i)), length / 3);

        return result;
      }
    }
    if (playerSquares
            .where((element) => element.model.y == element.model.x)
            .toList()
            .length ==
        3) {
      Result result = Result(true);
      result.begin = changeWidth(
          changeHeight(moveToMiddle(mapToCoordinate(0, 0)), -length / 3),
          -length / 3);
      result.end = changeWidth(
          changeHeight(moveToMiddle(mapToCoordinate(2, 2)), length / 3),
          length / 3);

      return result;
    }

    if (playerSquares
            .where((element) => 2 - element.model.y == element.model.x)
            .toList()
            .length ==
        3) {
      Result result = Result(true);
      result.begin = changeWidth(
          changeHeight(moveToMiddle(mapToCoordinate(0, 2)), length / 3),
          -length / 3);
      result.end = changeWidth(
          changeHeight(moveToMiddle(mapToCoordinate(2, 0)), -length / 3),
          length / 4);

      return result;
    }
    return Result(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Container(
              child: GestureDetector(
            onTap: () {
              setState(() {
                resetWidgets();
                isPlayerOne = true;
              });
            },
            child: Icon(
              Icons.refresh,
              size: 30,
            ),
          ))
        ],
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

class Result {
  Offset begin;
  Offset end;
  final bool won;
  Result(this.won);
}

class SquareModel {
  final int x;
  final int y;
  final double width;
  Function(int, int) callback;
  Player player = Player.empty;
  SquareModel(this.x, this.y, this.callback, this.width);
}

class WinningLineModel {
  final Offset start;
  final Offset end;

  WinningLineModel(this.start, this.end);
}

enum Player { empty, player_one, player_two }

class Square extends StatefulWidget {
  final SquareModel model;
  Square({this.model}) : super(key: GlobalKey<_SquareState>());
  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<Square> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  double top;
  double left;

  @override
  void initState() {
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
    widget.model.player = player;
    controller.forward();
  }

  Widget getChild() {}

  @override
  Widget build(BuildContext context) {
    if (widget.model.player == Player.player_two) {
      return Positioned(
        top: top,
        left: left,
        child: CustomPaint(
          painter: CirclePainter(animation.value),
          child: Container(
            width: widget.model.width,
            height: widget.model.width,
          ),
        ),
      );
    }
    if (widget.model.player == Player.player_one) {
      return Positioned(
        top: top,
        left: left,
        child: CustomPaint(
          painter: CrossPainter(animation.value),
          child: Container(
            width: widget.model.width,
            height: widget.model.width,
          ),
        ),
      );
    }
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () {
          widget.model.callback(widget.model.x, widget.model.y);
        },
        child: Container(
          color: Colors.transparent,
          width: widget.model.width,
          height: widget.model.width,
        ),
      ),
    );
  }
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
                widget.model.end, 30, Colors.green.withOpacity(0.8)),
            child: Container(),
          );
        });
  }
}
