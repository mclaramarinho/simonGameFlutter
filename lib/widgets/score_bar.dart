import 'package:flutter/material.dart';

class ScoreBar extends StatelessWidget{
  final int score;
  final int highScore;
  const ScoreBar({super.key, required this.score, required this.highScore});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.bottomCenter,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
      child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Score: $score",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.none
              ),
            ),
            const Text(
              "|",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.none
                ),
            ),
            Text(
              "High Score: $highScore",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.none
              ),
            ),
          ],
        )

    );
  }
}