import 'package:flame/game.dart';

class GameController {
  bool Function(Vector2 direction) _functionOnMove = (_) => false;
  Function() _functionOnPreviousLevel = () {};
  Function() _functionOnNextLevel = () {};
  Function(int level) _functionOnChangeLevel = (_) {};
  Function(int level) _functionOnLevelChanged = (_) {};
  Function() _functionOnGetLevel = () {};

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

  int getLevel() {
    return _functionOnGetLevel.call();
  }

  void onGetLevel(int Function() functionOnGetLevel) {
    _functionOnGetLevel = functionOnGetLevel;
  }
}
