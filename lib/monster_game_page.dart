import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_games/elevated_button.dart';
import 'package:flutter_games/monster_game_tile.dart';
import 'package:flutter_games/option_icon.dart';

class MonsterGamePage extends StatefulWidget {
  final String backGroundImg;

  const MonsterGamePage({super.key, required this.backGroundImg});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MonsterGameState();
  }
}

class _MonsterGameState extends State<MonsterGamePage>
    with SingleTickerProviderStateMixin {
  int monsterHealth = 100;
  int playerHealth = 100;
  bool isSuperAttack = false;
  int attackCount = 0;
  String playerName = "";
  String winnerMessage = "";
  bool isGameOver = false;
  bool isShowFightText = true;
  late AnimationController _shakeAnimation;
  double shakeStrength = 5; // default shake
  int shakeCount = 1;

  bool isHealing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isShowFightText = false;
      });
    });

    _shakeAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // short shake
    );
  }

  int generateRandom(int min, int max) {
    return min + Random().nextInt(max - min + 1);
  }

  void onRestartOption(BuildContext context) {
    playAgain();
  }

  void heal() {
    setState(() {
      isHealing = true;
      int heal = generateRandom(15, 20);
      playerHealth += heal;
      if (playerHealth > 100) {
        playerHealth = 100;
      }
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isHealing = false;
      });
    });
    monsterAttack();
    attackCount = 0;
    isSuperAttack = false;
    checkWinner();
  }

  void checkWinner() {
    setState(() {
      if (playerHealth <= 0) {
        winnerMessage = "Monster win";
        isGameOver = true;
      } else if (monsterHealth <= 0) {
        isGameOver = true;
        winnerMessage = "Player win";
        ;
      }
    });
    if (playerHealth <= 0 || monsterHealth <= 0) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          winnerMessage = "";
        });
      });
    }
  }

  void monsterAttack() {
    setState(() {
      int monsterAttack = generateRandom(8, 15);
      playerHealth -= monsterAttack;
      if (playerHealth <= 0) {
        playerHealth = 0;
      }
    });

    checkWinner();
  }

  void playerAttack() {
    //light Impact
    HapticFeedback.heavyImpact();

    _shakeAnimation.forward(from: 0);
    shakeStrength = 10;
    setState(() {
      int playerAttack = generateRandom(5, 12);
      monsterHealth -= playerAttack;
      if (monsterHealth <= 0) {
        monsterHealth = 0;
      }
      monsterAttack();
      attackCount++;
      if (attackCount >= 2 && !isSuperAttack) {
        isSuperAttack = true;
      }
    });
    checkWinner();
  }

  void superAttack() {
    //strong vibration for super attack
    HapticFeedback.heavyImpact();
    shakeStrength = 10; // BIG shake

    _shakeAnimation
      ..reset()
      ..repeat(count: 2); // multiple shakes

    setState(() {
      int playerAttack = generateRandom(10, 20);
      monsterHealth -= playerAttack;
      if (monsterHealth <= 0) {
        monsterHealth = 0;
      }
      monsterAttack();
      attackCount = 0;
      isSuperAttack = false;
    });
    checkWinner();
  }

  void playAgain() {
    setState(() {
      monsterHealth = 100;
      playerHealth = 100;
      isSuperAttack = false;
      attackCount = 0;
      playerName = "";
      winnerMessage = "";
      isGameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(widget.backGroundImg, fit: BoxFit.cover),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      sin(_shakeAnimation.value * pi * 10) * shakeStrength,
                      0,
                    ),
                    child: child,
                  );
                },
                child: GameTile(
                  name: "Monster",
                  health: monsterHealth,
                  filePath: "assets/monsterAvatar.png",
                  isHealing: false,
                ),
              ),
              SizedBox(height: 20),
              !isGameOver
                  ? Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(50, 1, 1, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          ButtonForGame(
                            clickedOn: isSuperAttack ? heal : null,
                            name: "Heal",
                            game: GmaeButton.success,
                          ),

                          ButtonForGame(
                            clickedOn: playerAttack,
                            name: "Attack",
                            game: GmaeButton.danger,
                          ),

                          ButtonForGame(
                            clickedOn: isSuperAttack ? superAttack : null,
                            name: "Super Attack",
                            game: GmaeButton.info,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        ButtonForGame(
                          clickedOn: playAgain,
                          name: "Play Again",
                          game: null,
                        ),
                      ],
                    ),

              SizedBox(height: 20),
              AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(sin(_shakeAnimation.value * pi * 10) * 5, 0),
                    child: child,
                  );
                },
                child: GameTile(
                  name: "Player",
                  health: playerHealth,
                  filePath: "assets/PlayerAvatar.png",
                  isHealing: isHealing,
                ),
              ),
            ],
          ),
        ),
        if (isShowFightText || winnerMessage.isNotEmpty)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              color: Colors.black.withOpacity(0.3), // dark blur
            ),
          ),

        // Text(winnerMessage),
        if (isShowFightText || winnerMessage.isNotEmpty)
          Center(
            child: AnimatedOpacity(
              opacity: isShowFightText || winnerMessage.isNotEmpty ? 1.0 : 0.0,
              duration: Duration(milliseconds: 800),
              child: Text(
                isGameOver ? winnerMessage : "Lets Fight",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
        Positioned(
          top: 8,
          left: 5,
          child: GameOption(onRestart: onRestartOption),
        ),
      ],
    );
  }
}

enum GmaeButton { danger, success, info }
