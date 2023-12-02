import 'package:flutter/material.dart';
import 'package:wordle_clone/pages/game_menu.dart';
import 'package:wordle_clone/pages/settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home> {
  @override
  void initState() {
    super.initState();

    // Access the Controller and reset the game
    // Provider.of<Controller>(context, listen: false).resetGame()
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
            SizedBox(
              width: 150.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameMenu()),
                  );
                },
                child: const Text('PLAY'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 150.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                child: const Text('Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
