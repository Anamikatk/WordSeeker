import 'package:flutter/material.dart';
import 'package:wordle_clone/pages/home.dart';
import 'package:wordle_clone/pages/settings.dart';
// import 'package:wordle_clone/pages/wordle5.dart';

class Home1 extends StatelessWidget {
  const Home1({Key? key}) : super(key: key);

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
                    MaterialPageRoute(builder: (context) => const HomePage1()),
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
