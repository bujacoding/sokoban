import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';

import 'map_component.dart';

class TiledMapComponent extends MapComponent {
  TiledMapComponent({required super.level, required super.tileSize});

  late final TiledComponent tiled;
  int maxLevel = 0;

  @override
  Future<void> initAsync() async {
    var levelFile = '$level'.padLeft(4, '0');
    tiled = await TiledComponent.load('$levelFile.tmx', tileSize);
    add(tiled);

    tiled.tileMap.getLayer<ObjectGroup>('obj')!.objects.forEach(_onObject);

    size = tiled.size;

    maxLevel = await findMaxLevel();
  }

  @override
  int getMaxLevel() {
    return maxLevel;
  }

  void _onObject(TiledObject obj) {
    final position = getTilePosition(Vector2(obj.x, obj.y));

    if (obj.isPoint) {
      startingPosition = position;
    } else if (obj.isRectangle) {
      boxObjects.add(position);
    } else if (obj.isEllipse) {
      holeObjects.add(position);
    } else {
      throw 'obj type error: $obj';
    }
  }

  @override
  bool isWall(Vector2 position) {
    if (!tiled.toRect().contains(position.toOffset())) return false;

    final TileLayer walls = tiled.tileMap.getLayer<TileLayer>('walls')!;
    final Vector2 tileSize = tiled.tileMap.destTileSize;

    final int x = position.x ~/ tileSize.x;
    final int y = position.y ~/ tileSize.y;
    final int index = y * (tiled.width ~/ tileSize.x) + x;

    return walls.data![index] != 0;
  }

  Future<int> findMaxLevel() async {
    int level = 0;
    final begin = DateTime.now();
    while (true) {
      try {
        String levelDigit = '${level + 1}'.padLeft(4, '0');
        await rootBundle.load('assets/tiles/$levelDigit.tmx');
        level++;
      } catch (e) {
        print(
            'max level is $level / time elapsed ${DateTime.now().difference(begin)}');
        return level;
      }
    }
  }
}
