import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  Timer t = Timer(Duration(seconds: 0), () => ());

  @override
  void didUpdateWidget(covariant Tile oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    highlightTile();
    print(widget.activeTile);
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