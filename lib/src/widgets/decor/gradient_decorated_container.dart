import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';

class GradientDecoratedContainer extends StatelessWidget {
  final List<Color> gradientColors;

  const GradientDecoratedContainer({super.key, required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var width = math.min(constraints.maxWidth, context.width);
        var height = math.min(constraints.maxHeight, context.height);
        return Transform.rotate(
            angle: -35 * math.pi / 180,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment(-0.2, -0.9),
                    end: Alignment.bottomCenter,
                  )),
            ));
      },
    );
  }
}
