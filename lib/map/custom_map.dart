import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:sokoban/map/map_component.dart';

class CustomMap<T extends FlameGame> extends MapComponent
    with HasGameRef<T> {
  CustomMap({required super.level, required super.tileSize});

  @override
  Future<void> initAsync() {
    throw UnimplementedError();
  }

  @override
  bool isWall(Vector2 position) {
    throw UnimplementedError();
  }

}
