import 'package:flutter/material.dart';
import 'package:flutter_games/environment_screen.dart';
import 'package:flutter_games/guess_game.dart';
import 'package:flutter_games/home.dart';
import 'package:flutter_games/monster_game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 48, 46, 46),
        body: Home(),
      ),
    );
    // TODO: implement build
  }
}
