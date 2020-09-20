import 'package:flutter/material.dart';

class RestartWidget extends StatelessWidget {
  final Function() callback;
  RestartWidget(this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            onTap: () => callback(),
            child: Icon(
              Icons.refresh,
              size: 30,
            )));
  }
}
