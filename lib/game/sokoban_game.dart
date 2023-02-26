import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sokoban/map/stage.dart';
import 'package:sokoban/page/clear_stage/clear_stage.dart';
import 'package:sokoban/player/player.dart';

import 'game_controller.dart';

class SokobanGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  SokobanGame(
    this.context, {
    required this.initialLevel,
    required this.gameController,
  }) {
    // debugMode = true;
  }

  final BuildContext context;
  final GameController gameController;

  final int initialLevel;
  late int level;

  late Player player;
  late final Stage stage;
  final int maxLevel = 100;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    level = initialLevel;

    player = Player(position: Vector2.zero())..priority = 5;
    add(player);

    stage = Stage(level: level)..priority = 0;
    add(stage);

    stage.onInitialized((startingPoint) {
      var tileSize = stage.tileSize;
      player.position = startingPoint + Vector2(tileSize, tileSize) / 2;
      camera.zoom = 1;
      var viewPort = Vector2(tileSize, tileSize) * 10 * 1.2;
      camera.viewport = FixedResolutionViewport(viewPort);
      camera.moveTo(-Vector2(tileSize, tileSize));
      camera.speed = tileSize * 100;
    });

    stage.onClear(() async {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: ClearStagePopup(level: level),
          );
        },
      );
      print('NEXT GAME');
      stage.initStage(level: nextLevel());
    });

    gameController.onMove((direction) => movePlayerTo(player, direction));

    gameController
        .onPreviousLevel(() => stage.initStage(level: previousLevel()));
    gameController.onNextLevel(() => stage.initStage(level: nextLevel()));
    gameController.onChangeLevel((level) {
      this.level = level;
      stage.initStage(level: level);
    });
  }

  int previousLevel() {
    _changeLevel(-1);
    return level;
  }

  void _changeLevel(int delta) {
    level = (level + delta).clamp(1, maxLevel);
    gameController.levelChanged(level);
  }

  int nextLevel() {
    _changeLevel(1);
    return level;
  }

  bool movePlayerTo(PositionComponent playerComponent, Vector2 direction) {
    return stage.movePlayerTo(playerComponent, direction);
  }
}
