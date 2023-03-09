// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/src/event_bus/app_bus_builder.dart';
import 'package:mindful_flutter_util/src/theme/theme_changed_event.dart';

/// A wrapper for a MaterialApp that themes it.
class ThemedApp extends StatelessWidget {
  const ThemedApp({
    super.key,
    required this.lightTheme,
    required this.darkTheme,
    required this.title,
    required this.useDynamicColor,
    required this.child,
  });

  final String title;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final bool useDynamicColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppBusBuilder<ThemeChangedEvent>(
      on: (ThemeChangedEvent themeChangedEvent) {
        //return animatedBuilder(themeService);
      },
      child: child, // animatedBuilder(child),
    );
  }

  // AnimatedBuilder animatedBuilder(Widget home) {
  //   return AnimatedBuilder(
  //     animation: themeController,
  //     builder: (BuildContext context, Widget? child) {
  //       return MaterialApp(
  //         debugShowCheckedModeBanner: false,
  //         scrollBehavior: const AppScrollBehavior(),
  //         title: title,
  //         theme: lightTheme,
  //         darkTheme: darkTheme,
  //         themeMode: themeController.themeMode,
  //         // This simple example app has only one page.
  //         home: home,
  //       );
  //     },
  //   );
  //}
}
