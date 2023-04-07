import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sokoban/audio/audio_player.dart';
import 'package:sokoban/page/home/game_page.dart';

import '../../game/game_controller.dart';
import '../../game/game_view_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  final gameController = GameController();

  String mapType = 'custom';

  @override
  void initState() {
    super.initState();
    _playBgm();
  }

  void _playBgm() {
    AudioPlayer.instance.stopBgm();
    AudioPlayer.instance.playBgm('intro');
  }

  @override
  void dispose() {
    print('hello dispose');
    AudioPlayer.instance.stopBgm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildGameMenu(context);
  }

  Widget _buildGameMenu(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sokoban'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => _lastCreatedGame(context),
              child: const Text('Start Last Created Game'),
            ),
            TextButton(
              onPressed: () => _startGame(context),
              child: const Text('Start Game'),
            ),
            TextButton(
              onPressed: () => setState(() {
                mapType = mapType == 'custom' ? 'tiled' : 'custom';
              }),
              child: Text('MapType: $mapType'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => selectLevel(context),
                  child: const Text('Level'),
                ),
                IconButton(
                    onPressed: () {
                      AudioPlayer.instance.play('coin');
                      context.read<GameViewModel>().level =
                        context.read<GameViewModel>().level - 1;
                    },
                    icon: Icon(
                      Icons.arrow_left,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                Text('${context.watch<GameViewModel>().level}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary)),
                IconButton(
                    onPressed: () {
                      AudioPlayer.instance.play('coin');
                      context.read<GameViewModel>().level =
                        context.read<GameViewModel>().level + 1;
                    },
                    icon: Icon(
                      Icons.arrow_right,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ],
            ),
            TextButton(
              onPressed: () => print('leaderboard'),
              child: const Text('Leaderboard'),
            ),
            TextButton(
              onPressed: () => print('settings'),
              child: const Text('Settings'),
            ),
            TextButton(
              onPressed: () => print('about'),
              child: const Text('About'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectLevel(BuildContext context) async {
    var gameViewModel = context.read<GameViewModel>();
    var level = gameViewModel.level;

    final newLevel = await showDialog(
        context: context,
        builder: (context) {
          var textEditingController =
              TextEditingController(text: '$level');
          return AlertDialog(
            title: const Text('Level'),
            content: TextField(
              controller: textEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Enter a level'),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context)
                      .pop(int.tryParse(textEditingController.text)),
                  child: const Text('OK'))
            ],
          );
        });

    if (newLevel != null) {
      AudioPlayer.instance.play('reset');
      gameViewModel.level = newLevel;
    }
  }

  _startGame(BuildContext context) async {
    var navigatorState = Navigator.of(context);

    await AudioPlayer.instance.stopBgm();
    await AudioPlayer.instance.play('start_game');

    navigatorState.push(MaterialPageRoute(
        builder: (_) => GamePage(
              mapType: mapType,
            )));
  }

  _lastCreatedGame(BuildContext context) {
    context.read<GameViewModel>().level = 600;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => GamePage(
              mapType: 'tiled',
            )));
  }
}
