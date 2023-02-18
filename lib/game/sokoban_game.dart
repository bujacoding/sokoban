import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:sokoban/player/player.dart';

class SokobanGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  SokobanGame() {
    debugMode = true;
  }

  late final TiledComponent map;
  final tileSize = 16.0;
  late final tileRatio = tileSize / 16.0;

  Player player = Player();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    map = await TiledComponent.load('stage1.tmx', Vector2(tileSize, tileSize));
    add(map);

    final startGroup = map.tileMap.getLayer<ObjectGroup>('start')!;
    final startingPoint = startGroup.objects.first;
    print('starting point is ${startingPoint.x} / ${startingPoint.y}');

    add(player);

    camera.zoom = 1;
    camera.viewport =
        FixedResolutionViewport(Vector2(tileSize * 10, tileSize * 10));
  }
}
