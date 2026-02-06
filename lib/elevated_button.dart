import 'package:flutter/material.dart';
import 'package:flutter_games/monster_game_page.dart';

class ButtonForGame extends StatelessWidget {
  const ButtonForGame({
    super.key,
    required this.clickedOn,
    required this.name,
    this.game,
  });
  final void Function()? clickedOn;
  final GmaeButton? game;
  final String name;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      onPressed: clickedOn,
      child: Text(
        name,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.black,
        backgroundColor: _getColor(),
      ),
    );
  }

  Color? _getColor() {
    switch (game) {
      case GmaeButton.danger:
        // TODO: Handle this case.
        return Colors.red;
      case GmaeButton.success:
        // TODO: Handle this case.
        return Colors.green;
      case GmaeButton.info:
        // TODO: Handle this case.
        return Colors.blue;
      case null:
        return Colors.deepOrange;
    }
  }
}
