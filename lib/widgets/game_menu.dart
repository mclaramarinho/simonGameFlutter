import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simon_game/services/singletons/events.dart';
import 'package:simon_game/widgets/button.dart';
import 'package:simon_game/widgets/header.dart';



class GameMenu extends StatefulWidget{
  const GameMenu({super.key});
  @override
  State<GameMenu> createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu>{
  bool gameOn = false;

  void handleButtonPress() => Events.emit(event: "start");

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Header(content: "SIMON GAME", type: HeaderType.H1),
          Button(label: "PLAY", onPressed: handleButtonPress)
        ]
    );
  }
}