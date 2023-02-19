import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:sokoban/map/map_ext.dart';
import 'package:sokoban/obj/hole_object.dart';
import 'package:sokoban/player/player.dart';

import '../obj/box_object.dart';

class SokobanGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  SokobanGame() {
    // debugMode = true;
  }

  late final TiledComponent map;
  final tileSize = 16.0;
  late final tileRatio = tileSize / 16.0;

  late Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    map = await TiledComponent.load('stage1.tmx', Vector2(tileSize, tileSize));
    add(map);

    final startLayer = map.tileMap.getLayer<ObjectGroup>('start')!;
    final startingPoint = startLayer.objects.first;
    print('starting point is ${startingPoint.x} / ${startingPoint.y}');

    final boxLayer = map.tileMap.getLayer<ObjectGroup>('box')!;
    boxLayer.objects.forEach((TiledObject data) {
      final box = BoxObject(position: Vector2(data.x~/tileSize*tileSize, data.y~/tileSize*tileSize));
      add(box);
    });

    final holeLayer = map.tileMap.getLayer<ObjectGroup>('hole')!;
    holeLayer.objects.forEach((TiledObject data) {
      final box = HoleObject(position: Vector2(data.x~/tileSize*tileSize, data.y~/tileSize*tileSize));
      add(box);
    });

    player = Player(position: Vector2(startingPoint.x, startingPoint.y));
    add(player);


    camera.zoom = 1;
    camera.viewport = FixedResolutionViewport(
        Vector2(tileSize * 10 * 1.2, tileSize * 10 * 1.2));
  }
}

