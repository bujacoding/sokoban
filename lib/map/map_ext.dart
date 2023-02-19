import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

extension MapExtension on TiledComponent {

  bool hasWallOn(Vector2 position) {
    if (!toRect().contains(position.toOffset())) return false;

    final TileLayer walls = tileMap.getLayer<TileLayer>('walls')!;
    final Vector2 tileSize = tileMap.destTileSize;

    final int x = position.x ~/ tileSize.x;
    final int y = position.y ~/ tileSize.y;
    final int index = y * (width ~/ tileSize.x) + x;

    return walls.data![index] != 0;
  }
}
