// ignore_for_file: public_member_api_docs

import 'dart:ui';

/// Sets the default values for the theme switcher
class ThemeDefaults {
  ThemeDefaults({
    required this.defaultPrimaryLight,
    required this.defaultPrimaryContainerLight,
    required this.defaultSecondaryLight,
    required this.defaultSecondaryContainerLight,
    required this.defaultTertiaryLight,
    required this.defaultTertiaryContainerLight,
    required this.defaultPrimaryDark,
    required this.defaultPrimaryContainerDark,
    required this.defaultSecondaryDark,
    required this.defaultSecondaryContainerDark,
    required this.defaultTertiaryDark,
    required this.defaultTertiaryContainerDark,
  });
  Color defaultPrimaryLight;
  Color defaultPrimaryContainerLight;
  Color defaultSecondaryLight;
  Color defaultSecondaryContainerLight;
  Color defaultTertiaryLight;
  Color defaultTertiaryContainerLight;
  Color defaultPrimaryDark;
  Color defaultPrimaryContainerDark;
  Color defaultSecondaryDark;
  Color defaultSecondaryContainerDark;
  Color defaultTertiaryDark;
  Color defaultTertiaryContainerDark;

  // static ThemeDefaults fromThemeData(ThemeData lightTheme,
// ThemeData darkTheme) {
  //   ThemeDefaults result = ThemeDefaults(
  //       defaultPrimaryLight: lightTheme.primaryColor,
  //       defaultPrimaryContainerLight: lightTheme.primaryContainerLight,
  //       defaultSecondaryLight: lightTheme.secondaryLight,
  //       defaultSecondaryContainerLight: lightTheme.SecondaryContainerLight,
  //       defaultTertiaryLight: lightTheme.TertiaryLight,
  //       defaultTertiaryContainerLight: lightTheme.TertiaryContainerLight,
  //       defaultPrimaryDark: lightTheme.PrimaryDark,
  //       defaultSecondaryDark: lightTheme.SecondaryDark,
  //       defaultSecondaryContainerDark: lightTheme.SecondaryContainerDark,
  //       defaultTertiaryDark: lightTheme.TertiaryDark,
  //       defaultTertiaryContainerDark: lightTheme.tertiaryContainerDark)
  // }
}
