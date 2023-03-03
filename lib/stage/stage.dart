import 'dart:async';

import 'package:flame/components.dart';

import '../map/map_component.dart';
import '../obj/box_object.dart';
import '../obj/hole_object.dart';

class Stage extends PositionComponent {
  Stage({required this.level});

  final int level;
  MapComponent? map;
  final tileSize = 16.0;
  late final tileRatio = tileSize / 16.0;
  late Function(Vector2 startingPoint) _functionOnInitialized;
  late Function() _onClear;

  void onInitialized(Function(Vector2 startingPoint) functionOnInitialized) {
    _functionOnInitialized = functionOnInitialized;
  }

  @override
  FutureOr<void> onLoad() async {
    initStage(level: level);
  }

  Future initStage({required int level}) async {
    removeAll(children);
    this.map?.dispose();

    final map = MapComponent.custom(
        level: level, tileSize: Vector2(tileSize, tileSize));
    await map.initAsync();
    this.map = map;
    size = map.size;

    add(map);

    addAll(map.holeObjects.map((position) => HoleObject(position: position)));
    addAll(map.boxObjects.map((position) => BoxObject(position: position)));
    _functionOnInitialized.call(map.startingPosition);
  }

  Vector2 getTilePosition(Vector2 position) => Vector2(
        position.x ~/ tileSize * tileSize,
        position.y ~/ tileSize * tileSize,
      );

  bool isWall(Vector2 position) {
    return map!.isWall(position);
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
    return children
        .whereType<HoleObject>()
        .every((hole) => getBox(hole.position) != null);
  }

  bool movePlayerTo(PositionComponent playerComponent, Vector2 direction) {
    final positionDelta = direction * tileSize;
    Vector2 positionTarget = playerComponent.position + positionDelta;
    var positionIndex =
        '(${positionTarget.x ~/ tileSize}, ${positionTarget.y ~/ tileSize})';

    try {
      if (isWall(positionTarget)) {
        throw '$positionIndex is a wall.';
      }

      final box = getBox(positionTarget);
      if (box != null) {
        if (!pushBox(box, positionDelta)) {
          throw 'Cannot move box on $positionIndex';
        }

        if (isClear()) {
          _onClear.call();
        }
      }

      playerComponent.position = positionTarget;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void onClear(Function() functionOnClear) {
    _onClear = functionOnClear;
  }
}
