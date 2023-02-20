import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:sokoban/map/stage.dart';
import 'package:sokoban/player/player.dart';

class SokobanGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  SokobanGame() {
    // debugMode = true;
  }

  late final Stage stage;

  late Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    stage = Stage(level: 1);
    add(stage);

    stage.onInitialized((startingPoint) {
      player = Player(
          position: startingPoint +
              Vector2(stage.tileSize / 2, stage.tileSize / 2));
      add(player);

      camera.zoom = 1;
      camera.viewport = FixedResolutionViewport(
          Vector2(stage.tileSize * 10 * 1.2, stage.tileSize * 10 * 1.2));
    });

  }
}
