import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'input_decoration.dart';

class DateInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String fieldName;
  final Function(String) onSave;

  DateInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.fieldName,
    required this.onSave,
  });

  final _dateMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length < 10) {
      return null;
    }
    try {
      final date = DateFormat('yMd').parseStrict(value);
      if (date.isAfter(DateTime.now())) {
        return 'Date cannot be in the future';
      }
    } catch (e) {
      return 'Please enter a valid date, US style, month first (YYYY/MM/DD)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: buildInputDecoration(label),
        style: const TextStyle(color: Colors.black87),
        keyboardType: TextInputType.datetime,
        inputFormatters: [_dateMask],
        validator: _validateDate,
        onChanged: (value) {
          if (value.isEmpty) {
            debugPrint('Saving $fieldName: $value');
            onSave('');
          } else if (value.length == 10) {
            final validationResult = _validateDate(value);
            if (validationResult == null) {
              debugPrint('Saving $fieldName: $value');
              onSave(value);
            } else {
              debugPrint('Not saving invalid date for $fieldName: $value');
            }
          }
        },
      ),
    );
  }
}
