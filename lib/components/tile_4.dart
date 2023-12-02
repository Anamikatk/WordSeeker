import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:WordSeeker/constants/answer_stages.dart';
import 'package:WordSeeker/constants/colors.dart';
import 'package:WordSeeker/providers/controller_5.dart';

class Tile extends StatefulWidget {
  const Tile({required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  Color _backgroundColor = Colors.transparent, _borderColor = Colors.transparent;
  late AnswerStage _answerStage;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _borderColor = Theme.of(context).primaryColorLight;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller_5>(
      builder: (_, notifier, __) {
        String text = "";
        Color fontColor = Colors.white;

        if (widget.index < notifier.tilesEntered.length) {
          text = notifier.tilesEntered[widget.index].letter;
          _answerStage = notifier.tilesEntered[widget.index].answerStage;

          if (notifier.checkLine) {
            final delay = widget.index - (notifier.currentRow - 1) * 4;
            Future.delayed(Duration(milliseconds: 300 * delay), () {
              _animationController.forward();
              notifier.checkLine = false;
            });

            _backgroundColor = Theme.of(context).primaryColorLight;
            if (_answerStage == AnswerStage.correct) {
              _backgroundColor = correctGreen;
            } else if (_answerStage == AnswerStage.contains) {
              _backgroundColor = containsYellow;
            } else if (_answerStage == AnswerStage.incorrect) {
              _backgroundColor = Theme.of(context).primaryColorDark;
            } else {
              fontColor = Theme.of(context).textTheme.bodyText2?.color ??
                  Colors.black;
              _backgroundColor = Colors.transparent;
            }
          }
        }

        return AnimatedBuilder(
          animation: _animationController,
          builder: (_, child) {
            double flip = 0;
            if (_animationController.value > 0.50) {
              flip = pi;
            }

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.003)
                ..rotateX(_animationController.value * pi)
                ..rotateX(flip),
              child: Container(
                decoration: BoxDecoration(
                  color: flip > 0 ? _backgroundColor : Colors.transparent,
                  border: Border.all(
                    color: flip > 0 ? Colors.transparent : _borderColor,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: flip > 0
                        ? Text(text,
                            style: TextStyle().copyWith(
                                color: fontColor,
                            ))
                        : Text(text),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
