import 'package:flutter/material.dart';
import 'package:tictactoe_animation/TicTacToeHome.dart';

void main() {
  runApp(TicTacToeMain());
}

class TicTacToeMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TicTacToeHome(title: 'Tic Tac Toe'),
    );
  }
}
