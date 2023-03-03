import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import 'map_component.dart';

class TiledMapComponent extends MapComponent {
  late final TiledComponent tiled;

  TiledMapComponent({required super.level, required super.tileSize});

  @override
  Future<void> initAsync() async {

    tiled = await TiledComponent.load('stage$level.tmx', tileSize);
    add(tiled);

    tiled.tileMap.getLayer<ObjectGroup>('obj')!.objects.forEach(_onObject);

    size = tiled.size;
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
}
