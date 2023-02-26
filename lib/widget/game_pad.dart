import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game/game_controller.dart';

class GamePadWidget extends StatelessWidget {
  const GamePadWidget({Key? key, required this.controller}) : super(key: key);
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          children: [
            Visibility(
              visible: false,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child:
                  GameButtonWidget(onPressed: () {}, icon: Icons.arrow_drop_up),
            ),
            GameButtonWidget(
                onPressed: () => controller.move(Vector2(0, -1)),
                icon: Icons.arrow_drop_up),
          ],
        ),
        Row(
          children: [
            GameButtonWidget(
                onPressed: () => controller.move(Vector2(-1, 0)),
                icon: Icons.arrow_left),
            GameButtonWidget(
                onPressed: () => controller.move(Vector2(0, 1)),
                icon: Icons.arrow_drop_down),
            GameButtonWidget(
                onPressed: () => controller.move(Vector2(1, 0)),
                icon: Icons.arrow_right),
          ],
        ),
      ],
    );
  }
}

class GameButtonWidget extends StatelessWidget {
  const GameButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final void Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        iconSize: 70,
        icon: Icon(
          icon,
          color: Colors.white.withOpacity(0.3),
        ));
  }
}
