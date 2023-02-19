import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../obj/box_object.dart';
import '../obj/hole_object.dart';

class Stage extends Component {
  Stage({required this.level});

  final int level;
  late final TiledComponent map;
  final tileSize = 16.0;
  late final tileRatio = tileSize / 16.0;
  late Function(dynamic startingPoint) _functionOnInitialized;

  Vector2 startingPoint = Vector2(0, 0);

  @override
  FutureOr<void> onLoad() async {
    map = await TiledComponent.load(
        'stage$level.tmx', Vector2(tileSize, tileSize));
    add(map);

    final startLayer = map.tileMap.getLayer<ObjectGroup>('start')!;
    final start = startLayer.objects.first;
    startingPoint = getTilePosition(Vector2(start.x, start.y));
    _functionOnInitialized.call(startingPoint);

    _onAddObject('hole', (position) => HoleObject(position: position));
    _onAddObject('box', (position) => BoxObject(position: position));
  }

  Vector2 getTilePosition(Vector2 position) => Vector2(
        position.x ~/ tileSize * tileSize,
        position.y ~/ tileSize * tileSize,
      );

  void onInitialized(Function(dynamic startingPoint) functionOnInitialized) {
    _functionOnInitialized = functionOnInitialized;
  }

  void _onAddObject(
      String layerName, Component Function(Vector2 position) functionOnObject) {
    map.tileMap
        .getLayer<ObjectGroup>(layerName)!
        .objects
        .map((TiledObject data) =>
            functionOnObject.call(getTilePosition(Vector2(data.x, data.y))))
        .forEach(add);
  }

  bool isWall(Vector2 position) {
    if (!map.toRect().contains(position.toOffset())) return false;

    final TileLayer walls = map.tileMap.getLayer<TileLayer>('walls')!;
    final Vector2 tileSize = map.tileMap.destTileSize;

    final int x = position.x ~/ tileSize.x;
    final int y = position.y ~/ tileSize.y;
    final int index = y * (map.width ~/ tileSize.x) + x;

    return walls.data![index] != 0;
  }

  BoxObject? getBox(Vector2 position) {
    final Iterable<BoxObject> boxes =
        children.where((component) => component is BoxObject).cast();

    final found =
        boxes.where((box) => box.toRect().contains(position.toOffset()));

    if (found.isNotEmpty) return found.first;

    return null;
  }

  bool pushBox(BoxObject box, Vector2 positionDelta) {
    final newPosition = box.position + positionDelta;

    if (getBox(newPosition) != null) return false;

    if (isWall(newPosition)) return false;

    box.position = newPosition;
    return true;
  }

  bool isClear() {
    final Iterable<HoleObject> holes =
        children.where((component) => component is HoleObject).cast();

    return holes.every((hole) => getBox(hole.position) != null);
  }
}
