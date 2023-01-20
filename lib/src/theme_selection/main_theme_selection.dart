import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fantasy_detective/utils/theme_selection/home_page.dart';
import 'package:fantasy_detective/utils/theme_selection/shared/controllers/theme_controller.dart';
import 'package:fantasy_detective/utils/theme_selection/shared/services/theme_service.dart';
import 'package:fantasy_detective/utils/theme_selection/shared/services/theme_service_prefs.dart';
import 'package:fantasy_detective/utils/theme_selection/shared/utils/app_scroll_behavior.dart';
import 'package:provider/provider.dart' as pro;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ThemeService themeService = ThemeServicePrefs();
  await themeService.init();
  final ThemeController themeController = ThemeController(themeService);
  await themeController.loadAll();
  runApp(DemoApp(themeController: themeController,themeService: themeService,));
}

const FlexSchemeData _myFlexScheme = FlexSchemeData(
  name: 'Midnight blue',
  description: 'Midnight blue theme, custom definition of all colors',
  light: FlexSchemeColor(
    primary: Color(0xFF00296B),
    primaryContainer: Color(0xFFA0C2ED),
    secondary: Color(0xFFD26900),
    secondaryContainer: Color(0xFFFFD270),
    tertiary: Color(0xFF5C5C95),
    tertiaryContainer: Color(0xFFC8DBF8),
  ),
  dark: FlexSchemeColor(
    primary: Color(0xFFB1CFF5),
    primaryContainer: Color(0xFF3873BA),
    secondary: Color(0xFFFFD270),
    secondaryContainer: Color(0xFFD26900),
    tertiary: Color(0xFFC9CBFC),
    tertiaryContainer: Color(0xFF535393),
  ),
);

class DemoApp extends StatelessWidget {
  const DemoApp({super.key, required this.themeController, required this.themeService});
  final ThemeController themeController;
  final ThemeService themeService;

  @override
  Widget build(BuildContext context) {
    return pro.MultiProvider(providers: [
      pro.ChangeNotifierProvider<ThemeController?>.value(
              value: themeController),
      pro.Provider<ThemeService>.value(value: themeService)
    ],
    builder: ((context, child) {
      return animatedBuilder();
    }),);
  }

  AnimatedBuilder animatedBuilder() {
    return AnimatedBuilder(
    animation: themeController,
    builder: (BuildContext context, Widget? child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: const AppScrollBehavior(),
        title: 'Four Themes',
        theme: FlexThemeData.light(
          colors: themeController.usedScheme == FlexScheme.custom
              ? _myFlexScheme.light
              : FlexColor.schemes[themeController.usedScheme]!.light,
          surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
          blendLevel: 10,
          appBarElevation: 0.5,
          subThemesData:
              themeController.useSubThemes ? const FlexSubThemesData() : null,
          keyColors: FlexKeyColors(
            useKeyColors: themeController.useKeyColors,
            useSecondary: themeController.useSecondary,
            useTertiary: themeController.useTertiary,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          fontFamily: GoogleFonts.notoSans().fontFamily,
          typography: Typography.material2021(
            platform: defaultTargetPlatform,
          ),
        ),
        darkTheme: FlexThemeData.dark(
          colors: themeController.usedScheme == FlexScheme.custom
              ? _myFlexScheme.dark
              : FlexColor.schemes[themeController.usedScheme]!.dark,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurfaces,
          blendLevel: 12,
          appBarElevation: 1,
          subThemesData:
              themeController.useSubThemes ? const FlexSubThemesData() : null,
          keyColors: FlexKeyColors(
            useKeyColors: themeController.useKeyColors,
            useSecondary: themeController.useSecondary,
            useTertiary: themeController.useTertiary,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          fontFamily: GoogleFonts.notoSans().fontFamily,
          typography: Typography.material2021(
            platform: defaultTargetPlatform,
          ),
        ),
        themeMode: themeController.themeMode,
        // This simple example app has only one page.
        home: ThemePage(),
      );
    },
  );
  }
}
