import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sokoban/game/sokoban_game.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GameWidget(game: SokobanGame()));
  }
}
