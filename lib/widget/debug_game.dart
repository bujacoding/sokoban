import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../audio/audio_player.dart';
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

  GameController get controller => widget.controller;

  @override
  void initState() {
    super.initState();

    controller.onLevelChanged((level) => levelController.text = '$level');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => controller.previousLevel(),
          icon: Icon(Icons.arrow_back, color: Colors.purple),
        ),
        SizedBox(
          width: 30,
          child: TextField(
            controller: levelController,
            onSubmitted: (value) => controller.changeLevel(int.parse(value)),
            onTap: () => levelController.selection = TextSelection(
                baseOffset: 0, extentOffset: levelController.value.text.length),
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.purple),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            cursorColor: Colors.purple,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        IconButton(
          onPressed: () => controller.nextLevel(),
          icon: Icon(Icons.arrow_forward, color: Colors.purple),
        ),
        Spacer(),
        ElevatedButton(
            onPressed: () async {
              await AudioPlayer.instance.play('reset');
              controller.changeLevel(controller.getLevel());
            },
            child: Text('RESET')),
      ],
    );
  }
}
