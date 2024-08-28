import 'dart:async';
import 'dart:math';
import 'package:events_emitter/events_emitter.dart';
import 'package:simon_game/main.dart';
import 'package:simon_game/widgets/tile.dart';
import 'package:flutter/material.dart';

class TileGrid extends StatefulWidget{
  final bool gameOn;

  const TileGrid({ super.key, required this.gameOn });

  @override
  State<TileGrid> createState() => _TileGridState();
}

class _TileGridState extends State<TileGrid>{
  List<int> sequence = [];
  List<int> tappedSequence = [];
  Map<int, bool> highlightMap = { 1: false, 2: false, 3: false, 4: false };
  final Map<int, Color> tileColors = { 1: Colors.green, 2: Colors.red, 3: Colors.yellow, 4: Colors.blue };
  bool playing = false;


  @override
  void initState() {
    super.initState();

    final EventListener listener = EventListener("start", (dynamic data) => startGame());
    events.addEventListener(listener);
    final EventListener backMenuListener = EventListener("backMenu", (dynamic data) => resetData());
    events.addEventListener(backMenuListener);
  }

  @override
  void didUpdateWidget(covariant TileGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateHighlightMap();
  }
  void resetData(){
    resetHighlightMap();
    setState(() {
      sequence = [];
      tappedSequence = [];
      playing = false;
    });
  }
  void startGame(){
    int nextSequence = getNextTile();
    resetHighlightMap();
    setState(() {
      tappedSequence=[];
      sequence = [nextSequence];
    });
  }

  void updateHighlightMap({int? tileNumber}){
    resetHighlightMap();
    if(sequence.isNotEmpty){
      setState(() {
        highlightMap[tileNumber ?? sequence[sequence.length - 1]] = true;
      });
    }
  }

  void resetHighlightMap(){
    setState(() {
      highlightMap = { 1: false, 2: false, 3: false, 4: false };
    });
  }


  void handleUserTurn(int tileNumber){
    setState(() {
      tappedSequence.add(tileNumber);
      updateHighlightMap(tileNumber: tileNumber);
    });
    if( checkSequence(tileNumber, tappedSequence.length-1)){
      if(tappedSequence.length == sequence.length) {
        setState(() {
          playing=false;
        });
        Timer(const Duration(milliseconds: 800), nextRound);
      }

    }else{
      events.emit("stop", true);
    }
  }

  void nextRound(){
    int nextSequence = getNextTile();
    setState(() {
      sequence.add(nextSequence);
      events.emit("updateScore", 1);
      tappedSequence = [];
      playing=true;
    });
  }

  bool checkSequence(int currentTile, int arrayIndex){
    int correctTile = sequence[arrayIndex];
    return correctTile == currentTile;
  }

  bool shouldHighlightTile(int tileNumber){
    return sequence.isNotEmpty && sequence[sequence.length-1]==tileNumber;
  }

  int getNextTile(){
    int nextSequence = Random().nextInt(4);
    nextSequence = nextSequence == 0 ? nextSequence+1 : nextSequence;
    return nextSequence;
  }

  Tile getTile(int number){
    return Tile(
      color: tileColors[number] as Color,
      highlight: highlightMap[number] ?? false,
      onTap: () => handleUserTurn(number),
      activeTile: widget.gameOn,
    );
  }


  @override
  Widget build(BuildContext context){
    return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              Row(
                  children:[ getTile(1), getTile(2) ]
              ),
              Row(
                  children: [ getTile(3), getTile(4) ]
              )
            ],
          ),
        ]
    );
  }
}