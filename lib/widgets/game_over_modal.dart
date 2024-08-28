import 'package:flutter/material.dart';
import 'package:simon_game/main.dart';
import 'package:simon_game/widgets/button.dart' as Button;
import 'package:simon_game/widgets/header.dart';

class GameOverModal extends StatelessWidget{
  final int score;
  const GameOverModal({super.key, required this.score});
  void handleTryAgain(){
    events.emit("start", true);
  }
  void handleBackToMenu(){
    events.emit("backMenu", true);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.75,
      height: MediaQuery.of(context).size.height*0.5,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Header(
            content: "GAME OVER!",
            type: HeaderType.H1,
            color: Colors.black,
          ),
          Header(
              content: "Your Score: $score",
              type: HeaderType.H2,
              color: Colors.black54,
          ),
          Column(
            children: [
              Button.Button(
                  label: "TRY AGAIN",
                  onPressed: handleTryAgain,
                  theme: Button.ButtonTheme.SUCCESS
              ),
              Button.Button(
                label: "MENU",
                onPressed: handleBackToMenu,
                theme: Button.ButtonTheme.LIGHT,
                size: Button.ButtonSize.SM,
              )
            ],
          )
          ,
        ],
      ),
    );
  }
}