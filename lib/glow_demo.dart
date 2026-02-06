import 'package:flutter/material.dart';

class TestGlowBox extends StatefulWidget {
  const TestGlowBox({super.key});

  @override
  State<TestGlowBox> createState() => _TestGlowBoxState();
}

class _TestGlowBoxState extends State<TestGlowBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Container(
            width: 150,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00FF66),
                  blurRadius: 35 + (_controller.value * 25),
                  spreadRadius: 8 + (_controller.value * 6),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              "GLOW",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
