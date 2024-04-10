import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:mindful_flutter_util/mindful_flutter_util.dart';

class WavyGradientDecoratedContainer extends StatelessWidget {
  final List<Color> gradientColors;

  const WavyGradientDecoratedContainer(
      {super.key, required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var width = min(constraints.maxWidth, context.width);
        var height = min(constraints.maxHeight, context.height);
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
