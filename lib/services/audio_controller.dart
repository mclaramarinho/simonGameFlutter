import 'package:audioplayers/audioplayers.dart';


class AudioController{
  AudioPlayer? player;

  AudioController(){
    player = AudioPlayer();
  }

  void correctPlay() async {
    player!.play(AssetSource('correct_play.mp3'));
  }

  void wrongPlay() async {
    player!.play(AssetSource('wrong_play.mp3'));
  }

  void menuClick() async {
    player!.play(AssetSource('menu_click.mp3'));
  }
}