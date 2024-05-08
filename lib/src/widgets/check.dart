import 'package:flutter/material.dart';

import '../../mindful_flutter_util.dart';

class Check extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String label;

  const Check(
      {super.key, required this.label, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Label(label),
      Checkbox(
        value: value,
        onChanged: onChanged,
      )
    ]);
  }
}
