import 'package:flutter/material.dart';
import 'package:flutter_games/environment_screen.dart';
import 'package:flutter_games/glow_demo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    // TODO: implement createState
    return _Home();
  }
}

class _Home extends State<Home> {
  _Home();
  final TextEditingController _textEditingController = TextEditingController();
  String? nameError;
  late double value;
  late double loaderValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startLoader();
  }

  void startLoader() async {
    loaderValue = 0.5;
    await Future.delayed(
      const Duration(seconds: 2),
      () => setState(() {
        loaderValue = 0.8;
      }),
    );
    await Future.delayed(
      const Duration(seconds: 1),
      () => setState(() {
        loaderValue = 1;
      }),
    );
    await Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const EnvironmentChooseScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/Game_Logo.png", height: 200),
          Container(
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            clipBehavior: Clip.hardEdge,
            child: LinearProgressIndicator(
              value: loaderValue,
              backgroundColor: DefaultSelectionStyle.defaultColor,
              color: Colors.white,
              minHeight: 30,
            ),
          ),
        ],
      ),
    );
  }
}
