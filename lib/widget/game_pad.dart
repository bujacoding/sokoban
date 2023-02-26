import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game/game_controller.dart';

class GamePadWidget extends StatelessWidget {
  const GamePadWidget({Key? key, required this.controller}) : super(key: key);
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () => controller.move(Vector2(0, -1)),
                  icon: Icon(
                    Icons.arrow_drop_up,
                    color: Colors.white,
                  )),
            ],
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () => controller.move(Vector2(0, 1)),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
