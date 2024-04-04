import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Layout breakpoints used in the app.
class Breakpoint {
  static const double desktop = 1200;
  static const double tablet = 800;
}

extension ResponsiveExtensions on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < Breakpoint.tablet;

  bool get isTablet =>
      MediaQuery.of(this).size.width >= Breakpoint.tablet &&
      MediaQuery.of(this).size.width <= Breakpoint.desktop;

  bool get isDesktop => MediaQuery.of(this).size.width > Breakpoint.desktop;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Color get primary => Theme.of(this).colorScheme.primary;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  TargetPlatform get platform => Theme.of(this).platform;

  bool get isAndroid => (platform == TargetPlatform.android);

  bool get isIOS => (platform == TargetPlatform.iOS);

  bool get isMacOS => (platform == TargetPlatform.macOS);

  bool get isLinux => (platform == TargetPlatform.linux);

  bool get isWindows => (platform == TargetPlatform.windows);

  bool get isFuschia => (platform == TargetPlatform.fuchsia);

  bool get isWeb => (kIsWeb);
}
