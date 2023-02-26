import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sokoban/game/sokoban_game.dart';
import 'package:swipe/swipe.dart';

import '../../game/game_controller.dart';
import '../../widget/debug_game.dart';
import '../../widget/game_pad.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final gameController = GameController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Swipe(
      onSwipeUp: () => gameController.move(Vector2(0, -1)),
      onSwipeDown: () => gameController.move(Vector2(0, 1)),
      onSwipeLeft: () => gameController.move(Vector2(-1, 0)),
      onSwipeRight: () => gameController.move(Vector2(1, 0)),
      verticalMinDisplacement: 1,
      horizontalMinDisplacement: 1,
      child: Stack(
        children: [
          GameWidget(
              game: SokobanGame(
            context,
            initialLevel: 1,
            gameController: gameController,
          )),
          if (kDebugMode)
            Align(
                alignment: Alignment.topCenter,
                child: DebugGameWidget(controller: gameController)),
          Align(
              alignment: Alignment.bottomLeft,
              child: GamePadWidget(controller: gameController)),
        ],
      ),
    )));
  }
}
