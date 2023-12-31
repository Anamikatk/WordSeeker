import 'package:flutter/material.dart';
import 'package:WordSeeker/pages/wordle4.dart';
import 'package:WordSeeker/pages/wordle6.dart';
import 'package:WordSeeker/pages/wordle5.dart';

class GameMenu extends StatefulWidget {
  const GameMenu({Key? key}) : super(key: key);

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<GameMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WORD SEEKER'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Wordle4()),
                );
              },
              child: const Text('4 Letters'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Wordle5()),
                );
              },
              child: const Text('5 Letters'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Wordle6()),
                );
              },
              child: const Text('6 Letters'),
            ),
          ],
        ),
      ),
    );
  }
}
