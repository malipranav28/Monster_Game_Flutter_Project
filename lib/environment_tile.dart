import 'package:flutter/material.dart';

class EnvironmentTile extends StatelessWidget {
  final String name;
  final String filePath;
  final void Function(String) onClicked;

  const EnvironmentTile(
    this.name,
    this.filePath, {
    super.key,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => {onClicked(filePath)},
      child: Container(
        height: 210,
        width: 140,
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(137, 146, 142, 142),
              blurRadius: 5,
              spreadRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(filePath, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
