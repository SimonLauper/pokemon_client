import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({required this.isFav, required this.onToggle, super.key});

  final bool isFav;
  final VoidCallback onToggle;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _sizeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 25, end: 36), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 36, end: 25), weight: 50),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return IconButton(
          onPressed: () {
            _controller.reset();
            _controller.forward();
            widget.onToggle();
          },
          icon: Icon(
            Icons.favorite,
            color: widget.isFav
                ? const Color(0xFFEF4444)
                : Colors.white.withOpacity(0.25),
            size: _sizeAnimation.value,
          ),
        );
      },
    );
  }
}
