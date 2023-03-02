import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:sokoban/map/map_component.dart';

class CustomMap<T extends FlameGame> extends MapComponent
    with HasGameRef<T> {
  CustomMap({required super.level, required super.tileSize});

  late final List<String> map;

  @override
  Future<void> initAsync() async {
    Map<String, dynamic> levelInfo = getLevelInfo(level);

    print(levelInfo);

    final String file = levelInfo['data']['file']!;
    final int index = levelInfo['index']!;

    final text = await rootBundle.loadString('assets/levels/$file');
    final levelText = (text.split(';')
          ..removeWhere((element) => element.isEmpty))[index]
        .split('\n')
      ..removeWhere((element) => !element.contains('#'));
    this.map = levelText.toList(growable: false);

    await addTiles(map);

    startingPosition = (findPosition(map, '@') + findPosition(map, '+')).first;
    holeObjects = findPosition(map, '.') + findPosition(map, '+');
    boxObjects = findPosition(map, '\$');
  }

  Map<String, dynamic> getLevelInfo(int level) {
    final levelFiles = [
      {'file': 'level1.txt', 'count': 100},
      {'file': 'level2.txt', 'count': 100},
      {'file': 'level3.txt', 'count': 200},
      {'file': 'level4.txt', 'count': 100},
      {'file': 'level5.txt', 'count': 100},
    ];

    int filledLevel = level;

    for (var i = 0; i < levelFiles.length; i++) {
      final levelFile = levelFiles[i];
      final int count = levelFile['count']! as int;
      if (filledLevel <= count) {
        return {'data': levelFile, 'index': filledLevel - 1};
      }
      filledLevel -= count;
    }

    return {
      'data': levelFiles.last,
      'index': (levelFiles.last['count']! as int) - 1
    };
  }

  @override
  bool isWall(Vector2 position) {
    final int x = position.x ~/ tileSize.x;
    final int y = position.y ~/ tileSize.y;
    final char = map[y][x];
    return char == '#';
  }

  List<Vector2> findPosition(List<String> map, String target) {
    final List<Vector2> positions = [];

    for (var y = 0; y < map.length; y++) {
      final row = map[y];
      for (var x = 0; x < row.length; x++) {
        final char = row[x];
        if (char == target) {
          positions
              .add(Vector2(x.toDouble(), y.toDouble())..multiply(tileSize));
        }
      }
    }
    return positions;
  }

  Future<void> addTiles(List<String> map) async {
    for (var y = 0; y < map.length; y++) {
      final row = map[y];
      for (var x = 0; x < row.length; x++) {
        add(await loadSprite('tile_floor.png', x, y));
        final char = row[x];
        if (char == '#') {
          add(await loadSprite('tile_wall.png', x, y));
        }
      }
    }
  }

  Future<SpriteComponent> loadSprite(String src, int x, int y) async {
    return SpriteComponent(
      size: tileSize,
      sprite: await Sprite.load(src),
      position: Vector2(x.toDouble(), y.toDouble())..multiply(tileSize),
    );
  }
}
