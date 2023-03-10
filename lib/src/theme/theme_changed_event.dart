import 'package:flutter/material.dart';

class ThemeChangedEvent {
  final ThemeData _lightTheme;
  final ThemeData _darkTheme;

  ThemeChangedEvent(this._lightTheme, this._darkTheme);

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;
}
