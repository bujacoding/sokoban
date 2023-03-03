import 'package:flame/components.dart';

import 'custom_map_component.dart';
import 'tiled_map_component.dart';

abstract class MapComponent extends PositionComponent {
  factory MapComponent.withType({
    required String type,
    required int level,
    required Vector2 tileSize,
  }) {
    switch (type) {
      case 'tiled':
        return TiledMapComponent(level: level, tileSize: tileSize);
      case 'custom':
        return CustomMapComponent(level: level, tileSize: tileSize);
      default:
        throw 'type error: $type';
    }
  }

  final int level;
  final Vector2 tileSize;
  Vector2 startingPosition = Vector2.zero();
  List<Vector2> holeObjects = [];
  List<Vector2> boxObjects = [];

  MapComponent({required this.level, required this.tileSize});

  Future<void> initAsync();

  bool isWall(Vector2 position);

  int getMaxLevel();

  void dispose() {
    removeAll(children);
  }

  Vector2 getTilePosition(Vector2 position) => Vector2(
        position.x ~/ tileSize.x * tileSize.x,
        position.y ~/ tileSize.y * tileSize.y,
      );
}
