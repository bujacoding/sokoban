import 'package:flutter/material.dart';

class GameViewModel with ChangeNotifier {
  final GameRepository _repository = GameRepository();

  int get level => _repository._level;

  set level(int value) {
    _repository._level = value;
    notifyListeners();
  }
}

class GameRepository {
  int _level = 1;

  int getLevel() => _level;

  void setLevel(int level) {
    _level = level;
  }
}
