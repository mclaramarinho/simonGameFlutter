import 'package:flutter/material.dart';

enum ButtonSize {
  SM, MD, LG
}
enum ButtonTheme {
  DARK, LIGHT, SUCCESS
}

final Map<ButtonSize, double> ButtonLabelFontSizes = {
  ButtonSize.SM: 20,
  ButtonSize.MD: 30,
  ButtonSize.LG: 40,
};

final Map<ButtonTheme, Color> ButtonBgColors = {
  ButtonTheme.LIGHT: Colors.white,
  ButtonTheme.DARK: Colors.black,
  ButtonTheme.SUCCESS: Colors.green,
};

class Button extends StatelessWidget{
  final String label;
  final dynamic Function() onPressed;
  final ButtonSize size;
  final ButtonTheme theme;
  final EdgeInsets margins;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.size=ButtonSize.MD,
    this.theme=ButtonTheme.LIGHT,
    this.margins=const EdgeInsets.fromLTRB(0, 0, 0, 0)
  });


  @override
  Widget build(BuildContext context) {
    Color bgColor = ButtonBgColors[theme] as Color;
    Color labelColor = theme == ButtonTheme.LIGHT ? Colors.black : Colors.white;
    double fontSize = ButtonLabelFontSizes[size] as double;


    return Container(
        margin: margins,
        child: FilledButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(bgColor),
              padding: WidgetStateProperty.all(const EdgeInsets.fromLTRB(36, 8, 36, 8)),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              )
          ),
          child: Text(label,
              style: TextStyle(
                color: labelColor,
                fontSize: fontSize,
                fontFamily: "HandJet",
                fontWeight: FontWeight.w900,
              )
          )
      )
    );
  }
}