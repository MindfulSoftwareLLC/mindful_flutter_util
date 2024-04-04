// Flutter imports:
import 'package:flutter/material.dart';

extension ColorX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension GradientX on LinearGradient {
  LinearGradient withOpacity(double opacity) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: colors.map((e) {
        return e.withOpacity(opacity);
      }).toList(),
    );
  }
}
