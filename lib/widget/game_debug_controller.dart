import 'package:flutter/material.dart';

class GameDebugController {
  late Function() _functionOnPreviousLevel;
  late Function() _functionOnNextLevel;

  void previousLevel() {
    _functionOnPreviousLevel.call();
  }

  void nextLevel() {
    _functionOnNextLevel.call();
  }

  void onPreviousLevel(Future Function() functionOnPreviousLevel) {
    _functionOnPreviousLevel = functionOnPreviousLevel;
  }

  void onNextLevel(Future Function() functionOnNextLevel) {
    _functionOnNextLevel = functionOnNextLevel;
  }
}

class GameDebugControllerWidget extends StatelessWidget {
  const GameDebugControllerWidget({
    super.key,
    required this.gameController,
  });

  final GameDebugController gameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => gameController.previousLevel(),
          icon: Icon(Icons.arrow_back, color: Colors.purple),
        ),
        IconButton(
          onPressed: () => gameController.nextLevel(),
          icon: Icon(Icons.arrow_forward, color: Colors.purple),
        ),
      ],
    );
  }
}
