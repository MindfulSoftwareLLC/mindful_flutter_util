import 'package:flutter/widgets.dart';

class PulsingSpinningIcon extends StatefulWidget {
  final IconData? icon;
  final Color color;

  const PulsingSpinningIcon({super.key, this.icon, required this.color});

  @override
  _PulsingSpinningIconState createState() => _PulsingSpinningIconState();
}

class _PulsingSpinningIconState extends State<PulsingSpinningIcon>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation!.value,
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_controller!),
            child: Icon(widget.icon, size: 50, color: widget.color),
          ),
        );
      },
    );
  }
}
