import 'package:flutter/material.dart';

import '../../mindful_flutter_util.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required String value,
    required this.label,
    required this.onChanged,
  }) : _value = value;

  final String _value;
  final String label;
  final Function(dynamic name) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: TextEditingController(text: _value),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: formInputTextStyle,
      ),
      keyboardAppearance: Brightness.light,
      style: formTextFieldStyle,
      maxLines: null,
      onChanged: onChanged,
    );
  }
}
