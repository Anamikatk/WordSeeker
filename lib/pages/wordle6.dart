import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:WordSeeker/pages/settings.dart';
import 'package:WordSeeker/utils/quick_box.dart';
import '../components/grid_6.dart';
import '../components/keyboard_row_6.dart';
import '../components/stats_box.dart';
import '../constants/words6_large.dart';
import '../providers/controller_5.dart';

class Wordle6 extends StatefulWidget {
  const Wordle6({Key? key}) : super(key: key);

  @override
  State<Wordle6> createState() => _Wordle5State();
}

class _Wordle5State extends State<Wordle6> {
  late String _word;

  @override
void initState() {
  // Reset the game
  Provider.of<Controller_5>(context, listen: false).resetGame();

  // Reset the tile colors
  // Provider.of<Controller>(context, listen: false).resetKeyboardColors();

  // Generate a new word
  final r = Random().nextInt(words_6_large.length);
  _word = words_6_large[r];

  // Set the correct word in the Controller
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Provider.of<Controller_5>(context, listen: false).setCorrectWord(word: _word);
  });

  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WORD-SEEKER'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Consumer<Controller_5>(
            builder: (_, notifier, __) {
              if (notifier.notEnoughLetters) {
                runQuickBox(context: context, message: 'Not Enough Letters');
              }
              if (notifier.notValidWord) {
                runQuickBox(context: context, message: 'Invalid Word');
                notifier.notValidWord = false;
              }
              if (notifier.gameCompleted) {
                if (notifier.gameWon) {
                  if (notifier.currentRow == 6) {
                    runQuickBox(context: context, message: 'Phew!');
                  } else {
                    runQuickBox(context: context, message: 'Splendid!');
                  }
                } else {
                  runQuickBox(context: context, message: notifier.correctWord);
                }
                Future.delayed(
                  const Duration(milliseconds: 4000),
                  () {
                    if (mounted) {
                      showDialog(
                        context: context,
                        builder: (_) => const StatsBox(),
                      );
                    }
                  },
                );
              }
              return IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (_) => const StatsBox(),
                  );
                },
                icon: const Icon(Icons.bar_chart_outlined),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const Column(
        children: [
          Divider(
            height: 1,
            thickness: 2,
          ),
          Expanded(flex: 7, child: Grid()),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                KeyboardRow(
                  min: 1,
                  max: 10,
                ),
                KeyboardRow(
                  min: 11,
                  max: 19,
                ),
                KeyboardRow(
                  min: 20,
                  max: 29,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
