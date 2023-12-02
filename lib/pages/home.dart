import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_clone/providers/controller.dart';
import 'package:wordle_clone/pages/wordle5.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  void initState() {
    super.initState();

    // Access the Controller and reset the game
    // Provider.of<Controller>(context, listen: false).resetGame();
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
                  MaterialPageRoute(builder: (context) => const Wordle5()),
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
                  MaterialPageRoute(builder: (context) => const Wordle5()),
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
