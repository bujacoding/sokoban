import 'package:flame/game.dart';

class GameController {
  late bool Function(Vector2 direction) _functionOnMove;
  late Function() _functionOnPreviousLevel;
  late Function() _functionOnNextLevel;
  late Function(int level) _functionOnChangeLevel;
  late Function(int level) _functionOnLevelChanged;

  void move(Vector2 direction) {
    _functionOnMove.call(direction);
  }

  void onMove(bool Function(Vector2 direction) functionOnMove) {
    _functionOnMove = functionOnMove;
  }

  void previousLevel() {
    _functionOnPreviousLevel.call();
  }

  void onPreviousLevel(void Function() functionOnPreviousLevel) {
    _functionOnPreviousLevel = functionOnPreviousLevel;
  }

  void nextLevel() {
    _functionOnNextLevel.call();
  }

  void onNextLevel(void Function() functionOnNextLevel) {
    _functionOnNextLevel = functionOnNextLevel;
  }

  void changeLevel(int level) {
    _functionOnChangeLevel.call(level);
  }

  void onChangeLevel(void Function(int level) functionOnChangeLevel) {
    _functionOnChangeLevel = functionOnChangeLevel;
  }

  void levelChanged(int level) {
    _functionOnLevelChanged.call(level);
  }

  void onLevelChanged(void Function(int level) functionOnLevelChanged) {
    _functionOnLevelChanged = functionOnLevelChanged;
  }
}
