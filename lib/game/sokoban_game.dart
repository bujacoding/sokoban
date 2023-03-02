import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sokoban/stage/stage.dart';
import 'package:sokoban/page/clear_stage/clear_stage.dart';
import 'package:sokoban/player/player.dart';

import 'game_controller.dart';

class SokobanGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  SokobanGame(
    this.context, {
    required this.initialLevel,
    required this.controller,
  }) {
    // debugMode = true;
  }

  final BuildContext context;
  final GameController controller;

  final int initialLevel;
  late int level;

  late Player player;
  late final Stage stage;
  final int maxLevel = 500+99;

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
      _initStage(level + 1);
    });

    controller.onMove((direction) => movePlayerTo(player, direction));

    controller.onChangeLevel((newLevel) {
      _initStage(newLevel);
    });
    controller.onGetLevel(() => level);
  }

  void _initStage(int newLevel) {
    _changeLevel(newLevel);

    controller.levelChanged(level);
    stage.initStage(level: level);
  }

  bool movePlayerTo(PositionComponent playerComponent, Vector2 direction) {
    return stage.movePlayerTo(playerComponent, direction);
  }

  bool _changeLevel(int newLevel) {
    newLevel = newLevel.clamp(1, maxLevel);
    if (newLevel == level) {
      return false;
    }
    level = newLevel;

    return true;
  }
}
