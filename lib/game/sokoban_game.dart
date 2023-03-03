import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sokoban/page/clear_stage/clear_stage.dart';
import 'package:sokoban/player/player.dart';
import 'package:sokoban/stage/stage.dart';

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

    stage = Stage(
      mapType: 'tiled',
      level: level,
    )..priority = 0;

    add(stage);

    stage.onInitialized((startingPoint) {
      player.position = startingPoint + Vector2.all(stage.tileSize) / 2;
      camera.viewport = FixedResolutionViewport(stage.size * 1.1);
      camera.moveTo(-stage.size * 0.05);
      camera.speed = stage.size.length;
      camera.zoom = 1;
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
