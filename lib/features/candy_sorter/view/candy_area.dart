import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:candy_sorter/features/candy_sorter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CandyArea extends StatefulWidget {
  const CandyArea({
    Key? key,
    required this.game,
  }) : super(key: key);

  final Game game;

  @override
  State<CandyArea> createState() => _CandyAreaState();
}

class _CandyAreaState extends State<CandyArea> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Stack(
          children: [
            for (var candy in widget.game.candies)
              Positioned(
                top: candy.top,
                left: candy.left,
                child: Draggable<Candy>(
                  data: candy,
                  feedback: CandyWidget(
                    candy: candy,
                  ),
                  child: CandyWidget(
                    candy: candy,
                  ),
                  childWhenDragging: Container(),
                  onDragCompleted: () => setState(() {}),
                ),
              ),
          ],
        );
      },
    );
  }
}
