import 'package:audioplayers/audioplayers.dart';


class AudioController{
  AudioPlayer? player;

  AudioController(){
    player = AudioPlayer();
  }
  void correctPlay() async {
    print("correct play");
    await player!.setSource(AssetSource('audios/correct_play.mp3'));
    await player!.resume();
    //await player!.play(AssetSource('audios/correct_play.mp3'), mode: PlayerMode.lowLatency);
  }

  void wrongPlay() async {
    await player!.play(AssetSource('audios/wrong_play.mp3'));
  }

  void menuClick() async {
    await player!.play(AssetSource('audios/menu_click.mp3'));
  }
}