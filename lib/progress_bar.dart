import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double value;

  bool glow;
  ProgressBar({super.key, required this.value, required this.glow});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProgressBarState();
  }
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void didUpdateWidget(covariant ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.glow && !oldWidget.glow) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: 300,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: widget.glow
                ? [
                    BoxShadow(
                      color: const Color(0xFF00FF66),
                      blurRadius: 35 + (_controller.value * 25),
                      spreadRadius: 8 + (_controller.value * 6),
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Stack(
            children: [
              LinearProgressIndicator(
                backgroundColor: Colors.white,
                value: widget.value,
                minHeight: 20,
                valueColor: const AlwaysStoppedAnimation(Colors.greenAccent),
              ),
              Center(
                child: Text(
                  "${(widget.value * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color.fromARGB(255, 14, 12, 12),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
