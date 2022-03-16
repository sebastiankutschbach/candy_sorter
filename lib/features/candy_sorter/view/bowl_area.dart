import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:candy_sorter/features/candy_sorter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BowlArea extends StatelessWidget {
  const BowlArea({
    Key? key,
    required this.game,
  }) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      runAlignment: WrapAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < game.colors.length; i++)
          DragTarget<Candy>(builder: (context, candies, dontKnow) {
            for (var candy in candies) {
              if (game.colors[i] == candy?.color) {
                game.removeCandy(candy!);
              }
            }
            return Bowl(
              color: game.colors[i],
            );
          })
      ],
    );
  }
}
