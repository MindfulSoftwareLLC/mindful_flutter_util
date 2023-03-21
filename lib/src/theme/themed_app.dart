// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bus/flutter_bus.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';

/// A wrapper for a MaterialApp that themes it and changes the theme whenever
/// a ThemedChangedEvent is fired on the FlutterBus.
class ThemedApp extends StatefulWidget {
  ThemedApp({
    super.key,
    required this.defaultLightTheme,
    required this.defaultDarkTheme,
    required this.defaultThemeMode,
    required this.title,
    required this.useDynamicColor,
    required this.child,
  });

  final String title;
  final bool useDynamicColor;
  final Widget child;
  final ThemeData defaultLightTheme;
  final ThemeData defaultDarkTheme;
  final ThemeMode defaultThemeMode;

  @override
  State<StatefulWidget> createState() {
    return ThemedAppState();
  }
}

class ThemedAppState extends State<ThemedApp> {
  ThemedAppState();

  ThemeData? latestLightTheme;
  ThemeData? latestDarkTheme;
  ThemeMode? latestThemeMode;

  @override
  void initState() {
    latestLightTheme = widget.defaultLightTheme;
    latestDarkTheme = widget.defaultDarkTheme;
    latestThemeMode = widget.defaultThemeMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterBusBuilder<ThemeChangedEvent>(
        builder: (context, themeChangedEvent) {
      setState(() {
        latestLightTheme = themeChangedEvent == null
            ? widget.defaultLightTheme
            : themeChangedEvent.lightTheme;
        latestDarkTheme = themeChangedEvent == null
            ? widget.defaultLightTheme
            : themeChangedEvent.lightTheme;
        latestThemeMode = themeChangedEvent == null
            ? widget.defaultThemeMode
            : themeChangedEvent.themeMode;
      });
      return createThemedMaterialApp(widget.child);
    });
  }

  MaterialApp createThemedMaterialApp(Widget home) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      title: widget.title,
      theme: latestLightTheme,
      darkTheme: latestDarkTheme,
      themeMode: latestThemeMode,
      home: home,
    );
  }
}
