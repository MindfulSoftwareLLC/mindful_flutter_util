import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

// Widget used to change the used FlexScheme in example 3.
class ThemeSelectButtons extends StatelessWidget {
  const ThemeSelectButtons({
    // super.key,
    required this.scheme,
    required this.onChanged,
  });
  final FlexScheme scheme;
  final ValueChanged<FlexScheme> onChanged;

  @override
  Widget build(BuildContext context) {
    final List<bool> isSelected = <bool>[
      scheme == FlexScheme.custom,
      scheme == FlexScheme.mallardGreen,
      scheme == FlexScheme.outerSpace,
      scheme == FlexScheme.hippieBlue,
    ];
    return ToggleButtons(
      borderRadius: BorderRadius.all(Radius.zero),
      isSelected: isSelected,
      onPressed: (int newIndex) {
        if (newIndex == 0) {
          onChanged(FlexScheme.custom);
        } else if (newIndex == 1) {
          onChanged(FlexScheme.mallardGreen);
        } else if (newIndex == 2) {
          onChanged(FlexScheme.outerSpace);
        } else {
          onChanged(FlexScheme.hippieBlue);
        }
      },
      children: [
        Container(
          color: Color(0xFF00296B),
          child: const Padding(padding: EdgeInsets.all(12)),
        ),
        Container(
          color: FlexColor.schemes[FlexScheme.mallardGreen]?.light.primary,
          child: const Padding(padding: EdgeInsets.all(12)),
        ),
        Container(
          color: FlexColor.schemes[FlexScheme.outerSpace]?.light.primary,
          child: const Padding(padding: EdgeInsets.all(12)),
        ),
        Container(
          color: FlexColor.schemes[FlexScheme.hippieBlue]?.light.primary,
          child: const Padding(padding: EdgeInsets.all(12)),
        ),
      ],
    );
  }
}