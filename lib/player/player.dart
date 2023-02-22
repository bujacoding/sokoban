import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../game/sokoban_game.dart';

class Player extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks, HasGameRef<SokobanGame> {
  Player({required super.position}) : super();

  Vector2 move = Vector2(0, 0);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    animation = SpriteAnimation.fromFrameData(
        await game.images.load('free_character_0.png'),
        SpriteAnimationData.sequenced(
          texturePosition: Vector2(0, 0),
          amount: 3,
          stepTime: .5,
          textureSize: Vector2(32, 32),
        ));

    // position = Vector2(32 + 16 / 2, 32 + 16 / 2);
    size = Vector2(32, 32);
    anchor = Anchor.center;

    add(RectangleHitbox(
      size: Vector2.all(16 - 2),
      anchor: Anchor.center,
      position: Vector2.all(32 / 2),
    ));
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is! RawKeyDownEvent) return true;

    if (false) {
    } else if ([LogicalKeyboardKey.keyA, LogicalKeyboardKey.arrowLeft]
        .any((key) => event.logicalKey == key)) {
      move.x = -16;
    } else if ([LogicalKeyboardKey.keyD, LogicalKeyboardKey.arrowRight]
        .any((key) => event.logicalKey == key)) {
      move.x = 16;
    } else if ([LogicalKeyboardKey.keyW, LogicalKeyboardKey.arrowUp]
        .any((key) => event.logicalKey == key)) {
      move.y = -16;
    } else if ([LogicalKeyboardKey.keyS, LogicalKeyboardKey.arrowDown]
        .any((key) => event.logicalKey == key)) {
      move.y = 16;
    }

    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!move.isZero()) {
      if (game.movePlayerTo(this, move)) {
        print('move ok');
      }
      move = Vector2.zero();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print('onCollision other: ${other.position} ${other.size}');

    super.onCollision(intersectionPoints, other);
  }
}
