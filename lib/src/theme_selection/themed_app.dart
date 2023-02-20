// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/src/theme_selection/theme_controller.dart';
import 'package:mindful_flutter_util/src/theme_selection/theme_page.dart';
import 'package:mindful_flutter_util/src/theme_selection/theme_service.dart';
import 'package:mindful_flutter_util/src/utils/app_scroll_behavior.dart';
import 'package:provider/provider.dart' as pro;

/// A wrapper for a MaterialApp that themes it.
class ThemedApp extends StatelessWidget {
  const ThemedApp({
    super.key,
    required this.themeController,
    required this.themeService,
    required this.lightTheme,
    required this.darkTheme,
    required this.title,
  });

  final String title;
  final ThemeController themeController;
  final ThemeService themeService;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  @override
  Widget build(BuildContext context) {
    return pro.MultiProvider(
      providers: [
        pro.ChangeNotifierProvider<ThemeController?>.value(
          value: themeController,
        ),
        pro.Provider<ThemeService>.value(value: themeService)
      ],
      builder: ((context, child) {
        return animatedBuilder();
      }),
    );
  }

  AnimatedBuilder animatedBuilder() {
    return AnimatedBuilder(
      animation: themeController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          scrollBehavior: const AppScrollBehavior(),
          title: title,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeController.themeMode,
          // This simple example app has only one page.
          home: ThemePage(),
        );
      },
    );
  }
}
