import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sokoban/game/sokoban_game.dart';
import 'package:swipe/swipe.dart';

import '../../game/game_controller.dart';
import '../../game/game_view_model.dart';
import '../../widget/debug_game.dart';
import '../../widget/game_pad.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    super.key,
    required this.mapType,
  });

  final String mapType;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final gameController = GameController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Level: ${context.watch<GameViewModel>().level}'),
        ),
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
                initialLevel: context.watch<GameViewModel>().level,
                controller: gameController,
                mapType: widget.mapType,
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
