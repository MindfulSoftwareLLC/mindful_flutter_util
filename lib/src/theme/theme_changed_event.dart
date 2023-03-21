import 'package:flutter/material.dart';

class ThemeChangedEvent {
  final ThemeData _lightTheme;
  final ThemeData _darkTheme;
  final ThemeMode _themeMode;

  ThemeChangedEvent(this._lightTheme, this._darkTheme, this._themeMode);

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;
  ThemeMode get themeMode => _themeMode;
}
