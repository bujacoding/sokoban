import 'package:flutter/material.dart';

class GameDebugController {
  late Function() _functionOnPreviousLevel;
  late Function() _functionOnNextLevel;
  late Function(int level) _functionOnChangeLevel;

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

class GameDebugControllerWidget extends StatefulWidget {
  GameDebugControllerWidget({
    super.key,
    required this.gameController,
  });

  final GameDebugController gameController;

  @override
  State<GameDebugControllerWidget> createState() =>
      _GameDebugControllerWidgetState();
}

class _GameDebugControllerWidgetState extends State<GameDebugControllerWidget> {
  final TextEditingController levelController = TextEditingController()
    ..text = '1';

  @override
  void initState() {
    super.initState();

    widget.gameController
        .onChangeLevel((level) => levelController.text = '$level');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => widget.gameController.previousLevel(),
          icon: Icon(Icons.arrow_back, color: Colors.purple),
        ),
        SizedBox(
            width: 30,
            child: TextField(
              controller: levelController,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.purple),
              textAlign: TextAlign.center,
              cursorColor: Colors.purple,
            )),
        IconButton(
          onPressed: () => widget.gameController.nextLevel(),
          icon: Icon(Icons.arrow_forward, color: Colors.purple),
        ),
      ],
    );
  }
}
