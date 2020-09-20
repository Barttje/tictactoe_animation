import 'dart:ui';

import 'package:tictactoe_animation/Player.dart';
import 'package:tictactoe_animation/Square.dart';
import 'package:tictactoe_animation/TicTacToeHome.dart';

Result playerWon(List<Square> squares, Player player, double length) {
  List<Square> playerSquares =
      squares.where((element) => element.model.player == player).toList();
  for (int i = 0; i < 3; i++) {
    if (playerSquares
            .where((element) => element.model.x == i)
            .toList()
            .length ==
        3) {
      Result result = Result(true);

      result.begin = changeHeight(
          moveToMiddle(mapToCoordinate(i, 0, length), length), -length / 3);
      result.end = changeHeight(
          moveToMiddle(mapToCoordinate(i, 2, length), length), length / 3);

      return result;
    }
    if (playerSquares
            .where((element) => element.model.y == i)
            .toList()
            .length ==
        3) {
      Result result = Result(true);
      result.begin = changeWidth(
          moveToMiddle(mapToCoordinate(0, i, length), length), -length / 3);
      result.end = changeWidth(
          moveToMiddle(mapToCoordinate(2, i, length), length), length / 3);

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
        changeHeight(
            moveToMiddle(mapToCoordinate(0, 0, length), length), -length / 3),
        -length / 3);
    result.end = changeWidth(
        changeHeight(
            moveToMiddle(mapToCoordinate(2, 2, length), length), length / 3),
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
        changeHeight(
            moveToMiddle(mapToCoordinate(0, 2, length), length), length / 3),
        -length / 3);
    result.end = changeWidth(
        changeHeight(
            moveToMiddle(mapToCoordinate(2, 0, length), length), -length / 3),
        length / 4);

    return result;
  }
  return Result(false);
}

Offset mapToCoordinate(int x, int y, double length) {
  return Offset(x * (axisWidth + length), y * (axisWidth + length));
}

Offset moveToMiddle(Offset offset, double length) {
  return Offset(offset.dx + 0.5 * length, offset.dy + 0.5 * length);
}

Offset changeHeight(Offset offset, double y) {
  return Offset(offset.dx, offset.dy + y);
}

Offset changeWidth(Offset offset, double x) {
  return Offset(offset.dx + x, offset.dy);
}

class Result {
  Offset begin;
  Offset end;
  final bool won;
  Result(this.won);
}
