import 'package:flutter/material.dart';

class GameOption extends StatelessWidget {
  final void Function(BuildContext context) onRestart;
  const GameOption({super.key, required this.onRestart});

  void onExit(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      icon: Icon(Icons.menu, color: Colors.white, size: 40),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => Center(
            child: Container(
              height: 280,
              width: 260,
              decoration: BoxDecoration(
                color: const Color.fromARGB(250, 14, 9, 9),
                border: BoxBorder.all(
                  color: Color.fromARGB(75, 6, 6, 207),
                  width: 7,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Paused",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: 230,
                    color: Colors.blueGrey,
                    child: Column(
                      spacing: 20,
                      children: [
                        OptionButton(
                          onClicked: onRestart,
                          name: "Restart",
                          icon: Icons.restart_alt,
                        ),
                        OptionButton(name: "Resume", icon: Icons.fast_rewind),
                        OptionButton(
                          onClicked: onExit,
                          name: "Exit",
                          icon: Icons.exit_to_app,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class OptionButton extends StatelessWidget {
  final String name;
  void Function(BuildContext)? onClicked;
  final IconData icon;

  OptionButton({
    super.key,
    required this.name,
    this.onClicked,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        onClicked?.call(context);
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(160, 50),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: const BorderSide(
            color: Color.fromARGB(255, 173, 172, 172), // outer dark border
            width: 5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: AlignmentGeometry.center,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(221, 29, 25, 25),
                border: Border.all(
                  color: const Color.fromARGB(
                    255,
                    19,
                    16,
                    16,
                  ), // inner light/dark border
                  width: 3,
                ),
              ),
              child: Row(
                children: [
                  Icon(icon),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 240, 237, 237),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
