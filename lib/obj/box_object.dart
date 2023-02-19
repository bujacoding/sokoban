import 'package:flame/components.dart';
import 'package:sokoban/game/sokoban_game.dart';

class BoxObject extends SpriteComponent with HasGameRef<SokobanGame> {
  BoxObject({super.position});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('box.png');
    size = sprite!.srcSize;
  }
}
