import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:sokoban/map/stage.dart';
import 'package:sokoban/player/player.dart';

class SokobanGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  SokobanGame({required this.initialLevel}) {
    // debugMode = true;
  }

  final int initialLevel;
  late int level;

  late Player player;
  late final Stage stage;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    level = initialLevel;

    player = Player(position: Vector2.zero())..priority = 5;
    add(player);

    stage = Stage(level: level)..priority = 0;
    add(stage);

    stage.onInitialized((startingPoint) {
      player.position =
          startingPoint + Vector2(stage.tileSize, stage.tileSize) / 2;
      camera.zoom = 1;
      camera.viewport = FixedResolutionViewport(
        Vector2(stage.tileSize, stage.tileSize) * 10 * 1.2,
      );
    });

    stage.onClear(() {
      print('NEXT GAME');
      stage.initStage(level: ++level);
    });
  }

  bool movePlayerTo(PositionComponent playerComponent, Vector2 positionDelta) {
    return stage.movePlayerTo(playerComponent, positionDelta);
  }
}
