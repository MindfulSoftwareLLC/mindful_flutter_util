//VIA: import 'package:flex_color_scheme/flex_color_scheme.dart';
// ignore_for_file: public_member_api_docs, flutter_style_todos

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App static functions and constants used in the example applications.
///
/// In a real app you probably prefer putting these into different static
/// classes that serves your application's usage. For these examples I
/// put them all in the same class, except the colors that are in their
/// own class.
class UIConst {
  /// This class is not meant to be instantiated or extended; this constructor
  /// prevents instantiation and extension.
  UIConst._();

  //TODO - have these somewhere...
  /// When building new public web versions of the demos, make sure to
  /// update this info before triggering GitHub actions CI/CD that builds them.
  //
  /// The name of the package this app demonstrates.
  /// static const String packageName = 'com.panhchana.';
  /// // Version of the WEB build, usually same as package, but it also has a
  /// // build numbers.
  /// static const String versionMajor = '1.3.3';
  /// static const String versionBuild = '33';
  /// static const String version = '$versionMajor Build-$versionBuild';
  /// static const String packageVersion = '1.3.2';
  /// static const String flutterVersion = 'stable v3.0.4';
  /// static const String copyright = '© 2022';
  /// static const String author = 'Ros Pisey';
  /// static const String license = 'BSD 3-Clause License';
  /// static const String icon = 'assets/icons.png';
  /// static final Uri packageUri = Uri(
  ///   scheme: 'https',
  ///   host: 'pub.dev',
  ///   path: 'packages/flex_color_scheme',
  /// );

  /// The max dp width used for layout content on the screen in the available
  /// body area. Wider content gets growing side padding, kind of like on most
  /// web pages when they are used on super wide screen. This is typically used
  /// pages in the example apps that use content that is width constrained,
  /// typically via the PageBody widget.
  static const double maxBodyWidth = 1000;

  /// Breakpoint needed to show code view side by side breakpoint for the
  /// panel page view. This available content layout width, not media size.
  /// This min width was chosen because it gives at least the primary, secondary
  /// and tertiary colors in one Wrap row on panels Input Colors and Seeded
  /// ColorScheme, also when the side-by-side code view appears.
  static const double codeViewWidthBreakpoint = 1024;

  /// The minimum media size needed for desktop/large tablet menu view,
  /// this is media size.
  /// Only at higher than this breakpoint will the menu expand from rail and
  /// be possible to toggle between menu and rail. Below this breakpoint it
  /// toggles between hidden in the Drawer and being a Rail, also on phones.
  /// This size was chosen because in combination codeViewWidthBreakpoint, it
  /// gives us a breakpoint where we get code side by side view in desktop
  /// rail mode already, and when it switches to menu mode, the desktop is
  /// wide enough to show both the full width menu and keep showing the
  /// code in side-by-side view. We could do lower the desktop width breakpoint,
  /// but then that view switches temporarily to now showing the code view,
  /// and it is just to much dynamic changes happening, it does not nice.
  static const double desktopWidthBreakpoint = 1350;

  /// This breakpoint is only used to further increase margins and insets on
  /// very large desktops.
  static const double bigDesktopWidthBreakpoint = 2800;

  /// The minimum media width treated as a phone device in this demo.
  static const double phoneWidthBreakpoint = 600;

  /// The minimum media height treated as a phone device in this demo.
  static const double phoneHeightBreakpoint = 700;

  /// Edge insets and margins for content at above breakpoints.
  static const double edgeInsetsPhone = 8;
  static const double edgeInsetsTablet = 12;
  static const double edgeInsetsDesktop = 18;
  static const double edgeInsetsBigDesktop = 24;

  /// Responsive insets based on width. The width may be from LayoutBuilder or
  /// MediaQuery, depending on what is appropriate for the use case.
  static double responsiveInsets(double width) {
    if (width < phoneWidthBreakpoint) return edgeInsetsPhone;
    if (width < desktopWidthBreakpoint) return edgeInsetsTablet;
    if (width < bigDesktopWidthBreakpoint) return edgeInsetsDesktop;
    return edgeInsetsBigDesktop;
  }

  /// The height when we want to pin the panel or color selector, instead of
  /// letting it float and snap back.
  static const double pinnedSelector = 1000;

  /// The width, and height of the scrolling panel buttons in Themes Playground
  /// page view, and how much it shrinks when we go to phone size.
  static const double panelButtonWidth = 115;
  static const double panelButtonHeight = 100;
  static const double panelButtonPhoneWidthReduce = -16;
  static const double panelButtonPhoneHeightReduce = -30;

  /// The width and height reduction of input color selection box in phone size.
  static const double colorButtonPhoneReduce = -12;

  /// Get the main font that is used in some of the examples.
  /// Feel free to try different fonts.
  static String? get font => GoogleFonts.notoSans().fontFamily;

  /// Defining the visual density here to so we can change it in one spot when
  /// we want to try different options.
  /// static VisualDensity get visualDensity =>
  ///     FlexColorScheme.comfortablePlatformDensity;

  //TODO - move and define
  //
  /// // The menu items that we use on the responsive side menu.
  /// static const List<ResponsiveMenuItems> menuItems = <ResponsiveMenuItems>[
  ///   ResponsiveMenuItems(
  ///     label: 'Grid view',
  ///     labelSecondary: 'Page view',
  ///     icon: Icons.calendar_view_month_outlined,
  ///     iconSecondary: Icons.view_array_outlined,
  ///   ),
  ///   ResponsiveMenuItems(
  ///     label: 'Dark mode',
  ///     labelSecondary: 'Light mode',
  ///     icon: Icons.bedtime,
  ///     iconSecondary: Icons.wb_sunny,
  ///   ),
  ///   ResponsiveMenuItems(
  ///     label: 'Copy theme code',
  ///     icon: Icons.integration_instructions_outlined,
  ///   ),
  ///   ResponsiveMenuItems(
  ///     label: 'Copy ColorScheme',
  ///     icon: Icons.palette_outlined,
  ///   ),
  ///   ResponsiveMenuItems(
  ///     label: 'Expand all',
  ///     icon: Icons.open_in_full_outlined,
  ///   ),
  ///   ResponsiveMenuItems(
  ///     label: 'Close all',
  ///     icon: Icons.close_fullscreen_outlined,
  ///   ),
  ///   ResponsiveMenuItems(
  ///     label: 'Reset settings',
  ///     icon: Icons.replay_outlined,
  ///   ),
  /// ];

  /// TODO(rydmike): Remove when fix for issue #10386 has landed in stable.
  /// Used as a workaround to provide a M2 like TextTheme using M3 Typography,
  /// so we do not have to switch between 2021 and 2018 (or 2014) Typography
  /// in the app dynamically. Instead is always uses M3 2021 Typography and
  /// simulates 2018 Typography. This is done to avoid issue:
  /// https://github.com/flutter/flutter/issues/103864
  static const TextTheme m2TextTheme = TextTheme(
    displayLarge: TextStyle(
      debugLabel: 'englishLike displayLarge 2018',
      fontSize: 96,
      fontWeight: FontWeight.w300,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: -1.5,
    ),
    displayMedium: TextStyle(
      debugLabel: 'englishLike displayMedium 2018',
      fontSize: 60,
      fontWeight: FontWeight.w300,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: -0.5,
    ),
    displaySmall: TextStyle(
      debugLabel: 'englishLike displaySmall 2018',
      fontSize: 48,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0,
    ),
    headlineLarge: TextStyle(
      debugLabel: 'englishLike headlineLarge 2018',
      fontSize: 40,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.25,
    ),
    headlineMedium: TextStyle(
      debugLabel: 'englishLike headlineMedium 2018',
      fontSize: 34,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.25,
    ),
    headlineSmall: TextStyle(
      debugLabel: 'englishLike headlineSmall 2018',
      fontSize: 24,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0,
    ),
    titleLarge: TextStyle(
      debugLabel: 'englishLike titleLarge 2018',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.15,
    ),
    titleMedium: TextStyle(
      debugLabel: 'englishLike titleMedium 2018',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      debugLabel: 'englishLike titleSmall 2018',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.1,
    ),
    bodyLarge: TextStyle(
      debugLabel: 'englishLike bodyLarge 2018',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      debugLabel: 'englishLike bodyMedium 2018',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      debugLabel: 'englishLike bodySmall 2018',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.4,
    ),
    labelLarge: TextStyle(
      debugLabel: 'englishLike labelLarge 2018',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 1.25,
    ),
    labelMedium: TextStyle(
      debugLabel: 'englishLike labelMedium 2018',
      fontSize: 11,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 1.5,
    ),
    labelSmall: TextStyle(
      debugLabel: 'englishLike labelSmall 2018',
      fontSize: 10,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 1.5,
    ),
  );
}
