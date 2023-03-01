import 'package:flame/components.dart';
import 'package:flame/game.dart';

class CustomMap<T extends FlameGame> extends PositionComponent
    with HasGameRef<T> {
  static load(int level, Vector2 destTileSize) {}

}
