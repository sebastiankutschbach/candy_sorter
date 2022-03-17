import 'dart:math';

import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:candy_sorter/features/candy_sorter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BowlArea extends StatelessWidget {
  const BowlArea({Key? key, required this.game, required this.onRemoveCandy})
      : super(key: key);

  final Game game;
  final Function(Candy candy) onRemoveCandy;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      runAlignment: WrapAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < game.colors.length; i++)
          DragTarget<Candy>(
              onAccept: (candy) => onRemoveCandy(candy),
              onWillAccept: (candy) {
                final isRightColor = game.colors[i] == candy?.color;
                if (!isRightColor) {
                  game.addPenaltyCandies(2);
                }
                return isRightColor;
              },
              builder: (context, candies, dontKnow) {
                return Bowl(
                  color: game.colors[i],
                );
              })
      ],
    );
  }
}
