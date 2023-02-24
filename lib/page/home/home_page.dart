import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sokoban/game/sokoban_game.dart';

import '../../widget/game_pad.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final gamePadController = GamePadController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        GameWidget(
            game: SokobanGame(
          context,
          initialLevel: 1,
          gamePadController: gamePadController,
        )),
        Align(
            alignment: Alignment.bottomLeft,
            child: GamePadWidget(controller: gamePadController)),
      ],
    )));
  }
}
