// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_games/carosal_slider.dart';
import 'package:flutter_games/environment.dart';
import 'package:flutter_games/environment_tile.dart';
import 'package:flutter_games/starting_button.dart';

class EnvironmentChooseScreen extends StatelessWidget {
  static const environments = [
    Environment(
      filePath: "assets/environment_background/Volcanic_Wasteland.png",
      name: "Volcanic Wasteland",
    ),
    Environment(
      filePath: "assets/environment_background/Frozen_Tundra.png",
      name: "Frozen Tundra",
    ),
    Environment(
      filePath: "assets/environment_background/Mystic_Forest.png",
      name: "Mystic Forest",
    ),
    Environment(
      filePath: "assets/environment_background/Desert_Ruins.png",
      name: "Desert Ruins",
    ),
    Environment(
      filePath: "assets/environment_background/Shadow Realm.png",
      name: "Shadow Realm",
    ),
    Environment(
      filePath: "assets/environment_background/Sky_Islands.png",
      name: "Sky Islands",
    ),
  ];

  final void Function(String) onClicked;

  const EnvironmentChooseScreen({super.key, required this.onClicked});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choose Location",
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: environments.length - 1,
            itemBuilder: (BuildContext context, int index) {
              return EnvironmentTile(
                onClicked: onClicked,
                environments[index].name,
                environments[index].filePath,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 20);
            },
          ),
        ),
        // SizedBox(
        //   height: 400,
        //   child: CarosalSlider(
        //     environments: environments,
        //     onclicked: onClicked,
        //   ),
        // ),

        // StartingButton(),
      ],
    );
  }
}
