import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:WordSeeker/animations/bounce.dart';
import 'package:WordSeeker/components/tile_6.dart';

import '../animations/dance.dart';
import '../providers/controller_5.dart';

class Grid extends StatefulWidget {
  const Grid({
    Key? key,
  }) : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),
        itemCount: 36,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 6,
        ),
        itemBuilder: (context, index) {
          return Consumer<Controller_5>(
            builder: (_, notifier, __) {
              bool animate = false;
              bool animateDance = false;
              int danceDelay = 1600;
              if (index == (notifier.currentTile - 1) &&
                  !notifier.backOrEnterTapped) {
                animate = true;
              }
              if (notifier.gameWon) {
                for (int i = notifier.tilesEntered.length - 6;
                    i < notifier.tilesEntered.length;
                    i++) {
                  if (index == i) {
                    animateDance = true;
                    danceDelay += 150 * (i - ((notifier.currentRow - 1) * 6));
                  }
                }
              }
              return Dance(
                delay: danceDelay,
                animate: animateDance,
                child: Bounce(
                    animate: animate,
                    child: Tile(
                      index: index,
                    )),
              );
            },
          );
        });
  }
}
