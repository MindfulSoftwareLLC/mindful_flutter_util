// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';
import 'package:mindful_flutter_util/src/event_bus/event_bus_builder.dart';
import 'package:mindful_flutter_util/src/theme/theme_changed_event.dart';

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

  String title;
  ThemeData lightTheme;
  ThemeData darkTheme;
  bool useDynamicColor;
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return ThemedAppState();
  }
}

class ThemedAppState extends State<ThemedApp> {
  @override
  Widget build(BuildContext context) {
    return EventBusBuilder<ThemeChangedEvent>(
        on: (ThemeChangedEvent themeChangedEvent) {
          setState(() {
            widget.lightTheme = themeChangedEvent.lightTheme;
            widget.darkTheme = themeChangedEvent.darkTheme;
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
      theme: widget.lightTheme,
      darkTheme: widget.darkTheme,
      //themeMode: themeController.themeMode,
      home: home,
    );
    // },
    //);
  }
}
