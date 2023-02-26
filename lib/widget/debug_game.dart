import 'package:flutter/material.dart';

import '../game/game_controller.dart';

class DebugGameWidget extends StatefulWidget {
  DebugGameWidget({
    super.key,
    required this.controller,
  });

  final GameController controller;

  @override
  State<DebugGameWidget> createState() =>
      _DebugGameWidgetState();
}

class _DebugGameWidgetState extends State<DebugGameWidget> {
  final TextEditingController levelController = TextEditingController()
    ..text = '1';

  @override
  void initState() {
    super.initState();

    widget.controller.onChangeLevel((level) => levelController.text = '$level');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => widget.controller.previousLevel(),
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
          onPressed: () => widget.controller.nextLevel(),
          icon: Icon(Icons.arrow_forward, color: Colors.purple),
        ),
      ],
    );
  }
}
