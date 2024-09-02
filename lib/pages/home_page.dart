import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simon_game/services/audio_controller.dart';
import 'package:simon_game/services/singletons/events.dart';
import 'package:simon_game/widgets/game_menu.dart';
import 'package:simon_game/widgets/game_over_modal.dart';
import 'package:simon_game/widgets/score_bar.dart';
import 'package:simon_game/widgets/tile_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  bool gameOn = false;
  bool gameOver = false;
  int score = 0;
  int highScore = 0;

  @override
  void initState() {
    super.initState();
    Events.registerListener(key: "backMenu", callback: resetData);
    Events.registerListener(key: "stop", callback: stopGame);
    Events.registerListener(key: "updateScore", callback: updateScore);
    Events.registerListener(key: "start", callback: startGame);
  }


  startGame() async{
    AudioController().menuClick();
    SharedPreferences store = await SharedPreferences.getInstance();
    int lastHighScore = store.getInt("highScore") ?? 0;

    setState(() {
      highScore = lastHighScore;
      score = 0;
      gameOn = true;
    });
  }

  void resetData(){
    setState(() {
      gameOn = false;
      gameOver = false;
      score = 0;
    });
  }

  void stopGame(){
    setUpHiScore();

    setState(() {
      gameOn = false;
      gameOver = true;
    });
    AudioController().wrongPlay();
  }

  void updateScore(){
    setState(() {
      score+=1;
    });
  }

  void setUpHiScore() async{
    SharedPreferences store = await SharedPreferences.getInstance();
    int lastHighScore = store.getInt("highScore") ?? 0;
    if(score > lastHighScore){
      store.setInt('highScore', score);
    }
    
  }

  @override
  Widget build(BuildContext context){
    return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          TileGrid(gameOn: gameOn),
          if(gameOn) ScoreBar(score: score, highScore: highScore,),
          if (!gameOn && !gameOver) const GameMenu(),
          if(!gameOn && gameOver) GameOverModal(score: score)
        ]
    );
  }
}