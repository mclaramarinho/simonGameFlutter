import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simon_game/services/audio_controller.dart';

class Tile extends StatefulWidget{
  final dynamic Function()? onTap;
  final Color color;
  final bool highlight;
  final bool activeTile;
  
  const Tile({super.key, required this.color, this.onTap, this.highlight=false, this.activeTile=true});
  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile>{
  bool? highlightLocal;
  bool activeTileLocal = true;
  Timer t = Timer(const Duration(seconds: 0), () => ());

  @override
  void didUpdateWidget(covariant Tile oldWidget) {
    super.didUpdateWidget(oldWidget);
    highlightTile();
    setState(() {
      activeTileLocal = widget.activeTile;
    });
  }

  void highlightTile(){
    if(widget.highlight){
      setState(() {
        highlightLocal = true;
      });
      t = Timer(const Duration(milliseconds: 400), removeHighlight);
      return;
    }
    removeHighlight();
  }
  void removeHighlight(){
    setState(() {
      highlightLocal = false;
    });
  }

  void handleTap(){
    AudioController().correctPlay();
    t.isActive ? t.cancel() : null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: activeTileLocal ? (){handleTap(); widget.onTap!();} : null,

      child: Container(
        color: highlightLocal!=null && highlightLocal == true
                ? widget.color.withOpacity(1)
                : widget.color.withOpacity(0.5),
        width: MediaQuery.of(context).size.width/2,
        height: MediaQuery.of(context).size.height/2,
      ),
    );
  }
}