import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';

class GradientAnimatedContainer extends StatefulWidget {
  final List<Color> gradientColors;
  final Widget? behindWidget;

  const GradientAnimatedContainer({
    super.key,
    required this.gradientColors,
    this.behindWidget,
  });

  @override
  _GradientAnimatedContainerState createState() =>
      _GradientAnimatedContainerState();
}

class _GradientAnimatedContainerState extends State<GradientAnimatedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Animation<double>> _rotations = [];
  List<BorderRadius> _borderRadiuses = [
    BorderRadius.circular(100),
    BorderRadius.circular(100),
    BorderRadius.circular(100)
  ];
  List<Animation<Color?>> _colors = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
          seconds:
              120), // Total duration for one full cycle including the pause
      vsync: this,
    );

    for (int i = 0; i < widget.gradientColors.length - 1; i++) {
      _colors.add(ColorTween(
        begin: widget.gradientColors[i],
        end: i < widget.gradientColors.length - 1
            ? widget.gradientColors[i + 1]
            : widget.gradientColors[0],
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.25,
            curve:
                Curves.easeInOut), // Animation happens in the first 30 seconds
      )));
    }

    for (int i = 0; i < 3; i++) {
      _rotations.add(Tween<double>(begin: 0, end: 2 * math.pi).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 0.25, curve: Curves.easeInOut)),
      ));
    }

    _controller.addListener(() {
      if (_controller.value >= 0.25 && _controller.value < 1.0) {
        // Freeze transformations during the pause
        _controller.value = 0.25;
      }
      setState(() {
        double progress = _controller.value *
            4; // Adjusting the progress range to [0, 1] for calculations
        double inverseProgress = 1 - progress;
        _borderRadiuses = [
          BorderRadius.circular(100 * inverseProgress),
          BorderRadius.circular(100 * progress),
          BorderRadius.circular(50 + 50 * math.sin(progress * math.pi)),
        ];
      });
    });

    _controller.repeat(); // This will cause the animation to loop indefinitely
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = math.min(constraints.maxWidth, context.width);
        final height = math.min(constraints.maxHeight, context.height);
        return Stack(
          children: <Widget>[
            widget.behindWidget ?? SizedBox.fromSize(),
            ...List<Widget>.generate(3, (index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // Adding perspective
                      ..rotateX(_rotations[index].value)
                      ..rotateY(_rotations[index].value),
                    alignment: FractionalOffset.center,
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: _borderRadiuses[index],
                        gradient: LinearGradient(
                          colors: _colors
                              .map((color) => color.value ?? Colors.transparent)
                              .toList(),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  );
                },
              );
            })
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
