import 'package:flame_audio/flame_audio.dart';

class AudioPlayer {
  //static instance
  static AudioPlayer? _instance;

  static AudioPlayer get instance {
    return _instance ??= AudioPlayer._internal();
  }

  //private constructor
  AudioPlayer._internal() {
    _initAsync();
  }

  void _initAsync() {
    FlameAudio.bgm.initialize();
  }

  final map = {
    'coin': '341695__projectsu012__coins-1.wav',
    'game': '483502__dominikbraun__let-me-see-ya-bounce-8-bit-music.mp3',
    'intro': '569777__theojt__retro-electro.mp3',
    'clear': '624883__sonically_sound__old-video-game-6.wav',
    'ting': '514369__exechamp__gritty-ui-audio-4.wav',
    'move_box': '404794__owlstorm__retro-video-game-sfx-hop.wav',
    'reset':
        '400580__alanmcki__retro-arcade-video-game-end-or-completed-tone.wav',
    'sweep': '156522__timbre__retro-video-game-sweep.flac',
    'bump': '365672__mikala_oidua__retro-game-sfx_jump-bump.wav',
    'explosion': '253169__suntemple__retro-game-sfx-explosion.wav',
    'start_game': '367224__jofae__retro-game-dramatic-effect.mp3',
    'footstep-full': '501102__evretro__8-bit-footsteps.wav',
    'move': '501102__evretro__8-bit-one-footstep.wav',
    'incorrect': '216090__richerlandtv__bad-beep-incorrect_2xfaster.wav',
  };

  Future<void> play(String name, {double volume = 1}) async {
    await FlameAudio.play(assetPath(name), volume: volume);
  }

  String assetPath(String name) {
    var assetName = map[name];
    if (assetName == null) {
      throw ArgumentError('No asset found for \'$name\'');
    }

    return assetName;
  }

  Future<void> playBgm(String name, {double volume = 1}) async {
    await FlameAudio.bgm.play(assetPath(name), volume: volume);
  }

  Future<void> stopBgm() async {
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.dispose();
  }
}
