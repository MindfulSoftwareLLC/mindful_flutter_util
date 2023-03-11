// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';

/// A wrapper for a MaterialApp that themes it and changes the theme whenever
/// a ThemedChangedEvent is fired on the EventBus.
class ThemedApp extends StatefulWidget {
  ThemedApp({
    super.key,
    required this.lightTheme,
    required this.darkTheme,
    required this.title,
    required this.useDynamicColor,
    required this.child,
  });

  final String title;
  final bool useDynamicColor;
  final Widget child;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  @override
  State<StatefulWidget> createState() {
    return ThemedAppState();
  }
}

class ThemedAppState extends State<ThemedApp> {
  ThemedAppState() {
    latestLightTheme = widget.lightTheme;
    latestDarkTheme = widget.darkTheme;
  }
  late ThemeData latestLightTheme;
  late ThemeData latestDarkTheme;

  @override
  Widget build(BuildContext context) {
    return EventBusBuilder<ThemeChangedEvent>(
        on: (ThemeChangedEvent themeChangedEvent) {
          setState(() {
            latestLightTheme = themeChangedEvent.lightTheme;
            latestDarkTheme = themeChangedEvent.darkTheme;
          });
        },
        child: createThemedMaterialApp(widget.child) //animatedBuilder(child),
        );
  }

  MaterialApp createThemedMaterialApp(Widget home) {
    // return AnimatedBuilder(
    //   animation: themeController,
    //   builder: (BuildContext context, Widget? child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      title: widget.title,
      theme: latestLightTheme,
      darkTheme: latestDarkTheme,
      //themeMode: themeController.themeMode,
      home: home,
    );
    // },
    //);
  }
}
