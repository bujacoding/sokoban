import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sokoban/game/sokoban_game.dart';
import 'package:swipe/swipe.dart';

import '../../widget/game_debug_controller.dart';
import '../../widget/game_pad.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final gamePadController = GamePadController();
  final gameController = GameDebugController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Swipe(
      onSwipeUp: () => gamePadController.move(Vector2(0, -1)),
      onSwipeDown: () => gamePadController.move(Vector2(0, 1)),
      onSwipeLeft: () => gamePadController.move(Vector2(-1, 0)),
      onSwipeRight: () => gamePadController.move(Vector2(1, 0)),
      verticalMinDisplacement: 1,
      horizontalMinDisplacement: 1,
      child: Stack(
        children: [
          GameWidget(
              game: SokobanGame(
            context,
            initialLevel: 1,
            gameDebugController: gameController,
            gamePadController: gamePadController,
          )),
          if (kDebugMode)
            Align(
                alignment: Alignment.topCenter,
                child:
                    GameDebugControllerWidget(gameController: gameController)),
          Align(
              alignment: Alignment.bottomLeft,
              child: GamePadWidget(controller: gamePadController)),
        ],
      ),
    )));
  }
}
