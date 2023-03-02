import 'package:flame/components.dart';

import 'custom_map_component.dart';
import 'tiled_map_component.dart';

abstract class MapComponent extends PositionComponent {
  final int level;
  final Vector2 tileSize;
  Vector2 startingPosition = Vector2.zero();
  List<Vector2> holeObjects = [];
  List<Vector2> boxObjects = [];

  factory MapComponent.tiled({required int level, required Vector2 tileSize}) {
    return TiledMapComponent(level: level, tileSize: tileSize);
  }

  factory MapComponent.custom({required int level, required Vector2 tileSize}) {
    return CustomMapComponent(level: level, tileSize: tileSize);
  }

  MapComponent({required this.level, required this.tileSize});

  Future<void> initAsync();

  bool isWall(Vector2 position);

  void dispose() {
    removeAll(children);
  }

  Vector2 getTilePosition(Vector2 position) => Vector2(
        position.x ~/ tileSize.x * tileSize.x,
        position.y ~/ tileSize.y * tileSize.y,
      );
}
