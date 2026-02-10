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
  late double progressLoader;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startLoader();
  }

  void startLoader() async {
    if (!isGame && !isEnvironment) {
      progressLoader = 0.5;
      await Future.delayed(
        const Duration(seconds: 2),
        () => setState(() {
          progressLoader = 0.8;
        }),
      );
      await Future.delayed(
        const Duration(seconds: 1),
        () => setState(() {
          progressLoader = 1;
        }),
      );
      await Future.delayed(
        const Duration(seconds: 1),
        () => setState(() {
          isGame = true;
        }),
      );
    }
  }

  void onRestart() {
    print("Restart");
    setState(() {
      isEnvironment = true;
      isGame = true;
    });
  }

  void onResume() {}
  void onExit() {
    print("Exit run");
    setState(() {
      isEnvironment = false;
      isGame = true;
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
            ? Home(onClicked: onClicked, value: progressLoader)
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
