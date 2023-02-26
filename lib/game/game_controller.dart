import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

class GameController {
  final ValueNotifier moveValue = ValueNotifier(Vector2.zero());
  Function() _functionOnPreviousLevel = () {};
  Function() _functionOnNextLevel = () {};
  Function(int level) _functionOnChangeLevel = (_) {};
  Function(int level) _functionOnLevelChanged = (_) {};
  Function() _functionOnGetLevel = () {};

  void move(Vector2 direction) {
    moveValue.value = direction;
  }

  void onMove(bool Function(Vector2 direction) functionOnMove) {
    moveValue.addListener(() {
      functionOnMove.call(moveValue.value);
    });
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
