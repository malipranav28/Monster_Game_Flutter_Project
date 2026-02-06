import 'package:flutter/material.dart';
import 'package:flutter_games/progress_bar.dart';

class GameTile extends StatefulWidget {
  const GameTile({
    super.key,
    required this.name,
    required this.health,
    required this.filePath,
    required this.isHealing,
  });

  final String name;
  final int health;
  final String filePath;
  final bool isHealing;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GameTileState();
  }
}

class _GameTileState extends State<GameTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  Widget build(BuildContext context) {
    double healthValue = widget.health / 100;
    // TODO: implement build
    return Column(
      children: [
        Text(
          widget.name,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.amberAccent,
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                boxShadow: widget.isHealing
                    ? [
                        BoxShadow(
                          color: const Color(0xFF00FF66),
                          blurRadius: 35,
                          spreadRadius: 8,
                        ),
                      ]
                    : [],
              ),
              alignment: Alignment.center,
              child: Image.asset(widget.filePath, height: 200),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 26,
                child: ProgressBar(value: healthValue, glow: widget.isHealing),
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(8),
              //   child: LinearProgressIndicator(
              //     value: health / 100,
              //     minHeight: 20,
              //     backgroundColor: Colors.grey.shade300,
              //     valueColor: AlwaysStoppedAnimation(
              //       health > 50
              //           ? Colors.green
              //           : health > 25
              //           ? Colors.orange
              //           : Colors.red,
              //     ),
              //   ),
              // ),
              // Text(
              //   "$health %", // The text inside the bar
              //   style: const TextStyle(
              //     color: Colors.white, // Make sure it is visible
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
