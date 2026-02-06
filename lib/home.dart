import 'package:flutter/material.dart';
import 'package:flutter_games/glow_demo.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.onClicked});
  final void Function(String) onClicked;

  @override
  State<Home> createState() {
    // TODO: implement createState
    return _Home(onClicked);
  }
}

class _Home extends State<Home> {
  _Home(this.onClicked);
  void Function(String) onClicked;
  final TextEditingController _textEditingController = TextEditingController();
  String? nameError;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        height: 200,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.amber,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 228, 213, 11).withOpacity(0.4),
              blurRadius: 35,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter Your Name", style: TextStyle(fontSize: 20)),
            Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  errorText: nameError,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name = _textEditingController.text.trim();
                if (name.isEmpty) {
                  setState(() {
                    nameError = "Enter Name";
                  });
                } else {
                  onClicked(_textEditingController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                shadowColor: Colors.deepOrange,
                elevation: 5,
              ),
              child: Text(
                "Start",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
