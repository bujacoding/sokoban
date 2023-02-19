import 'package:flame/components.dart';
import 'package:sokoban/game/sokoban_game.dart';

class HoleObject extends SpriteComponent with HasGameRef<SokobanGame> {
  HoleObject({super.position});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('hole.png');
    size = sprite!.srcSize;
  }
}
