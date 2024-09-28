import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF3F51B5), width: 2),
    ),
    fillColor: Colors.grey[50],
    filled: true,
    labelStyle: TextStyle(color: Colors.grey[700]),
    floatingLabelStyle: const TextStyle(color: Color(0xFF3F51B5)),
  );
}
