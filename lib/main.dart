import 'package:flutter/material.dart';
import 'package:flutter_games/environment_screen.dart';
import 'package:flutter_games/guess_game.dart';
import 'package:flutter_games/home.dart';
import 'package:flutter_games/monster_game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  _MyApp();

  bool isGame = false;
  String playerName = "";
  late String backGround;
  bool isEnvironment = false;

  void onRestart() {
    setState(() {
      isEnvironment = true;
      isGame = true;
    });
  }

  void onResume() {}
  void onExit() {
    setState(() {
      isEnvironment = false;
      isGame = false;
    });
  }

  void onClickedEnvironmentTile(String filePath) {
    setState(() {
      backGround = filePath;
      isEnvironment = true;
    });
  }

  void onClicked(String message) {
    setState(() {
      isGame = !isGame;
      playerName = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 48, 46, 46),
        // appBar: AppBar(
        //   title: Align(
        //     alignment: Alignment.topRight,
        //     child: Text(
        //       '',
        //       style: TextStyle(fontSize: 17),
        //       textAlign: TextAlign.end,
        //     ),
        //   ),
        //   backgroundColor: Colors.pink,
        // ),
        // body: !isGame
        //     ? Home(onClicked: onClicked)
        //     : MonsterGamePage(playerNmae: playerName),
        body: !isGame
            ? Home(onClicked: onClicked)
            : !isEnvironment
            ? EnvironmentChooseScreen(onClicked: onClickedEnvironmentTile)
            : MonsterGamePage(
                onExit: onExit,
                onRestart: onRestart,
                onResume: onResume,
                backGroundImg: backGround,
                playerNmae: playerName,
              ),
      ),
    );
    // TODO: implement build
  }
}
