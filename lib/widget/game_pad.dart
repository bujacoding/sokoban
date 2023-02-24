import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GamePadController {
  late bool Function(Vector2 direction) _functionOnMove;

  void move(Vector2 direction) {
    _functionOnMove.call(direction);
  }

  void onMove(bool Function(Vector2 direction) functionOnMove) {
    _functionOnMove = functionOnMove;
  }
}

class GamePadWidget extends StatelessWidget {
  const GamePadWidget({Key? key, required this.controller}) : super(key: key);
  final GamePadController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
              onPressed: () => controller.move(Vector2(0, -1)),
              icon: Icon(
                Icons.arrow_drop_up,
                color: Colors.white,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => controller.move(Vector2(-1, 0)),
                  icon: Icon(Icons.arrow_left, color: Colors.white)),
              IconButton(
                  onPressed: () => controller.move(Vector2(1, 0)),
                  icon: Icon(Icons.arrow_right, color: Colors.white)),
            ],
          ),
          IconButton(
              onPressed: () => controller.move(Vector2(0, 1)),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
