import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum HeaderType{
  H1, H2, H3, H4, H5, H6
}

final Map<HeaderType, double> HeaderFontSizes = {
  HeaderType.H1: 50,
  HeaderType.H2: 45,
  HeaderType.H3: 35,
  HeaderType.H4: 25,
  HeaderType.H5: 20,
  HeaderType.H6: 16,
};

class Header extends StatelessWidget{
  final String content;
  final HeaderType type;
  final Color color;
  final TextDecoration textDecoration;
  const Header({
    super.key,
    required this.content,
    required this.type,
    this.color=Colors.white,
    this.textDecoration=TextDecoration.none
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontFamily: GoogleFonts.handjet().fontFamily,
        color: color,
        decoration: textDecoration,
        fontSize: HeaderFontSizes[type],
      ),
    );
  }

}