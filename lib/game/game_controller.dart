import 'package:flame/game.dart';

class GameController {
  late bool Function(Vector2 direction) _functionOnMove;
  late Function() _functionOnPreviousLevel;
  late Function() _functionOnNextLevel;
  late Function(int level) _functionOnChangeLevel;

  void move(Vector2 direction) {
    _functionOnMove.call(direction);
  }

  void onMove(bool Function(Vector2 direction) functionOnMove) {
    _functionOnMove = functionOnMove;
  }

  void previousLevel() {
    _functionOnPreviousLevel.call();
  }

  void nextLevel() {
    _functionOnNextLevel.call();
  }

  void changeLevel(int level) {
    _functionOnChangeLevel.call(level);
  }

  void onPreviousLevel(void Function() functionOnPreviousLevel) {
    _functionOnPreviousLevel = functionOnPreviousLevel;
  }

  void onNextLevel(void Function() functionOnNextLevel) {
    _functionOnNextLevel = functionOnNextLevel;
  }

  void onChangeLevel(void Function(int level) functionOnChangeLevel) {
    _functionOnChangeLevel = functionOnChangeLevel;
  }
}
