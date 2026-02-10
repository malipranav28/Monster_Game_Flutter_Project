import 'package:flutter/material.dart';
import 'package:flutter_games/environment.dart';
import 'package:flutter_games/environment_tile.dart';

class CarosalSlider extends StatefulWidget {
  final List<Environment> environments;
  final void Function(String) onclicked;

  const CarosalSlider({
    super.key,
    required this.environments,
    required this.onclicked,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CarosalSliderState();
  }
}

class _CarosalSliderState extends State<CarosalSlider> {
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        PageView(
          controller: _controller,
          children: [
            for (var env in widget.environments)
              EnvironmentTile(
                env.name,
                env.filePath,
                onClicked: widget.onclicked,
              ),
          ],
        ),
        Positioned(
          child: IconButton(
            onPressed: () => _controller.previousPage(
              duration: const Duration(milliseconds: 800),
              curve: Curves.ease,
            ),
            icon: Icon(
              Icons.arrow_left_rounded,
              size: 100.00,
              color: Colors.grey,
            ),
          ),
          left: -20,
          top: 120,
        ),
        Positioned(
          child: IconButton(
            onPressed: () => _controller.nextPage(
              duration: const Duration(milliseconds: 800),
              curve: Curves.ease,
            ),
            icon: Icon(
              Icons.arrow_right_rounded,
              size: 100.00,
              color: Colors.grey,
            ),
          ),
          right: -20,
          top: 120,
        ),
      ],
    );
  }
}
