import 'dart:math';

import 'package:flutter/material.dart';

class GuessGame extends StatefulWidget {
  const GuessGame({super.key, required this.playerName});

  final playerName;
  @override
  State<GuessGame> createState() {
    // TODO: implement createState
    return _GuessGameState(playerName: playerName);
  }
}

class _GuessGameState extends State<GuessGame> {
  _GuessGameState({required this.playerName});
  final TextEditingController _controller = TextEditingController();
  int totalGuesses = 5;
  int playerGuesses = 0;
  int secretNumber = Random().nextInt(10) + 1;
  bool isGameOver = false;
  String message = '';
  String winningMessage = "";
  final String playerName;

  void checkGuess() {
    int guess = int.tryParse(_controller.text) ?? 0;
    if (playerGuesses == totalGuesses ||
        int.tryParse(_controller.text) == secretNumber) {
      isGameOver = true;
    }
    setState(() {
      playerGuesses++;
      if (guess == secretNumber) {
        message = "";
        winningMessage = "${playerName.toUpperCase()} YOU WIN";
      } else if (guess < secretNumber) {
        message = "You Guess too low";
      } else {
        message = "You Guess too high";
      }

      if (playerGuesses == totalGuesses ||
          int.tryParse(_controller.text) == secretNumber) {
        winningMessage = "${playerName.toUpperCase()} YOU LOSE";
        isGameOver = true;
      }
    });
  }

  void playAgain() {
    setState(() {
      playerGuesses = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Guess The Number From 1 to 10",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.left,
          ),
          Tile(letter: secretNumber, isShow: isGameOver),
          SizedBox(height: 20),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Your Guess ",
            ),
          ),
          SizedBox(height: 20),
          Text("total guesses : ${playerGuesses}/${totalGuesses}"),
          if (winningMessage.isNotEmpty)
            Text(
              winningMessage,
              style: TextStyle(fontSize: 35, color: Colors.amber),
            ),
          ElevatedButton(
            onPressed: isGameOver ? playAgain : checkGuess,
            child: isGameOver ? Text("Play Again") : Text("Guess"),
          ),
          Text(message),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({super.key, required this.letter, required this.isShow});
  final int letter;
  final bool isShow;

  @override
  Widget build(Object context) {
    // TODO: implement build
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: BoxBorder.all(),
        color: isShow ? Colors.deepOrangeAccent : Colors.black,
      ),
      child: Center(
        child: isShow
            ? Text(
                "${letter}",
                style: TextStyle(fontSize: 24, color: Colors.white),
              )
            : Text("?", style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }
}
