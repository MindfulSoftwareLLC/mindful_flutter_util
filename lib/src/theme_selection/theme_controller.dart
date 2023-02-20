// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, avoid_positional_boolean_parameters

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/src/theme_selection/theme_defaults.dart';
import 'package:mindful_flutter_util/src/theme_selection/theme_key.dart';
import 'package:mindful_flutter_util/src/theme_selection/theme_service.dart';

/// Enum to indicate which palette we are using.
///
/// Used to show which TonalPalette a hovered color belongs to.
/// Tucking this ChangeNotifier into the ThemeController is not really kosher
/// it should be in its own Provider/Riverpod or Inherited widget.
///
enum TonalPalettes {
  primary,
  secondary,
  tertiary,
  error,
  neutral,
  neutralVariant,
}

/// The ThemeController is used by many Widgets that users can interact with.
///
/// Widgets can read user theme settings, set user theme settings and listen
/// to user's theme changes.
///
/// The controller glues data Services to Flutter Widgets. The ThemeController
/// uses the ThemeService to save and load theme settings.
///
/// This setup on purpose demonstrates persisting each theme setting value
/// as its own string key and value pair. With this amount of values,
/// bundling them all up in a data class and persisting them all as one big
/// serialized JSON string, with just one settings key, would be more
/// convenient. On the other hand, this is probably more file resource
/// efficient and gives us faster saves of persisted slider values, that can
/// be dragged quickly in the UI. Writing this setup for this many properties is
/// a bit tedious, even if it is simple and very mechanical.
///
/// Normally you would probably not have this many settings properties you
/// want to persist locally (or remotely), in that case this approach is also
/// the simpler and more convenient one. In this particular case though, well
/// maybe not with this amount of props.
//
// ignore:prefer_mixin
class ThemeController with ChangeNotifier {
  ThemeController(this._themeService);

  // Make the ThemeService private so it cannot be used directly.
  final ThemeService _themeService;

  /// Load all ThemeController settings from the ThemeService. It may load from
  /// app coded defaults, a local database or the internet. The controller only
  /// knows it can load all the setting default values from the service.
  Future<void> loadAll(ThemeDefaults themeDefaults) async {
    //
    // GENERAL SETTINGS.
    // ThemeMode, use FlexColorScheme and sub-themes, current scheme, view, etc.
    _themeMode = await _themeService.load(
      ThemeKey.keyThemeMode,
      ThemeKey.defaultThemeMode,
    );
    _useFlexColorScheme = await _themeService.load(
      ThemeKey.keyUseFlexColorScheme,
      ThemeKey.defaultUseFlexColorScheme,
    );
    _useSubThemes = await _themeService.load(
      ThemeKey.keyUseSubThemes,
      ThemeKey.defaultUseSubThemes,
    );
    _useFlutterDefaults = await _themeService.load(
      ThemeKey.keyUseFlutterDefaults,
      ThemeKey.defaultUseFlutterDefaults,
    );
    _isLargeGridView = await _themeService.load(
      ThemeKey.keyIsLargeGridView,
      ThemeKey.defaultIsLargeGridView,
    );
    _viewIndex = await _themeService.load(
      ThemeKey.keyViewIndex,
      ThemeKey.defaultViewIndex,
    );
    _useTextTheme = await _themeService.load(
      ThemeKey.keyUseTextTheme,
      ThemeKey.defaultUseTextTheme,
    );
    _useAppFont = await _themeService.load(
      ThemeKey.keyUseAppFont,
      ThemeKey.defaultUseAppFont,
    );
    _usedScheme = await _themeService.load(
      ThemeKey.keyUsedScheme,
      ThemeKey.defaultUsedScheme,
    );
    _schemeIndex = await _themeService.load(
      ThemeKey.keySchemeIndex,
      ThemeKey.defaultSchemeIndex,
    );
    _interactionEffects = await _themeService.load(
      ThemeKey.keyInteractionEffects,
      ThemeKey.defaultInteractionEffects,
    );
    _defaultRadius = await _themeService.load(
      ThemeKey.keyDefaultRadius,
      ThemeKey.defaultDefaultRadius,
    );
    _tooltipsMatchBackground = await _themeService.load(
      ThemeKey.keyTooltipsMatchBackground,
      ThemeKey.defaultTooltipsMatchBackground,
    );
    //
    // Surface and blend SETTINGS.
    _surfaceModeLight = await _themeService.load(
      ThemeKey.keySurfaceModeLight,
      ThemeKey.defaultSurfaceModeLight,
    );
    _surfaceModeDark = await _themeService.load(
      ThemeKey.keySurfaceModeDark,
      ThemeKey.defaultSurfaceModeDark,
    );
    _blendLevel = await _themeService.load(
      ThemeKey.keyBlendLevel,
      ThemeKey.defaultBlendLevel,
    );
    _blendLevelDark = await _themeService.load(
      ThemeKey.keyBlendLevelDark,
      ThemeKey.defaultBlendLevelDark,
    );
    _blendOnLevel = await _themeService.load(
      ThemeKey.keyOnBlendLevel,
      ThemeKey.defaultBlendOnLevel,
    );
    _blendOnLevelDark = await _themeService.load(
      ThemeKey.keyBlendOnLevelDark,
      ThemeKey.defaultBlendOnLevelDark,
    );
    _usedColors = await _themeService.load(
      ThemeKey.keyUsedColors,
      ThemeKey.defaultUsedColors,
    );
    _swapLightColors = await _themeService.load(
      ThemeKey.keySwapLightColors,
      ThemeKey.defaultSwapLightColors,
    );
    _swapDarkColors = await _themeService.load(
      ThemeKey.keySwapDarkColors,
      ThemeKey.defaultSwapDarkColors,
    );
    _lightIsWhite = await _themeService.load(
      ThemeKey.keyLightIsWhite,
      ThemeKey.defaultLightIsWhite,
    );
    _darkIsTrueBlack = await _themeService.load(
      ThemeKey.keyDarkIsTrueBlack,
      ThemeKey.defaultDarkIsTrueBlack,
    );
    _useDarkColorsForSeed = await _themeService.load(
      ThemeKey.keyUseDarkColorsForSeed,
      ThemeKey.defaultUseDarkColorsForSeed,
    );
    _useToDarkMethod = await _themeService.load(
      ThemeKey.keyUseToDarkMethod,
      ThemeKey.defaultUseToDarkMethod,
    );
    _toDarkSwapPrimaryAndContainer = await _themeService.load(
      ThemeKey.keyToDarkSwapPrimaryAndContainer,
      ThemeKey.defaultToDarkSwapPrimaryAndContainer,
    );
    _darkMethodLevel = await _themeService.load(
      ThemeKey.keyDarkMethodLevel,
      ThemeKey.defaultDarkMethodLevel,
    );
    _blendLightOnColors = await _themeService.load(
      ThemeKey.keyBlendLightOnColors,
      ThemeKey.defaultBlendLightOnColors,
    );
    _blendDarkOnColors = await _themeService.load(
      ThemeKey.keyBlendDarkOnColors,
      ThemeKey.defaultBlendDarkOnColors,
    );
    _blendLightTextTheme = await _themeService.load(
      ThemeKey.keyBlendLightTextTheme,
      ThemeKey.defaultBlendLightTextTheme,
    );
    _blendDarkTextTheme = await _themeService.load(
      ThemeKey.keyBlendDarkTextTheme,
      ThemeKey.defaultBlendDarkTextTheme,
    );
    //
    // Material 3 and Seed ColorScheme SETTINGS.
    _useMaterial3 = await _themeService.load(
      ThemeKey.keyUseMaterial3,
      ThemeKey.defaultUseMaterial3,
    );
    _useKeyColors = await _themeService.load(
      ThemeKey.keyUseKeyColors,
      ThemeKey.defaultUseKeyColors,
    );
    _useSecondary = await _themeService.load(
      ThemeKey.keyUseSecondary,
      ThemeKey.defaultUseSecondary,
    );
    _useTertiary = await _themeService.load(
      ThemeKey.keyUseTertiary,
      ThemeKey.defaultUseTertiary,
    );
    _keepPrimary = await _themeService.load(
      ThemeKey.keyKeepPrimary,
      ThemeKey.defaultKeepPrimary,
    );
    _keepSecondary = await _themeService.load(
      ThemeKey.keyKeepSecondary,
      ThemeKey.defaultKeepSecondary,
    );
    _keepTertiary = await _themeService.load(
      ThemeKey.keyKeepTertiary,
      ThemeKey.defaultKeepTertiary,
    );
    _keepPrimaryContainer = await _themeService.load(
      ThemeKey.keyKeepPrimaryContainer,
      ThemeKey.defaultKeepPrimaryContainer,
    );
    _keepSecondaryContainer = await _themeService.load(
      ThemeKey.keyKeepSecondaryContainer,
      ThemeKey.defaultKeepSecondaryContainer,
    );
    _keepTertiaryContainer = await _themeService.load(
      ThemeKey.keyKeepTertiaryContainer,
      ThemeKey.defaultKeepTertiaryContainer,
    );
    _keepDarkPrimary = await _themeService.load(
      ThemeKey.keyKeepDarkPrimary,
      ThemeKey.defaultKeepDarkPrimary,
    );
    _keepDarkSecondary = await _themeService.load(
      ThemeKey.keyKeepDarkSecondary,
      ThemeKey.defaultKeepDarkSecondary,
    );
    _keepDarkTertiary = await _themeService.load(
      ThemeKey.keyKeepDarkTertiary,
      ThemeKey.defaultKeepDarkTertiary,
    );
    _keepDarkPrimaryContainer = await _themeService.load(
      ThemeKey.keyKeepDarkPrimaryContainer,
      ThemeKey.defaultKeepDarkPrimaryContainer,
    );
    _keepDarkSecondaryContainer = await _themeService.load(
      ThemeKey.keyKeepDarkSecondaryContainer,
      ThemeKey.defaultKeepDarkSecondaryContainer,
    );
    _keepDarkTertiaryContainer = await _themeService.load(
      ThemeKey.keyKeepDarkTertiaryContainer,
      ThemeKey.defaultKeepDarkTertiaryContainer,
    );
    _usedFlexToneSetup = await _themeService.load(
      ThemeKey.keyUsedFlexToneSetup,
      ThemeKey.defaultUsedFlexToneSetup,
    );
    _useM3ErrorColors = await _themeService.load(
      ThemeKey.keyUseM3ErrorColors,
      ThemeKey.defaultUseM3ErrorColors,
    );
    //
    // InputDecorator SETTINGS.
    _inputDecoratorSchemeColorLight = await _themeService.load(
      ThemeKey.keyInputDecoratorSchemeColorLight,
      ThemeKey.defaultInputDecoratorSchemeColorLight,
    );
    _inputDecoratorSchemeColorDark = await _themeService.load(
      ThemeKey.keyInputDecoratorSchemeColorDark,
      ThemeKey.defaultInputDecoratorSchemeColorDark,
    );
    _inputDecoratorIsFilled = await _themeService.load(
      ThemeKey.keyInputDecoratorIsFilled,
      ThemeKey.defaultInputDecoratorIsFilled,
    );
    _inputDecoratorBorderType = await _themeService.load(
      ThemeKey.keyInputDecoratorBorderType,
      ThemeKey.defaultInputDecoratorBorderType,
    );
    _inputDecoratorBorderRadius = await _themeService.load(
      ThemeKey.keyInputDecoratorBorderRadius,
      ThemeKey.defaultInputDecoratorBorderRadius,
    );
    _inputDecoratorUnfocusedHasBorder = await _themeService.load(
      ThemeKey.keyInputDecoratorUnfocusedHasBorder,
      ThemeKey.defaultInputDecoratorUnfocusedHasBorder,
    );
    _inputDecoratorUnfocusedBorderIsColored = await _themeService.load(
      ThemeKey.keyInputDecoratorUnfocusedBorderIsColored,
      ThemeKey.defaultInputDecoratorUnfocusedBorderIsColored,
    );
    //
    // AppBar SETTINGS.
    _appBarStyleLight = await _themeService.load(
      ThemeKey.keyAppBarStyleLight,
      ThemeKey.defaultAppBarStyleLight,
    );
    _appBarStyleDark = await _themeService.load(
      ThemeKey.keyAppBarStyleDark,
      ThemeKey.defaultAppBarStyleDark,
    );
    _appBarOpacityLight = await _themeService.load(
      ThemeKey.keyAppBarOpacityLight,
      ThemeKey.defaultAppBarOpacityLight,
    );
    _appBarOpacityDark = await _themeService.load(
      ThemeKey.keyAppBarOpacityDark,
      ThemeKey.defaultAppBarOpacityDark,
    );
    _appBarElevationLight = await _themeService.load(
      ThemeKey.keyAppBarElevationLight,
      ThemeKey.defaultAppBarElevationLight,
    );
    _appBarElevationDark = await _themeService.load(
      ThemeKey.keyAppBarElevationDark,
      ThemeKey.defaultAppBarElevationDark,
    );
    _transparentStatusBar = await _themeService.load(
      ThemeKey.keyTransparentStatusBar,
      ThemeKey.defaultTransparentStatusBar,
    );
    _appBarBackgroundSchemeColorLight = await _themeService.load(
      ThemeKey.keyAppBarBackgroundSchemeColorLight,
      ThemeKey.defaultAppBarBackgroundSchemeColorLight,
    );
    _appBarBackgroundSchemeColorDark = await _themeService.load(
      ThemeKey.keyAppBarBackgroundSchemeColorDark,
      ThemeKey.defaultAppBarBackgroundSchemeColorDark,
    );
    //
    // TabBar SETTINGS.
    _tabBarStyle = await _themeService.load(
      ThemeKey.keyTabBarStyle,
      ThemeKey.defaultTabBarStyle,
    );
    _tabBarIndicatorLight = await _themeService.load(
      ThemeKey.keyTabBarIndicatorLight,
      ThemeKey.defaultTabBarIndicatorLight,
    );
    _tabBarIndicatorDark = await _themeService.load(
      ThemeKey.keyTabBarIndicatorDark,
      ThemeKey.defaultTabBarIndicatorDark,
    );
    _tabBarItemSchemeColorLight = await _themeService.load(
      ThemeKey.keyTabBarItemSchemeColorLight,
      ThemeKey.defaultTabBarItemSchemeColorLight,
    );
    _tabBarItemSchemeColorDark = await _themeService.load(
      ThemeKey.keyTabBarItemSchemeColorDark,
      ThemeKey.defaultTabBarItemSchemeColorDark,
    );
    //
    // BottomSheet SETTINGS.
    _bottomSheetBorderRadius = await _themeService.load(
      ThemeKey.keyBottomSheetBorderRadius,
      ThemeKey.defaultBottomSheetBorderRadius,
    );
    //
    // Android System Navigator bar SETTINGS.
    _sysNavBarStyle = await _themeService.load(
      ThemeKey.keySysNavBarStyle,
      ThemeKey.defaultSysNavBarStyle,
    );
    _sysNavBarOpacity = await _themeService.load(
      ThemeKey.keySysNavBarOpacity,
      ThemeKey.defaultSysBarOpacity,
    );
    _useSysNavDivider = await _themeService.load(
      ThemeKey.keyUseSysNavDivider,
      ThemeKey.defaultUseSysNavDivider,
    );
    //
    // BottomNavigationBar SETTINGS.
    _bottomNavBarBackgroundSchemeColor = await _themeService.load(
      ThemeKey.keyBottomNavBarBackgroundSchemeColor,
      ThemeKey.defaultBottomNavBarBackgroundSchemeColor,
    );
    _bottomNavigationBarOpacity = await _themeService.load(
      ThemeKey.keyBottomNavigationBarOpacity,
      ThemeKey.defaultBottomNavigationBarOpacity,
    );
    _bottomNavigationBarElevation = await _themeService.load(
      ThemeKey.keyBottomNavigationBarElevation,
      ThemeKey.defaultBottomNavigationBarElevation,
    );
    _bottomNavBarSelectedSchemeColor = await _themeService.load(
      ThemeKey.keyBottomNavBarSelectedItemSchemeColor,
      ThemeKey.defaultBottomNavBarSelectedItemSchemeColor,
    );
    _bottomNavBarUnselectedSchemeColor = await _themeService.load(
      ThemeKey.keyBottomNavBarUnselectedSchemeColor,
      ThemeKey.defaultBottomNavBarUnselectedSchemeColor,
    );
    _bottomNavBarMuteUnselected = await _themeService.load(
      ThemeKey.keyBottomNavBarMuteUnselected,
      ThemeKey.defaultBottomNavBarMuteUnselected,
    );
    _bottomNavShowSelectedLabels = await _themeService.load(
      ThemeKey.keyBottomNavShowSelectedLabels,
      ThemeKey.defaultBottomNavShowSelectedLabels,
    );
    _bottomNavShowUnselectedLabels = await _themeService.load(
      ThemeKey.keyBottomNavShowUnselectedLabels,
      ThemeKey.defaultBottomNavShowUnselectedLabels,
    );
    //
    // NavigationBar SETTINGS.
    _navBarBackgroundSchemeColor = await _themeService.load(
      ThemeKey.keyNavBarBackgroundSchemeColor,
      ThemeKey.defaultNavBarBackgroundSchemeColor,
    );
    _navBarOpacity = await _themeService.load(
      ThemeKey.keyNavBarOpacity,
      ThemeKey.defaultNavBarOpacity,
    );
    _navBarHeight = await _themeService.load(
      ThemeKey.keyNavBarHeight,
      ThemeKey.defaultNavBarHeight,
    );
    _navBarSelectedSchemeColor = await _themeService.load(
      ThemeKey.keyNavBarSelectedItemSchemeColor,
      ThemeKey.defaultNavBarSelectedItemSchemeColor,
    );
    _navBarUnselectedSchemeColor = await _themeService.load(
      ThemeKey.keyNavBarUnselectedSchemeColor,
      ThemeKey.defaultNavBarUnselectedSchemeColor,
    );
    _navBarMuteUnselected = await _themeService.load(
      ThemeKey.keyNavBarMuteUnselected,
      ThemeKey.defaultNavBarMuteUnselected,
    );
    _navBarIndicatorSchemeColor = await _themeService.load(
      ThemeKey.keyNavBarIndicatorSchemeColor,
      ThemeKey.defaultNavBarIndicatorSchemeColor,
    );
    _navBarIndicatorOpacity = await _themeService.load(
      ThemeKey.keyNavBarIndicatorOpacity,
      ThemeKey.defaultNavBarIndicatorOpacity,
    );
    _navBarLabelBehavior = await _themeService.load(
      ThemeKey.keyNavBarLabelBehavior,
      ThemeKey.defaultNavBarLabelBehavior,
    );
    //
    // NavigationRail SETTINGS.
    _navRailBackgroundSchemeColor = await _themeService.load(
      ThemeKey.keyNavRailBackgroundSchemeColor,
      ThemeKey.defaultNavRailBackgroundSchemeColor,
    );
    _navRailOpacity = await _themeService.load(
      ThemeKey.keyNavRailOpacity,
      ThemeKey.defaultNavRailOpacity,
    );
    _navigationRailElevation = await _themeService.load(
      ThemeKey.keyNavigationRailElevation,
      ThemeKey.defaultNavigationRailElevation,
    );
    _navRailSelectedSchemeColor = await _themeService.load(
      ThemeKey.keyNavRailSelectedItemSchemeColor,
      ThemeKey.defaultNavRailSelectedItemSchemeColor,
    );
    _navRailUnselectedSchemeColor = await _themeService.load(
      ThemeKey.keyNavRailUnselectedSchemeColor,
      ThemeKey.defaultNavRailUnselectedSchemeColor,
    );
    _navRailMuteUnselected = await _themeService.load(
      ThemeKey.keyNavRailMuteUnselected,
      ThemeKey.defaultNavRailMuteUnselected,
    );
    _navRailLabelType = await _themeService.load(
      ThemeKey.keyNavRailLabelType,
      ThemeKey.defaultNavRailLabelType,
    );
    _navRailUseIndicator = await _themeService.load(
      ThemeKey.keyNavRailUseIndicator,
      ThemeKey.defaultNavRailUseIndicator,
    );
    _navRailIndicatorSchemeColor = await _themeService.load(
      ThemeKey.keyNavRailIndicatorSchemeColor,
      ThemeKey.defaultNavRailIndicatorSchemeColor,
    );
    _navRailIndicatorOpacity = await _themeService.load(
      ThemeKey.keyNavRailIndicatorOpacity,
      ThemeKey.defaultNavRailIndicatorOpacity,
    );
    //
    // Button SETTINGS.
    _textButtonSchemeColor = await _themeService.load(
      ThemeKey.keyTextButtonSchemeColor,
      ThemeKey.defaultTextButtonSchemeColor,
    );
    _textButtonBorderRadius = await _themeService.load(
      ThemeKey.keyTextButtonBorderRadius,
      ThemeKey.defaultTextButtonBorderRadius,
    );
    _elevatedButtonSchemeColor = await _themeService.load(
      ThemeKey.keyElevatedButtonSchemeColor,
      ThemeKey.defaultElevatedButtonSchemeColor,
    );
    _elevatedButtonBorderRadius = await _themeService.load(
      ThemeKey.keyElevatedButtonBorderRadius,
      ThemeKey.defaultElevatedButtonBorderRadius,
    );
    _outlinedButtonSchemeColor = await _themeService.load(
      ThemeKey.keyOutlinedButtonSchemeColor,
      ThemeKey.defaultOutlinedButtonSchemeColor,
    );
    _outlinedButtonBorderRadius = await _themeService.load(
      ThemeKey.keyOutlinedButtonBorderRadius,
      ThemeKey.defaultOutlinedButtonBorderRadius,
    );
    _toggleButtonsSchemeColor = await _themeService.load(
      ThemeKey.keyToggleButtonsSchemeColor,
      ThemeKey.defaultToggleButtonsSchemeColor,
    );
    _toggleButtonsBorderRadius = await _themeService.load(
      ThemeKey.keyToggleButtonsBorderRadius,
      ThemeKey.defaultToggleButtonsBorderRadius,
    );
    //
    // Toggleable SETTINGS.
    _unselectedToggleIsColored = await _themeService.load(
      ThemeKey.keyUnselectedToggleIsColored,
      ThemeKey.defaultUnselectedToggleIsColored,
    );
    _switchSchemeColor = await _themeService.load(
      ThemeKey.keySwitchSchemeColor,
      ThemeKey.defaultSwitchSchemeColor,
    );
    _checkboxSchemeColor = await _themeService.load(
      ThemeKey.keyCheckboxSchemeColor,
      ThemeKey.defaultCheckboxSchemeColor,
    );
    _radioSchemeColor = await _themeService.load(
      ThemeKey.keyRadioSchemeColor,
      ThemeKey.defaultRadioSchemeColor,
    );
    //
    // Fab, Chip, SnackBar, Popup, Card nad Dialog SETTINGS.
    _fabUseShape = await _themeService.load(
      ThemeKey.keyFabUseShape,
      ThemeKey.defaultFabUseShape,
    );
    _fabBorderRadius = await _themeService.load(
      ThemeKey.keyFabBorderRadius,
      ThemeKey.defaultFabBorderRadius,
    );
    _fabSchemeColor = await _themeService.load(
      ThemeKey.keyFabSchemeColor,
      ThemeKey.defaultFabSchemeColor,
    );
    _chipSchemeColor = await _themeService.load(
      ThemeKey.keyChipSchemeColor,
      ThemeKey.defaultChipSchemeColor,
    );
    _chipBorderRadius = await _themeService.load(
      ThemeKey.keyChipBorderRadius,
      ThemeKey.defaultChipBorderRadius,
    );
    _snackBarSchemeColor = await _themeService.load(
      ThemeKey.keySnackBarSchemeColor,
      ThemeKey.defaultSnackBarSchemeColor,
    );
    _popupMenuOpacity = await _themeService.load(
      ThemeKey.keyPopupMenuOpacity,
      ThemeKey.defaultPopupMenuOpacity,
    );
    _popupMenuBorderRadius = await _themeService.load(
      ThemeKey.keyPopupMenuBorderRadius,
      ThemeKey.defaultPopupMenuBorderRadius,
    );
    _cardBorderRadius = await _themeService.load(
      ThemeKey.keyCardBorderRadius,
      ThemeKey.defaultCardBorderRadius,
    );
    _dialogBackgroundSchemeColor = await _themeService.load(
      ThemeKey.keyDialogBackgroundSchemeColor,
      ThemeKey.defaultDialogBackgroundSchemeColor,
    );
    _dialogBorderRadius = await _themeService.load(
      ThemeKey.keyDialogBorderRadius,
      ThemeKey.defaultDialogBorderRadius,
    );
    //
    // Custom surface tint color SETTINGS.
    _surfaceTintLight = await _themeService.load(
      ThemeKey.keySurfaceTintLight,
      ThemeKey.defaultSurfaceTintLight,
    );
    _surfaceTintDark = await _themeService.load(
      ThemeKey.keySurfaceTintDark,
      ThemeKey.defaultSurfaceTintDark,
    );
    //
    // Custom color SETTINGS.
    _primaryLight = await _themeService.load(
      ThemeKey.keyPrimaryLight,
      themeDefaults.defaultPrimaryLight,
    );
    _primaryContainerLight = await _themeService.load<Color>(
      ThemeKey.keyPrimaryContainerLight,
      themeDefaults.defaultPrimaryContainerLight,
    );
    _secondaryLight = await _themeService.load(
      ThemeKey.keySecondaryLight,
      themeDefaults.defaultSecondaryLight,
    );
    _secondaryContainerLight = await _themeService.load(
      ThemeKey.keySecondaryContainerLight,
      themeDefaults.defaultSecondaryContainerLight,
    );
    _tertiaryLight = await _themeService.load(
      ThemeKey.keyTertiaryLight,
      themeDefaults.defaultTertiaryLight,
    );
    _tertiaryContainerLight = await _themeService.load(
      ThemeKey.keyTertiaryContainerLight,
      themeDefaults.defaultTertiaryContainerLight,
    );
    _primaryDark = await _themeService.load(
      ThemeKey.keyPrimaryDark,
      themeDefaults.defaultPrimaryDark,
    );
    _primaryContainerDark = await _themeService.load(
      ThemeKey.keyPrimaryContainerDark,
      themeDefaults.defaultPrimaryContainerDark,
    );
    _secondaryDark = await _themeService.load(
      ThemeKey.keySecondaryDark,
      themeDefaults.defaultSecondaryDark,
    );
    _secondaryContainerDark = await _themeService.load(
      ThemeKey.keySecondaryContainerDark,
      themeDefaults.defaultSecondaryContainerDark,
    );
    _tertiaryDark = await _themeService.load(
      ThemeKey.keyTertiaryDark,
      themeDefaults.defaultTertiaryDark,
    );
    _tertiaryContainerDark = await _themeService.load(
      ThemeKey.keyTertiaryContainerDark,
      themeDefaults.defaultTertiaryContainerDark,
    );

    // Not persisted, locally controlled popup selection for ThemeService,
    // resets to actual used platform when settings are reset or app loaded.
    _platform = defaultTargetPlatform;

    notifyListeners();
  }

  /// Reset all values to default values and save as current settings.
  ///
  /// Calls setters with notify = false, and calls notifyListeners once
  /// after all values have been reset and persisted.
  ///
  /// The reset to default actually, sets and persist all property values that
  /// deviates from its defined default value. Only values that actually
  /// deviate from their default value are changed. The property setters manage
  /// this. They are all set with no notification and notifyListeners() is
  /// only called once, after all updates have been made.
  ///
  /// Does not reset the custom colors to their default, only theme settings.
  /// We keep the custom colors at their specified values even if theme settings
  /// are reset. There is a separate function to reset the custom colors.
  Future<void> resetAllToDefaults() async {
    //
    // GENERAL SETTINGS.
    // ThemeMode, use FlexColorScheme and sub-themes, current scheme, view, etc.
    await setThemeMode(ThemeKey.defaultThemeMode, false);
    await setUseFlexColorScheme(ThemeKey.defaultUseFlexColorScheme, false);
    await setUseSubThemes(ThemeKey.defaultUseSubThemes, false);
    await setUseFlutterDefaults(ThemeKey.defaultUseFlutterDefaults, false);
    // The IsLargeGridView and ViewIndex settings are never reset to default in
    // a reset, we always keep the current screen and panel on page/panel view.
    await setUseTextTheme(ThemeKey.defaultUseTextTheme, false);
    await setUseAppFont(ThemeKey.defaultUseAppFont, false);
    await setUsedScheme(ThemeKey.defaultUsedScheme, false);
    await setSchemeIndex(ThemeKey.defaultSchemeIndex, false);
    await setInteractionEffects(ThemeKey.defaultInteractionEffects, false);
    await setDefaultRadius(ThemeKey.defaultDefaultRadius, false);
    await setTooltipsMatchBackground(
      ThemeKey.defaultTooltipsMatchBackground,
      false,
    );
    //
    // Surface and blend SETTINGS.
    await setSurfaceModeLight(ThemeKey.defaultSurfaceModeLight, false);
    await setSurfaceModeDark(ThemeKey.defaultSurfaceModeDark, false);
    await setBlendLevel(ThemeKey.defaultBlendLevel, false);
    await setBlendLevelDark(ThemeKey.defaultBlendLevelDark, false);
    await setBlendOnLevel(ThemeKey.defaultBlendOnLevel, false);
    await setBlendOnLevelDark(ThemeKey.defaultBlendOnLevelDark, false);
    await setUsedColors(ThemeKey.defaultUsedColors, false);
    await setSwapLightColors(ThemeKey.defaultSwapLightColors, false);
    await setSwapDarkColors(ThemeKey.defaultSwapDarkColors, false);
    await setLightIsWhite(ThemeKey.defaultLightIsWhite, false);
    await setDarkIsTrueBlack(ThemeKey.defaultDarkIsTrueBlack, false);
    await setUseDarkColorsForSeed(ThemeKey.defaultUseDarkColorsForSeed, false);
    await setUseToDarkMethod(ThemeKey.defaultUseToDarkMethod, false);
    await setToDarkSwapPrimaryAndContainer(
      ThemeKey.defaultToDarkSwapPrimaryAndContainer,
      false,
    );
    await setDarkMethodLevel(ThemeKey.defaultDarkMethodLevel, false);
    await setBlendLightOnColors(ThemeKey.defaultBlendLightOnColors, false);
    await setBlendDarkOnColors(ThemeKey.defaultBlendDarkOnColors, false);
    await setBlendLightTextTheme(ThemeKey.defaultBlendLightTextTheme, false);
    await setBlendDarkTextTheme(ThemeKey.defaultBlendDarkTextTheme, false);
    //
    // Material 3 and Seed ColorScheme SETTINGS.
    await setUseMaterial3(ThemeKey.defaultUseMaterial3, false);
    await setUseKeyColors(ThemeKey.defaultUseKeyColors, false);
    await setUseSecondary(ThemeKey.defaultUseSecondary, false);
    await setUseTertiary(ThemeKey.defaultUseTertiary, false);
    await setKeepPrimary(ThemeKey.defaultKeepPrimary, false);
    await setKeepSecondary(ThemeKey.defaultKeepSecondary, false);
    await setKeepTertiary(ThemeKey.defaultKeepTertiary, false);
    await setKeepPrimaryContainer(ThemeKey.defaultKeepPrimaryContainer, false);
    await setKeepSecondaryContainer(
      ThemeKey.defaultKeepSecondaryContainer,
      false,
    );
    await setKeepTertiaryContainer(
      ThemeKey.defaultKeepTertiaryContainer,
      false,
    );
    await setKeepDarkPrimary(ThemeKey.defaultKeepDarkPrimary, false);
    await setKeepDarkSecondary(ThemeKey.defaultKeepDarkSecondary, false);
    await setKeepDarkTertiary(ThemeKey.defaultKeepDarkTertiary, false);
    await setKeepDarkPrimaryContainer(
      ThemeKey.defaultKeepDarkPrimaryContainer,
      false,
    );
    await setKeepDarkSecondaryContainer(
      ThemeKey.defaultKeepDarkSecondaryContainer,
      false,
    );
    await setKeepDarkTertiaryContainer(
      ThemeKey.defaultKeepDarkTertiaryContainer,
      false,
    );
    await setUsedFlexToneSetup(ThemeKey.defaultUsedFlexToneSetup, false);
    await setUseM3ErrorColors(ThemeKey.defaultUseM3ErrorColors, false);
    //
    // InputDecorator SETTINGS.
    await setInputDecoratorSchemeColorLight(
      ThemeKey.defaultInputDecoratorSchemeColorLight,
      false,
    );
    await setInputDecoratorSchemeColorDark(
      ThemeKey.defaultInputDecoratorSchemeColorDark,
      false,
    );
    await setInputDecoratorIsFilled(
      ThemeKey.defaultInputDecoratorIsFilled,
      false,
    );
    await setInputDecoratorBorderType(
      ThemeKey.defaultInputDecoratorBorderType,
      false,
    );
    await setInputDecoratorBorderRadius(
      ThemeKey.defaultInputDecoratorBorderRadius,
      false,
    );
    await setInputDecoratorUnfocusedHasBorder(
      ThemeKey.defaultInputDecoratorUnfocusedHasBorder,
      false,
    );
    await setInputDecoratorUnfocusedBorderIsColored(
      ThemeKey.defaultInputDecoratorUnfocusedBorderIsColored,
      false,
    );
    //
    // AppBar SETTINGS.
    await setAppBarStyleLight(ThemeKey.defaultAppBarStyleLight, false);
    await setAppBarStyleDark(ThemeKey.defaultAppBarStyleDark, false);
    await setAppBarOpacityLight(ThemeKey.defaultAppBarOpacityLight, false);
    await setAppBarOpacityDark(ThemeKey.defaultAppBarOpacityDark, false);
    await setAppBarElevationLight(ThemeKey.defaultAppBarElevationLight, false);
    await setAppBarElevationDark(ThemeKey.defaultAppBarElevationDark, false);
    await setTransparentStatusBar(ThemeKey.defaultTransparentStatusBar, false);
    await setAppBarBackgroundSchemeColorLight(
      ThemeKey.defaultAppBarBackgroundSchemeColorLight,
      false,
    );
    await setAppBarBackgroundSchemeColorDark(
      ThemeKey.defaultAppBarBackgroundSchemeColorDark,
      false,
    );
    //
    // TabBar SETTINGS.
    await setTabBarStyle(ThemeKey.defaultTabBarStyle, false);
    await setTabBarIndicatorLight(ThemeKey.defaultTabBarIndicatorLight, false);
    await setTabBarIndicatorDark(ThemeKey.defaultTabBarIndicatorDark, false);
    await setTabBarItemSchemeColorLight(
      ThemeKey.defaultTabBarItemSchemeColorLight,
      false,
    );
    await setTabBarItemSchemeColorDark(
      ThemeKey.defaultTabBarItemSchemeColorDark,
      false,
    );
    //
    // BottomSheet SETTINGS.
    await setBottomSheetBorderRadius(
      ThemeKey.defaultBottomSheetBorderRadius,
      false,
    );
    //
    // Android System Navigator bar SETTINGS.
    await setSysNavBarStyle(ThemeKey.defaultSysNavBarStyle, false);
    await setSysBarOpacity(ThemeKey.defaultSysBarOpacity, false);
    await setUseSysNavDivider(ThemeKey.defaultUseSysNavDivider, false);
    //
    // BottomNavigationBar SETTINGS.
    await setBottomNavBarBackgroundSchemeColor(
      ThemeKey.defaultBottomNavBarBackgroundSchemeColor,
      false,
    );
    await setBottomNavigationBarOpacity(
      ThemeKey.defaultBottomNavigationBarOpacity,
      false,
    );
    await setBottomNavigationBarElevation(
      ThemeKey.defaultBottomNavigationBarElevation,
      false,
    );
    await setBottomNavBarSelectedSchemeColor(
      ThemeKey.defaultBottomNavBarSelectedItemSchemeColor,
      false,
    );
    await setBottomNavBarUnselectedSchemeColor(
      ThemeKey.defaultBottomNavBarUnselectedSchemeColor,
      false,
    );
    await setBottomNavBarMuteUnselected(
      ThemeKey.defaultBottomNavBarMuteUnselected,
      false,
    );
    await setBottomNavShowSelectedLabels(
      ThemeKey.defaultBottomNavShowSelectedLabels,
      false,
    );
    await setBottomNavShowUnselectedLabels(
      ThemeKey.defaultBottomNavShowUnselectedLabels,
      false,
    );
    //
    // NavigationBar SETTINGS.
    await setNavBarBackgroundSchemeColor(
      ThemeKey.defaultNavBarBackgroundSchemeColor,
      false,
    );
    await setNavBarOpacity(ThemeKey.defaultNavBarOpacity, false);
    await setNavBarHeight(ThemeKey.defaultNavBarHeight, false);
    await setNavBarSelectedSchemeColor(
      ThemeKey.defaultNavBarSelectedItemSchemeColor,
      false,
    );
    await setNavBarUnselectedSchemeColor(
      ThemeKey.defaultNavBarUnselectedSchemeColor,
      false,
    );
    await setNavBarMuteUnselected(ThemeKey.defaultNavBarMuteUnselected, false);
    await setNavBarIndicatorSchemeColor(
      ThemeKey.defaultNavBarIndicatorSchemeColor,
      false,
    );
    await setNavBarIndicatorOpacity(
      ThemeKey.defaultNavBarIndicatorOpacity,
      false,
    );
    await setNavBarLabelBehavior(ThemeKey.defaultNavBarLabelBehavior, false);
    //
    // NavigationRail SETTINGS.
    await setNavRailBackgroundSchemeColor(
      ThemeKey.defaultNavRailBackgroundSchemeColor,
      false,
    );
    await setNavRailOpacity(ThemeKey.defaultNavRailOpacity, false);
    await setNavigationRailElevation(
      ThemeKey.defaultNavigationRailElevation,
      false,
    );
    await setNavRailSelectedSchemeColor(
      ThemeKey.defaultNavRailSelectedItemSchemeColor,
      false,
    );
    await setNavRailUnselectedSchemeColor(
      ThemeKey.defaultNavRailUnselectedSchemeColor,
      false,
    );
    await setNavRailMuteUnselected(
      ThemeKey.defaultNavRailMuteUnselected,
      false,
    );
    await setNavRailLabelType(ThemeKey.defaultNavRailLabelType, false);
    await setNavRailUseIndicator(ThemeKey.defaultNavRailUseIndicator, false);
    await setNavRailIndicatorSchemeColor(
      ThemeKey.defaultNavRailIndicatorSchemeColor,
      false,
    );
    await setNavRailIndicatorOpacity(
      ThemeKey.defaultNavRailIndicatorOpacity,
      false,
    );
    //
    // Button SETTINGS.
    await setTextButtonSchemeColor(
      ThemeKey.defaultTextButtonSchemeColor,
      false,
    );
    await setTextButtonBorderRadius(
      ThemeKey.defaultTextButtonBorderRadius,
      false,
    );
    await setElevatedButtonSchemeColor(
      ThemeKey.defaultElevatedButtonSchemeColor,
      false,
    );
    await setElevatedButtonBorderRadius(
      ThemeKey.defaultElevatedButtonBorderRadius,
      false,
    );
    await setOutlinedButtonSchemeColor(
      ThemeKey.defaultOutlinedButtonSchemeColor,
      false,
    );
    await setOutlinedButtonBorderRadius(
      ThemeKey.defaultOutlinedButtonBorderRadius,
      false,
    );
    await setToggleButtonsSchemeColor(
      ThemeKey.defaultToggleButtonsSchemeColor,
      false,
    );
    await setToggleButtonsBorderRadius(
      ThemeKey.defaultToggleButtonsBorderRadius,
      false,
    );
    //
    // Toggleable SETTINGS.
    await setUnselectedToggleIsColored(
      ThemeKey.defaultUnselectedToggleIsColored,
      false,
    );
    await setSwitchSchemeColor(ThemeKey.defaultSwitchSchemeColor, false);
    await setCheckboxSchemeColor(ThemeKey.defaultCheckboxSchemeColor, false);
    await setRadioSchemeColor(ThemeKey.defaultRadioSchemeColor, false);
    //
    // Fab, Chip, SnackBar, Popup, Card nad Dialog SETTINGS.
    await setFabUseShape(ThemeKey.defaultFabUseShape, false);
    await setFabBorderRadius(ThemeKey.defaultFabBorderRadius, false);
    await setFabSchemeColor(ThemeKey.defaultFabSchemeColor, false);
    await setChipSchemeColor(ThemeKey.defaultChipSchemeColor, false);
    await setChipBorderRadius(ThemeKey.defaultChipBorderRadius, false);
    await setSnackBarSchemeColor(ThemeKey.defaultSnackBarSchemeColor, false);
    await setPopupMenuOpacity(ThemeKey.defaultPopupMenuOpacity, false);
    await setPopupMenuBorderRadius(
      ThemeKey.defaultPopupMenuBorderRadius,
      false,
    );
    await setCardBorderRadius(ThemeKey.defaultCardBorderRadius, false);
    await setDialogBackgroundSchemeColor(
      ThemeKey.defaultDialogBackgroundSchemeColor,
      false,
    );
    await setDialogBorderRadius(ThemeKey.defaultDialogBorderRadius, false);
    //
    // Surface tint colors.
    await setSurfaceTintLight(ThemeKey.defaultSurfaceTintLight, false);
    await setSurfaceTintDark(ThemeKey.defaultSurfaceTintDark, false);
    //
    // Not persisted, locally controlled popup selection for ThemeService,
    // resets to actual used platform when settings are reset or app loaded.
    await setPlatform(defaultTargetPlatform, false);
    notifyListeners();
  }

  /// Reset the custom color values to their default values.
  ///
  /// Calls setters with notify = false, and calls notifyListeners once
  /// after all values have been reset and persisted.
  ///
  /// The reset to default actually, sets and persist all property values that
  /// deviates from its defined default value. Only values that actually
  /// deviate from their default value are changed. The property setters manage
  /// this. They are all set with not notification and notifyListeners() is
  /// only called once, weh all updates have been made.
  Future<void> resetCustomColorsToDefaults(ThemeDefaults themeDefaults) async {
    await setPrimaryLight(themeDefaults.defaultPrimaryLight, false);
    await setPrimaryContainerLight(
      themeDefaults.defaultPrimaryContainerLight,
      false,
    );
    await setSecondaryLight(themeDefaults.defaultSecondaryLight, false);
    await setSecondaryContainerLight(
      themeDefaults.defaultSecondaryContainerLight,
      false,
    );
    await setTertiaryLight(themeDefaults.defaultTertiaryLight, false);
    await setTertiaryContainerLight(
      themeDefaults.defaultTertiaryContainerLight,
      false,
    );
    await setPrimaryDark(themeDefaults.defaultPrimaryDark, false);
    await setPrimaryContainerDark(
      themeDefaults.defaultPrimaryContainerDark,
      false,
    );
    await setSecondaryDark(themeDefaults.defaultSecondaryDark, false);
    await setSecondaryContainerDark(
      themeDefaults.defaultSecondaryContainerDark,
      false,
    );
    await setTertiaryDark(themeDefaults.defaultTertiaryDark, false);
    await setTertiaryContainerDark(
      themeDefaults.defaultTertiaryContainerDark,
      false,
    );
    notifyListeners();
  }

  // GENERAL SETTINGS.
  // ThemeMode, use FlexColorScheme and sub-themes, current scheme, view, etc.
  // ===========================================================================

  // Make all ThemeController properties private so they cannot be used
  // directly without also persisting the changes using the ThemeService,
  // by making a setter and getter for each property.

  // Private value, getter and setter for the ThemeMode
  late ThemeMode _themeMode;
  // Getter for the current ThemeMode.
  ThemeMode get themeMode => _themeMode;
  // Set and persist new ThemeMode value.
  Future<void> setThemeMode(ThemeMode? value, [bool notify = true]) async {
    // No work if null value passed.
    if (value == null) return;
    // Do not perform any work if new and old value are identical.
    if (value == _themeMode) return;
    // Otherwise, assign new value to private property.
    _themeMode = value;
    // Inform all listeners a change has occurred, if notify flag is true.
    if (notify) notifyListeners();
    // Persist the change to whatever storage is used with the ThemeService.
    await _themeService.save(ThemeKey.keyThemeMode, value);
  }

  // Repeat above pattern for all other theme settings. The properties will
  // not be further explained, property names correspond to equivalent
  // FlexColorScheme properties.
  late bool _useFlexColorScheme;
  bool get useFlexColorScheme => _useFlexColorScheme;
  Future<void> setUseFlexColorScheme(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useFlexColorScheme) return;
    _useFlexColorScheme = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseFlexColorScheme, value);
  }

  late bool _useSubThemes;
  bool get useSubThemes => _useSubThemes;
  Future<void> setUseSubThemes(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useSubThemes) return;
    _useSubThemes = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseSubThemes, value);
  }

  late bool _useFlutterDefaults;
  bool get useFlutterDefaults => _useFlutterDefaults;
  Future<void> setUseFlutterDefaults(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useFlutterDefaults) return;
    _useFlutterDefaults = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseFlutterDefaults, value);
  }

  late bool _isLargeGridView;
  bool get isLargeGridView => _isLargeGridView;
  Future<void> setAdvancedView(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _isLargeGridView) return;
    _isLargeGridView = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyIsLargeGridView, value);
  }

  late int _viewIndex;
  int get viewIndex => _viewIndex;
  Future<void> setViewIndex(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _viewIndex) return;
    _viewIndex = value;
    notifyListeners();
    await _themeService.save(ThemeKey.keyViewIndex, value);
  }

  late bool _useTextTheme;
  bool get useTextTheme => _useTextTheme;
  Future<void> setUseTextTheme(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useTextTheme) return;
    _useTextTheme = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseTextTheme, value);
  }

  late bool _useAppFont;
  bool get useAppFont => _useAppFont;
  Future<void> setUseAppFont(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useAppFont) return;
    _useAppFont = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseAppFont, value);
  }

  late FlexScheme _usedScheme;
  FlexScheme get usedScheme => _usedScheme;
  Future<void> setUsedScheme(FlexScheme? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _usedScheme) return;
    _usedScheme = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUsedScheme, value);
  }

  late int _schemeIndex;
  int get schemeIndex => _schemeIndex;
  Future<void> setSchemeIndex(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _schemeIndex) return;
    _schemeIndex = value;
    notifyListeners();
    await _themeService.save(ThemeKey.keySchemeIndex, value);
  }

  late bool _interactionEffects;
  bool get interactionEffects => _interactionEffects;
  Future<void> setInteractionEffects(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _interactionEffects) return;
    _interactionEffects = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyInteractionEffects, value);
  }

  late double? _defaultRadius;
  double? get defaultRadius => _defaultRadius;
  Future<void> setDefaultRadius(double? value, [bool notify = true]) async {
    if (value == _defaultRadius) return;
    _defaultRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyDefaultRadius, value);
  }

  late bool _tooltipsMatchBackground;
  bool get tooltipsMatchBackground => _tooltipsMatchBackground;
  Future<void> setTooltipsMatchBackground(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _tooltipsMatchBackground) return;
    _tooltipsMatchBackground = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTooltipsMatchBackground, value);
  }

  // Surface and blend SETTINGS.
  // ===========================================================================

  late FlexSurfaceMode _surfaceModeLight;
  FlexSurfaceMode get surfaceModeLight => _surfaceModeLight;
  Future<void> setSurfaceModeLight(
    FlexSurfaceMode? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _surfaceModeLight) return;
    _surfaceModeLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySurfaceModeLight, value);
  }

  late FlexSurfaceMode _surfaceModeDark;
  FlexSurfaceMode get surfaceModeDark => _surfaceModeDark;
  Future<void> setSurfaceModeDark(
    FlexSurfaceMode? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _surfaceModeDark) return;
    _surfaceModeDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySurfaceModeDark, value);
  }

  late int _blendLevel;
  int get blendLevel => _blendLevel;
  Future<void> setBlendLevel(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendLevel) return;
    _blendLevel = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBlendLevel, value);
  }

  late int _blendLevelDark;
  int get blendLevelDark => _blendLevelDark;
  Future<void> setBlendLevelDark(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendLevelDark) return;
    _blendLevelDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBlendLevelDark, value);
  }

  late int _blendOnLevel;
  int get blendOnLevel => _blendOnLevel;
  Future<void> setBlendOnLevel(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendOnLevel) return;
    _blendOnLevel = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyOnBlendLevel, value);
  }

  late int _blendOnLevelDark;
  int get blendOnLevelDark => _blendOnLevelDark;
  Future<void> setBlendOnLevelDark(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendOnLevelDark) return;
    _blendOnLevelDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBlendOnLevelDark, value);
  }

  late int _usedColors;
  int get usedColors => _usedColors;
  Future<void> setUsedColors(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _usedColors) return;
    _usedColors = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUsedColors, value);
  }

  late bool _swapLightColors;
  bool get swapLightColors => _swapLightColors;
  Future<void> setSwapLightColors(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _swapLightColors) return;
    _swapLightColors = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySwapLightColors, value);
  }

  late bool _swapDarkColors;
  bool get swapDarkColors => _swapDarkColors;
  Future<void> setSwapDarkColors(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _swapDarkColors) return;
    _swapDarkColors = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySwapDarkColors, value);
  }

  late bool _lightIsWhite;
  bool get lightIsWhite => _lightIsWhite;
  Future<void> setLightIsWhite(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _lightIsWhite) return;
    _lightIsWhite = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyLightIsWhite, value);
  }

  late bool _darkIsTrueBlack;
  bool get darkIsTrueBlack => _darkIsTrueBlack;
  Future<void> setDarkIsTrueBlack(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _darkIsTrueBlack) return;
    _darkIsTrueBlack = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyDarkIsTrueBlack, value);
  }

  late bool _useDarkColorsForSeed;
  bool get useDarkColorsForSeed => _useDarkColorsForSeed;
  Future<void> setUseDarkColorsForSeed(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _useDarkColorsForSeed) return;
    _useDarkColorsForSeed = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseDarkColorsForSeed, value);
  }

  late bool _useToDarkMethod;
  bool get useToDarkMethod => _useToDarkMethod;
  Future<void> setUseToDarkMethod(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useToDarkMethod) return;
    _useToDarkMethod = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseToDarkMethod, value);
  }

  late bool _toDarkSwapPrimaryAndContainer;
  bool get toDarkSwapPrimaryAndContainer => _toDarkSwapPrimaryAndContainer;
  Future<void> setToDarkSwapPrimaryAndContainer(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _toDarkSwapPrimaryAndContainer) return;
    _toDarkSwapPrimaryAndContainer = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyToDarkSwapPrimaryAndContainer, value);
  }

  late int _darkMethodLevel;
  int get darkMethodLevel => _darkMethodLevel;
  Future<void> setDarkMethodLevel(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _darkMethodLevel) return;
    _darkMethodLevel = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyDarkMethodLevel, value);
  }

  // On color blending ON/OFF
  late bool _blendLightOnColors;
  bool get blendLightOnColors => _blendLightOnColors;
  Future<void> setBlendLightOnColors(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendLightOnColors) return;
    _blendLightOnColors = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBlendLightOnColors, value);
  }

  late bool _blendDarkOnColors;
  bool get blendDarkOnColors => _blendDarkOnColors;
  Future<void> setBlendDarkOnColors(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendDarkOnColors) return;
    _blendDarkOnColors = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBlendDarkOnColors, value);
  }

  // TextThem blending ON/OFF
  late bool _blendLightTextTheme;
  bool get blendLightTextTheme => _blendLightTextTheme;
  Future<void> setBlendLightTextTheme(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendLightTextTheme) return;
    _blendLightTextTheme = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBlendLightTextTheme, value);
  }

  late bool _blendDarkTextTheme;
  bool get blendDarkTextTheme => _blendDarkTextTheme;
  Future<void> setBlendDarkTextTheme(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendDarkTextTheme) return;
    _blendDarkTextTheme = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBlendDarkTextTheme, value);
  }

  // Material 3 and Seed ColorScheme SETTINGS.
  // ===========================================================================

  late bool _useMaterial3;
  bool get useMaterial3 => _useMaterial3;
  Future<void> setUseMaterial3(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useMaterial3) return;
    _useMaterial3 = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseMaterial3, value);
  }

  late bool _useKeyColors;
  bool get useKeyColors => _useKeyColors;
  Future<void> setUseKeyColors(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useKeyColors) return;
    _useKeyColors = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseKeyColors, value);
  }

  late bool _useSecondary;
  bool get useSecondary => _useSecondary;
  Future<void> setUseSecondary(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useSecondary) return;
    _useSecondary = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseSecondary, value);
  }

  late bool _useTertiary;
  bool get useTertiary => _useTertiary;
  Future<void> setUseTertiary(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useTertiary) return;
    _useTertiary = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseTertiary, value);
  }

  late bool _keepPrimary;
  bool get keepPrimary => _keepPrimary;
  Future<void> setKeepPrimary(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _keepPrimary) return;
    _keepPrimary = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepPrimary, value);
  }

  late bool _keepSecondary;
  bool get keepSecondary => _keepSecondary;
  Future<void> setKeepSecondary(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _keepSecondary) return;
    _keepSecondary = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepSecondary, value);
  }

  late bool _keepTertiary;
  bool get keepTertiary => _keepTertiary;
  Future<void> setKeepTertiary(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _keepTertiary) return;
    _keepTertiary = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepTertiary, value);
  }

  late bool _keepPrimaryContainer;
  bool get keepPrimaryContainer => _keepPrimaryContainer;
  Future<void> setKeepPrimaryContainer(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _keepPrimaryContainer) return;
    _keepPrimaryContainer = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepPrimaryContainer, value);
  }

  late bool _keepSecondaryContainer;
  bool get keepSecondaryContainer => _keepSecondaryContainer;
  Future<void> setKeepSecondaryContainer(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _keepSecondaryContainer) return;
    _keepSecondaryContainer = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepSecondaryContainer, value);
  }

  late bool _keepTertiaryContainer;
  bool get keepTertiaryContainer => _keepTertiaryContainer;
  Future<void> setKeepTertiaryContainer(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _keepTertiaryContainer) return;
    _keepTertiaryContainer = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepTertiaryContainer, value);
  }

  late bool _keepDarkPrimary;
  bool get keepDarkPrimary => _keepDarkPrimary;
  Future<void> setKeepDarkPrimary(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _keepDarkPrimary) return;
    _keepDarkPrimary = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepDarkPrimary, value);
  }

  late bool _keepDarkSecondary;
  bool get keepDarkSecondary => _keepDarkSecondary;
  Future<void> setKeepDarkSecondary(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _keepDarkSecondary) return;
    _keepDarkSecondary = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepDarkSecondary, value);
  }

  late bool _keepDarkTertiary;
  bool get keepDarkTertiary => _keepDarkTertiary;
  Future<void> setKeepDarkTertiary(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _keepDarkTertiary) return;
    _keepDarkTertiary = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepDarkTertiary, value);
  }

  late bool _keepDarkPrimaryContainer;
  bool get keepDarkPrimaryContainer => _keepDarkPrimaryContainer;
  Future<void> setKeepDarkPrimaryContainer(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _keepDarkPrimaryContainer) return;
    _keepDarkPrimaryContainer = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepDarkPrimaryContainer, value);
  }

  late bool _keepDarkSecondaryContainer;
  bool get keepDarkSecondaryContainer => _keepDarkSecondaryContainer;
  Future<void> setKeepDarkSecondaryContainer(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _keepDarkSecondaryContainer) return;
    _keepDarkSecondaryContainer = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepDarkSecondaryContainer, value);
  }

  late bool _keepDarkTertiaryContainer;
  bool get keepDarkTertiaryContainer => _keepDarkTertiaryContainer;
  Future<void> setKeepDarkTertiaryContainer(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _keepDarkTertiaryContainer) return;
    _keepDarkTertiaryContainer = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyKeepDarkTertiaryContainer, value);
  }

  late int _usedFlexToneSetup;
  int get usedFlexToneSetup => _usedFlexToneSetup;
  Future<void> setUsedFlexToneSetup(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _usedFlexToneSetup) return;
    _usedFlexToneSetup = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUsedFlexToneSetup, value);
  }

  late bool _useM3ErrorColors;
  bool get useM3ErrorColors => _useM3ErrorColors;
  Future<void> setUseM3ErrorColors(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useM3ErrorColors) return;
    _useM3ErrorColors = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseM3ErrorColors, value);
  }

  // InputDecorator SETTINGS.
  // ===========================================================================

  late SchemeColor? _inputDecoratorSchemeColorLight;
  SchemeColor? get inputDecoratorSchemeColorLight =>
      _inputDecoratorSchemeColorLight;
  Future<void> setInputDecoratorSchemeColorLight(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _inputDecoratorSchemeColorLight) return;
    _inputDecoratorSchemeColorLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyInputDecoratorSchemeColorLight, value);
  }

  late SchemeColor? _inputDecoratorSchemeColorDark;
  SchemeColor? get inputDecoratorSchemeColorDark =>
      _inputDecoratorSchemeColorDark;
  Future<void> setInputDecoratorSchemeColorDark(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _inputDecoratorSchemeColorDark) return;
    _inputDecoratorSchemeColorDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyInputDecoratorSchemeColorDark, value);
  }

  late bool _inputDecoratorIsFilled;
  bool get inputDecoratorIsFilled => _inputDecoratorIsFilled;
  Future<void> setInputDecoratorIsFilled(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _inputDecoratorIsFilled) return;
    _inputDecoratorIsFilled = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyInputDecoratorIsFilled, value);
  }

  late FlexInputBorderType _inputDecoratorBorderType;
  FlexInputBorderType get inputDecoratorBorderType => _inputDecoratorBorderType;
  Future<void> setInputDecoratorBorderType(
    FlexInputBorderType? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _inputDecoratorBorderType) return;
    _inputDecoratorBorderType = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyInputDecoratorBorderType, value);
  }

  late double? _inputDecoratorBorderRadius;
  double? get inputDecoratorBorderRadius => _inputDecoratorBorderRadius;
  Future<void> setInputDecoratorBorderRadius(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == _inputDecoratorBorderRadius) return;
    _inputDecoratorBorderRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyInputDecoratorBorderRadius, value);
  }

  late bool _inputDecoratorUnfocusedHasBorder;
  bool get inputDecoratorUnfocusedHasBorder =>
      _inputDecoratorUnfocusedHasBorder;
  Future<void> setInputDecoratorUnfocusedHasBorder(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _inputDecoratorUnfocusedHasBorder) return;
    _inputDecoratorUnfocusedHasBorder = value;
    if (notify) notifyListeners();
    await _themeService.save(
      ThemeKey.keyInputDecoratorUnfocusedHasBorder,
      value,
    );
  }

  late bool _inputDecoratorUnfocusedBorderIsColored;
  bool get inputDecoratorUnfocusedBorderIsColored =>
      _inputDecoratorUnfocusedBorderIsColored;
  Future<void> setInputDecoratorUnfocusedBorderIsColored(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _inputDecoratorUnfocusedBorderIsColored) return;
    _inputDecoratorUnfocusedBorderIsColored = value;
    if (notify) notifyListeners();
    await _themeService.save(
      ThemeKey.keyInputDecoratorUnfocusedBorderIsColored,
      value,
    );
  }

  // AppBar SETTINGS.
  // ===========================================================================

  late FlexAppBarStyle _appBarStyleLight;
  FlexAppBarStyle get appBarStyleLight => _appBarStyleLight;
  Future<void> setAppBarStyleLight(
    FlexAppBarStyle? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _appBarStyleLight) return;
    _appBarStyleLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyAppBarStyleLight, value);
  }

  late FlexAppBarStyle _appBarStyleDark;
  FlexAppBarStyle get appBarStyleDark => _appBarStyleDark;
  Future<void> setAppBarStyleDark(
    FlexAppBarStyle? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _appBarStyleDark) return;
    _appBarStyleDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyAppBarStyleDark, value);
  }

  late double _appBarOpacityLight;
  double get appBarOpacityLight => _appBarOpacityLight;
  Future<void> setAppBarOpacityLight(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _appBarOpacityLight) return;
    _appBarOpacityLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyAppBarOpacityLight, value);
  }

  late double _appBarOpacityDark;
  double get appBarOpacityDark => _appBarOpacityDark;
  Future<void> setAppBarOpacityDark(double? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _appBarOpacityDark) return;
    _appBarOpacityDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyAppBarOpacityDark, value);
  }

  late double _appBarElevationLight;
  double get appBarElevationLight => _appBarElevationLight;
  Future<void> setAppBarElevationLight(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _appBarElevationLight) return;
    _appBarElevationLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyAppBarElevationLight, value);
  }

  late double _appBarElevationDark;
  double get appBarElevationDark => _appBarElevationDark;
  Future<void> setAppBarElevationDark(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _appBarElevationDark) return;
    _appBarElevationDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyAppBarElevationDark, value);
  }

  late bool _transparentStatusBar;
  bool get transparentStatusBar => _transparentStatusBar;
  Future<void> setTransparentStatusBar(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _transparentStatusBar) return;
    _transparentStatusBar = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTransparentStatusBar, value);
  }

  late SchemeColor? _appBarBackgroundSchemeColorLight;
  SchemeColor? get appBarBackgroundSchemeColorLight =>
      _appBarBackgroundSchemeColorLight;
  Future<void> setAppBarBackgroundSchemeColorLight(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _appBarBackgroundSchemeColorLight) return;
    _appBarBackgroundSchemeColorLight = value;
    if (notify) notifyListeners();
    await _themeService.save(
      ThemeKey.keyAppBarBackgroundSchemeColorLight,
      value,
    );
  }

  late SchemeColor? _appBarBackgroundSchemeColorDark;
  SchemeColor? get appBarBackgroundSchemeColorDark =>
      _appBarBackgroundSchemeColorDark;
  Future<void> setAppBarBackgroundSchemeColorDark(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _appBarBackgroundSchemeColorDark) return;
    _appBarBackgroundSchemeColorDark = value;
    if (notify) notifyListeners();
    await _themeService.save(
      ThemeKey.keyAppBarBackgroundSchemeColorDark,
      value,
    );
  }

  // TabBar SETTINGS.
  // ===========================================================================

  late FlexTabBarStyle _tabBarStyle;
  FlexTabBarStyle get tabBarStyle => _tabBarStyle;
  Future<void> setTabBarStyle(
    FlexTabBarStyle? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _tabBarStyle) return;
    _tabBarStyle = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTabBarStyle, value);
  }

  late SchemeColor? _tabBarIndicatorLight;
  SchemeColor? get tabBarIndicatorLight => _tabBarIndicatorLight;
  Future<void> setTabBarIndicatorLight(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _tabBarIndicatorLight) return;
    _tabBarIndicatorLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTabBarIndicatorLight, value);
  }

  late SchemeColor? _tabBarIndicatorDark;
  SchemeColor? get tabBarIndicatorDark => _tabBarIndicatorDark;
  Future<void> setTabBarIndicatorDark(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _tabBarIndicatorDark) return;
    _tabBarIndicatorDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTabBarIndicatorDark, value);
  }

  late SchemeColor? _tabBarItemSchemeColorLight;
  SchemeColor? get tabBarItemSchemeColorLight => _tabBarItemSchemeColorLight;
  Future<void> setTabBarItemSchemeColorLight(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _tabBarItemSchemeColorLight) return;
    _tabBarItemSchemeColorLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTabBarItemSchemeColorLight, value);
  }

  late SchemeColor? _tabBarItemSchemeColorDark;
  SchemeColor? get tabBarItemSchemeColorDark => _tabBarItemSchemeColorDark;
  Future<void> setTabBarItemSchemeColorDark(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _tabBarItemSchemeColorDark) return;
    _tabBarItemSchemeColorDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTabBarItemSchemeColorDark, value);
  }

  //
  // BottomSheet SETTINGS.

  late double? _bottomSheetBorderRadius;
  double? get bottomSheetBorderRadius => _bottomSheetBorderRadius;
  Future<void> setBottomSheetBorderRadius(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == _bottomSheetBorderRadius) return;
    _bottomSheetBorderRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBottomSheetBorderRadius, value);
  }

  // Android System Navigator bar SETTINGS.
  // ===========================================================================

  late FlexSystemNavBarStyle _sysNavBarStyle;
  FlexSystemNavBarStyle get sysNavBarStyle => _sysNavBarStyle;
  Future<void> setSysNavBarStyle(
    FlexSystemNavBarStyle? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _sysNavBarStyle) return;
    _sysNavBarStyle = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySysNavBarStyle, value);
  }

  late double _sysNavBarOpacity;
  double get sysNavBarOpacity => _sysNavBarOpacity;
  Future<void> setSysBarOpacity(double? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _sysNavBarOpacity) return;
    _sysNavBarOpacity = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySysNavBarOpacity, value);
  }

  late bool _useSysNavDivider;
  bool get useSysNavDivider => _useSysNavDivider;
  Future<void> setUseSysNavDivider(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useSysNavDivider) return;
    _useSysNavDivider = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUseSysNavDivider, value);
  }

  // BottomNavigationBar SETTINGS.
  // ===========================================================================

  late SchemeColor? _bottomNavBarBackgroundSchemeColor;
  SchemeColor? get bottomNavBarBackgroundSchemeColor =>
      _bottomNavBarBackgroundSchemeColor;
  Future<void> setBottomNavBarBackgroundSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _bottomNavBarBackgroundSchemeColor) return;
    _bottomNavBarBackgroundSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(
      ThemeKey.keyBottomNavBarBackgroundSchemeColor,
      value,
    );
  }

  late double _bottomNavigationBarOpacity;
  double get bottomNavigationBarOpacity => _bottomNavigationBarOpacity;
  Future<void> setBottomNavigationBarOpacity(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _bottomNavigationBarOpacity) return;
    _bottomNavigationBarOpacity = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBottomNavigationBarOpacity, value);
  }

  late double _bottomNavigationBarElevation;
  double get bottomNavigationBarElevation => _bottomNavigationBarElevation;
  Future<void> setBottomNavigationBarElevation(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _bottomNavigationBarElevation) return;
    _bottomNavigationBarElevation = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBottomNavigationBarElevation, value);
  }

  late SchemeColor? _bottomNavBarSelectedSchemeColor;
  SchemeColor? get bottomNavBarSelectedSchemeColor =>
      _bottomNavBarSelectedSchemeColor;
  Future<void> setBottomNavBarSelectedSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _bottomNavBarSelectedSchemeColor) return;
    _bottomNavBarSelectedSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(
      ThemeKey.keyBottomNavBarSelectedItemSchemeColor,
      value,
    );
  }

  late SchemeColor? _bottomNavBarUnselectedSchemeColor;
  SchemeColor? get bottomNavBarUnselectedSchemeColor =>
      _bottomNavBarUnselectedSchemeColor;
  Future<void> setBottomNavBarUnselectedSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _bottomNavBarUnselectedSchemeColor) return;
    _bottomNavBarUnselectedSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(
      ThemeKey.keyBottomNavBarUnselectedSchemeColor,
      value,
    );
  }

  late bool _bottomNavBarMuteUnselected;
  bool get bottomNavBarMuteUnselected => _bottomNavBarMuteUnselected;
  Future<void> setBottomNavBarMuteUnselected(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _bottomNavBarMuteUnselected) return;
    _bottomNavBarMuteUnselected = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBottomNavBarMuteUnselected, value);
  }

  late bool _bottomNavShowSelectedLabels;
  bool get bottomNavShowSelectedLabels => _bottomNavShowSelectedLabels;
  Future<void> setBottomNavShowSelectedLabels(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _bottomNavShowSelectedLabels) return;
    _bottomNavShowSelectedLabels = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBottomNavShowSelectedLabels, value);
  }

  late bool _bottomNavShowUnselectedLabels;
  bool get bottomNavShowUnselectedLabels => _bottomNavShowUnselectedLabels;
  Future<void> setBottomNavShowUnselectedLabels(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _bottomNavShowUnselectedLabels) return;
    _bottomNavShowUnselectedLabels = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyBottomNavShowUnselectedLabels, value);
  }

  // NavigationBar SETTINGS.
  // ===========================================================================

  late SchemeColor? _navBarBackgroundSchemeColor;
  SchemeColor? get navBarBackgroundSchemeColor => _navBarBackgroundSchemeColor;
  Future<void> setNavBarBackgroundSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _navBarBackgroundSchemeColor) return;
    _navBarBackgroundSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavBarBackgroundSchemeColor, value);
  }

  late double _navBarOpacity;
  double get navBarOpacity => _navBarOpacity;
  Future<void> setNavBarOpacity(double? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _navBarOpacity) return;
    _navBarOpacity = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavBarOpacity, value);
  }

  late double? _navBarHeight;
  double? get navBarHeight => _navBarHeight;
  Future<void> setNavBarHeight(double? value, [bool notify = true]) async {
    if (value == _navBarHeight) return;
    _navBarHeight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavBarHeight, value);
  }

  late SchemeColor? _navBarSelectedSchemeColor;
  SchemeColor? get navBarSelectedSchemeColor => _navBarSelectedSchemeColor;
  Future<void> setNavBarSelectedSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _navBarSelectedSchemeColor) return;
    _navBarSelectedSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavBarSelectedItemSchemeColor, value);
  }

  late SchemeColor? _navBarUnselectedSchemeColor;
  SchemeColor? get navBarUnselectedSchemeColor => _navBarUnselectedSchemeColor;
  Future<void> setNavBarUnselectedSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _navBarUnselectedSchemeColor) return;
    _navBarUnselectedSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavBarUnselectedSchemeColor, value);
  }

  late bool _navBarMuteUnselected;
  bool get navBarMuteUnselected => _navBarMuteUnselected;
  Future<void> setNavBarMuteUnselected(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _navBarMuteUnselected) return;
    _navBarMuteUnselected = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavBarMuteUnselected, value);
  }

  late SchemeColor? _navBarIndicatorSchemeColor;
  SchemeColor? get navBarIndicatorSchemeColor => _navBarIndicatorSchemeColor;
  Future<void> setNavBarIndicatorSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _navBarIndicatorSchemeColor) return;
    _navBarIndicatorSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavBarIndicatorSchemeColor, value);
  }

  late double? _navBarIndicatorOpacity;
  double? get navBarIndicatorOpacity => _navBarIndicatorOpacity;
  Future<void> setNavBarIndicatorOpacity(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == _navBarIndicatorOpacity) return;
    _navBarIndicatorOpacity = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavBarIndicatorOpacity, value);
  }

  late NavigationDestinationLabelBehavior _navBarLabelBehavior;
  NavigationDestinationLabelBehavior get navBarLabelBehavior =>
      _navBarLabelBehavior;
  Future<void> setNavBarLabelBehavior(
    NavigationDestinationLabelBehavior value, [
    bool notify = true,
  ]) async {
    if (value == _navBarLabelBehavior) return;
    _navBarLabelBehavior = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavBarLabelBehavior, value);
  }

  // NavigationRail SETTINGS.
  // ===========================================================================

  late SchemeColor? _navRailBackgroundSchemeColor;
  SchemeColor? get navRailBackgroundSchemeColor =>
      _navRailBackgroundSchemeColor;
  Future<void> setNavRailBackgroundSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _navRailBackgroundSchemeColor) return;
    _navRailBackgroundSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavRailBackgroundSchemeColor, value);
  }

  late double _navRailOpacity;
  double get navRailOpacity => _navRailOpacity;
  Future<void> setNavRailOpacity(double? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _navRailOpacity) return;
    _navRailOpacity = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavRailOpacity, value);
  }

  late double _navigationRailElevation;
  double get navigationRailElevation => _navigationRailElevation;
  Future<void> setNavigationRailElevation(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _navigationRailElevation) return;
    _navigationRailElevation = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavigationRailElevation, value);
  }

  late SchemeColor? _navRailSelectedSchemeColor;
  SchemeColor? get navRailSelectedSchemeColor => _navRailSelectedSchemeColor;
  Future<void> setNavRailSelectedSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _navRailSelectedSchemeColor) return;
    _navRailSelectedSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavRailSelectedItemSchemeColor, value);
  }

  late SchemeColor? _navRailUnselectedSchemeColor;
  SchemeColor? get navRailUnselectedSchemeColor =>
      _navRailUnselectedSchemeColor;
  Future<void> setNavRailUnselectedSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _navRailUnselectedSchemeColor) return;
    _navRailUnselectedSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavRailUnselectedSchemeColor, value);
  }

  late bool _navRailMuteUnselected;
  bool get navRailMuteUnselected => _navRailMuteUnselected;
  Future<void> setNavRailMuteUnselected(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _navRailMuteUnselected) return;
    _navRailMuteUnselected = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavRailMuteUnselected, value);
  }

  late NavigationRailLabelType _navRailLabelType;
  NavigationRailLabelType get navRailLabelType => _navRailLabelType;
  Future<void> setNavRailLabelType(
    NavigationRailLabelType value, [
    bool notify = true,
  ]) async {
    if (value == _navRailLabelType) return;
    _navRailLabelType = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavRailLabelType, value);
  }

  late bool _navRailUseIndicator;
  bool get navRailUseIndicator => _navRailUseIndicator;
  Future<void> setNavRailUseIndicator(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _navRailUseIndicator) return;
    _navRailUseIndicator = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavRailUseIndicator, value);
  }

  late SchemeColor? _navRailIndicatorSchemeColor;
  SchemeColor? get navRailIndicatorSchemeColor => _navRailIndicatorSchemeColor;
  Future<void> setNavRailIndicatorSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _navRailIndicatorSchemeColor) return;
    _navRailIndicatorSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavRailIndicatorSchemeColor, value);
  }

  late double? _navRailIndicatorOpacity;
  double? get navRailIndicatorOpacity => _navRailIndicatorOpacity;
  Future<void> setNavRailIndicatorOpacity(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == _navRailIndicatorOpacity) return;
    _navRailIndicatorOpacity = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyNavRailIndicatorOpacity, value);
  }

  // Button SETTINGS.
  // ===========================================================================

  late SchemeColor? _textButtonSchemeColor;
  SchemeColor? get textButtonSchemeColor => _textButtonSchemeColor;
  Future<void> setTextButtonSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _textButtonSchemeColor) return;
    _textButtonSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTextButtonSchemeColor, value);
  }

  late double? _textButtonBorderRadius;
  double? get textButtonBorderRadius => _textButtonBorderRadius;
  Future<void> setTextButtonBorderRadius(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == _textButtonBorderRadius) return;
    _textButtonBorderRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTextButtonBorderRadius, value);
  }

  late SchemeColor? _elevatedButtonSchemeColor;
  SchemeColor? get elevatedButtonSchemeColor => _elevatedButtonSchemeColor;
  Future<void> setElevatedButtonSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _elevatedButtonSchemeColor) return;
    _elevatedButtonSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyElevatedButtonSchemeColor, value);
  }

  late double? _elevatedButtonBorderRadius;
  double? get elevatedButtonBorderRadius => _elevatedButtonBorderRadius;
  Future<void> setElevatedButtonBorderRadius(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == _elevatedButtonBorderRadius) return;
    _elevatedButtonBorderRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyElevatedButtonBorderRadius, value);
  }

  late SchemeColor? _outlinedButtonSchemeColor;
  SchemeColor? get outlinedButtonSchemeColor => _outlinedButtonSchemeColor;
  Future<void> setOutlinedButtonSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _outlinedButtonSchemeColor) return;
    _outlinedButtonSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyOutlinedButtonSchemeColor, value);
  }

  late double? _outlinedButtonBorderRadius;
  double? get outlinedButtonBorderRadius => _outlinedButtonBorderRadius;
  Future<void> setOutlinedButtonBorderRadius(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == _outlinedButtonBorderRadius) return;
    _outlinedButtonBorderRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyOutlinedButtonBorderRadius, value);
  }

  late SchemeColor? _toggleButtonsSchemeColor;
  SchemeColor? get toggleButtonsSchemeColor => _toggleButtonsSchemeColor;
  Future<void> setToggleButtonsSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _toggleButtonsSchemeColor) return;
    _toggleButtonsSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyToggleButtonsSchemeColor, value);
  }

  late double? _toggleButtonsBorderRadius;
  double? get toggleButtonsBorderRadius => _toggleButtonsBorderRadius;
  Future<void> setToggleButtonsBorderRadius(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == _toggleButtonsBorderRadius) return;
    _toggleButtonsBorderRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyToggleButtonsBorderRadius, value);
  }

  // Toggleable SETTINGS.
  // ===========================================================================

  late bool _unselectedToggleIsColored;
  bool get unselectedToggleIsColored => _unselectedToggleIsColored;
  Future<void> setUnselectedToggleIsColored(
    bool? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _unselectedToggleIsColored) return;
    _unselectedToggleIsColored = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyUnselectedToggleIsColored, value);
  }

  late SchemeColor? _switchSchemeColor;
  SchemeColor? get switchSchemeColor => _switchSchemeColor;
  Future<void> setSwitchSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _switchSchemeColor) return;
    _switchSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySwitchSchemeColor, value);
  }

  late SchemeColor? _checkboxSchemeColor;
  SchemeColor? get checkboxSchemeColor => _checkboxSchemeColor;
  Future<void> setCheckboxSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _checkboxSchemeColor) return;
    _checkboxSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyCheckboxSchemeColor, value);
  }

  late SchemeColor? _radioSchemeColor;
  SchemeColor? get radioSchemeColor => _radioSchemeColor;
  Future<void> setRadioSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _radioSchemeColor) return;
    _radioSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyRadioSchemeColor, value);
  }

  // Fab, Chip, SnackBar, Popup, Card nad Dialog SETTINGS.
  // ===========================================================================

  late bool _fabUseShape;
  bool get fabUseShape => _fabUseShape;
  Future<void> setFabUseShape(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _fabUseShape) return;
    _fabUseShape = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyFabUseShape, value);
  }

  late double? _fabBorderRadius;
  double? get fabBorderRadius => _fabBorderRadius;
  Future<void> setFabBorderRadius(double? value, [bool notify = true]) async {
    if (value == _fabBorderRadius) return;
    _fabBorderRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyFabBorderRadius, value);
  }

  late SchemeColor? _fabSchemeColor;
  SchemeColor? get fabSchemeColor => _fabSchemeColor;
  Future<void> setFabSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _fabSchemeColor) return;
    _fabSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyFabSchemeColor, value);
  }

  late SchemeColor? _chipSchemeColor;
  SchemeColor? get chipSchemeColor => _chipSchemeColor;
  Future<void> setChipSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _chipSchemeColor) return;
    _chipSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyChipSchemeColor, value);
  }

  late double? _chipBorderRadius;
  double? get chipBorderRadius => _chipBorderRadius;
  Future<void> setChipBorderRadius(double? value, [bool notify = true]) async {
    if (value == _chipBorderRadius) return;
    _chipBorderRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyChipBorderRadius, value);
  }

  late SchemeColor? _snackBarSchemeColor;
  SchemeColor? get snackBarSchemeColor => _snackBarSchemeColor;
  Future<void> setSnackBarSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _snackBarSchemeColor) return;
    _snackBarSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySnackBarSchemeColor, value);
  }

  late double _popupMenuOpacity;
  double get popupMenuOpacity => _popupMenuOpacity;
  Future<void> setPopupMenuOpacity(double? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _popupMenuOpacity) return;
    _popupMenuOpacity = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyPopupMenuOpacity, value);
  }

  late double? _popupMenuBorderRadius;
  double? get popupMenuBorderRadius => _popupMenuBorderRadius;
  Future<void> setPopupMenuBorderRadius(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == _popupMenuBorderRadius) return;
    _popupMenuBorderRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyPopupMenuBorderRadius, value);
  }

  late double? _cardBorderRadius;
  double? get cardBorderRadius => _cardBorderRadius;
  Future<void> setCardBorderRadius(double? value, [bool notify = true]) async {
    if (value == _cardBorderRadius) return;
    _cardBorderRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyCardBorderRadius, value);
  }

  late SchemeColor? _dialogBackgroundSchemeColor;
  SchemeColor? get dialogBackgroundSchemeColor => _dialogBackgroundSchemeColor;
  Future<void> setDialogBackgroundSchemeColor(
    SchemeColor? value, [
    bool notify = true,
  ]) async {
    if (value == _dialogBackgroundSchemeColor) return;
    _dialogBackgroundSchemeColor = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyDialogBackgroundSchemeColor, value);
  }

  late double? _dialogBorderRadius;
  double? get dialogBorderRadius => _dialogBorderRadius;
  Future<void> setDialogBorderRadius(
    double? value, [
    bool notify = true,
  ]) async {
    if (value == _dialogBorderRadius) return;
    _dialogBorderRadius = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyDialogBorderRadius, value);
  }

  // Custom surface tint color SETTINGS.
  // ===========================================================================

  late Color? _surfaceTintLight;
  Color? get surfaceTintLight => _surfaceTintLight;
  Future<void> setSurfaceTintLight(Color? value, [bool notify = true]) async {
    if (value == _surfaceTintLight) return;
    _surfaceTintLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySurfaceTintLight, value);
  }

  late Color? _surfaceTintDark;
  Color? get surfaceTintDark => _surfaceTintDark;
  Future<void> setSurfaceTintDark(Color? value, [bool notify = true]) async {
    if (value == _surfaceTintDark) return;
    _surfaceTintDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySurfaceTintDark, value);
  }

  // Custom color SETTINGS.
  // ===========================================================================

  late Color _primaryLight;
  Color get primaryLight => _primaryLight;
  Future<void> setPrimaryLight(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _primaryLight) return;
    _primaryLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyPrimaryLight, value);
  }

  late Color _primaryContainerLight;
  Color get primaryContainerLight => _primaryContainerLight;
  Future<void> setPrimaryContainerLight(
    Color? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _primaryContainerLight) return;
    _primaryContainerLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyPrimaryContainerLight, value);
  }

  late Color _secondaryLight;
  Color get secondaryLight => _secondaryLight;
  Future<void> setSecondaryLight(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _secondaryLight) return;
    _secondaryLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySecondaryLight, value);
  }

  late Color _secondaryContainerLight;
  Color get secondaryContainerLight => _secondaryContainerLight;
  Future<void> setSecondaryContainerLight(
    Color? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _secondaryContainerLight) return;
    _secondaryContainerLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySecondaryContainerLight, value);
  }

  late Color _tertiaryLight;
  Color get tertiaryLight => _tertiaryLight;
  Future<void> setTertiaryLight(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _tertiaryLight) return;
    _tertiaryLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTertiaryLight, value);
  }

  late Color _tertiaryContainerLight;
  Color get tertiaryContainerLight => _tertiaryContainerLight;
  Future<void> setTertiaryContainerLight(
    Color? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _tertiaryContainerLight) return;
    _tertiaryContainerLight = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTertiaryContainerLight, value);
  }

  late Color _primaryDark;
  Color get primaryDark => _primaryDark;
  Future<void> setPrimaryDark(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _primaryDark) return;
    _primaryDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyPrimaryDark, value);
  }

  late Color _primaryContainerDark;
  Color get primaryContainerDark => _primaryContainerDark;
  Future<void> setPrimaryContainerDark(
    Color? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _primaryContainerDark) return;
    _primaryContainerDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyPrimaryContainerDark, value);
  }

  late Color _secondaryDark;
  Color get secondaryDark => _secondaryDark;
  Future<void> setSecondaryDark(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _secondaryDark) return;
    _secondaryDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySecondaryDark, value);
  }

  late Color _secondaryContainerDark;
  Color get secondaryContainerDark => _secondaryContainerDark;
  Future<void> setSecondaryContainerDark(
    Color? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _secondaryContainerDark) return;
    _secondaryContainerDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keySecondaryContainerDark, value);
  }

  late Color _tertiaryDark;
  Color get tertiaryDark => _tertiaryDark;
  Future<void> setTertiaryDark(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _tertiaryDark) return;
    _tertiaryDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTertiaryDark, value);
  }

  late Color _tertiaryContainerDark;
  Color get tertiaryContainerDark => _tertiaryContainerDark;
  Future<void> setTertiaryContainerDark(
    Color? value, [
    bool notify = true,
  ]) async {
    if (value == null) return;
    if (value == _tertiaryContainerDark) return;
    _tertiaryContainerDark = value;
    if (notify) notifyListeners();
    await _themeService.save(ThemeKey.keyTertiaryContainerDark, value);
  }

  // Get custom scheme data based on currently defined scheme colors.
  FlexSchemeData get customScheme => FlexSchemeData(
        name: FlexColor.customName,
        description: FlexColor.customDescription,
        light: FlexSchemeColor(
          primary: primaryLight,
          primaryContainer: primaryContainerLight,
          secondary: secondaryLight,
          secondaryContainer: secondaryContainerLight,
          tertiary: tertiaryLight,
          tertiaryContainer: tertiaryContainerLight,
          appBarColor: secondaryContainerLight,
          error: FlexColor.materialLightError,
        ),
        dark: FlexSchemeColor(
          primary: primaryDark,
          primaryContainer: primaryContainerDark,
          secondary: secondaryDark,
          secondaryContainer: secondaryContainerDark,
          tertiary: tertiaryDark,
          tertiaryContainer: tertiaryContainerDark,
          appBarColor: secondaryContainerDark,
          error: FlexColor.materialDarkError,
        ),
      );

  // Set the custom scheme colors to the colors scheme FlexSchemeData.
  Future<void> setCustomScheme(FlexSchemeData scheme) async {
    // Don't notify listeners while setting new values for each value.
    await setPrimaryLight(scheme.light.primary, false);
    await setPrimaryContainerLight(scheme.light.primaryContainer, false);
    await setSecondaryLight(scheme.light.secondary, false);
    await setSecondaryContainerLight(scheme.light.secondaryContainer, false);
    await setTertiaryLight(scheme.light.tertiary, false);
    await setTertiaryContainerLight(scheme.light.tertiaryContainer, false);
    await setPrimaryDark(scheme.dark.primary, false);
    await setPrimaryContainerDark(scheme.dark.primaryContainer, false);
    await setSecondaryDark(scheme.dark.secondary, false);
    await setSecondaryContainerDark(scheme.dark.secondaryContainer, false);
    await setTertiaryDark(scheme.dark.tertiary, false);
    await setTertiaryContainerDark(scheme.dark.tertiaryContainer, false);
    // Notify listeners, after all individual values have been set.
    notifyListeners();
  }

  // This is just a controller prop for the Platform menu control.
  // It is used as input to the theme, but never persisted so it always
  // defaults to the actual target platform when starting the app.
  // Being able to toggle it during demos and development is a handy feature.
  //
  // This is OK to be in ThemeController, if this is changed, the entire app
  // theme must update too, and yes it is a part of ThemeData.
  late TargetPlatform _platform;
  TargetPlatform get platform => _platform;
  Future<void> setPlatform(TargetPlatform? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _platform) return;
    _platform = value;
    if (notify) notifyListeners();
  }

  // Recently used colors, we keep the list of recently used colors in the
  // color picker for custom colors only during the session we don't persist.
  // It is of course possible to persist, but not needed in this demo.
  //
  // This is OK to be in ThemeController, these colors change as we change
  // custom colors for the theme, that needs to update the entire app anyway.
  List<Color> _recentColors = <Color>[];
  List<Color> get recentColors => _recentColors;
  // ignore: use_setters_to_change_properties
  void setRecentColors(List<Color> colors) {
    _recentColors = colors;
  }

  // Helper ChangeNotifiers tucked into ThemeController because I'm lazy.
  // ===========================================================================
  // TODO(rydmike): Future app version, consider own inherited widget.

  // This is just a controller prop for hovered color on Colorscheme.
  Color? _hoverColor;
  Color? get hoverColor => _hoverColor;
  Future<void> setHoverColor(Color? value, [bool notify = true]) async {
    if (value == _hoverColor) return;
    _hoverColor = value;
    if (notify) notifyListeners();
  }

  // This is just a controller prop for hovered palette on Colorscheme.
  TonalPalettes? _hoverTonalPalette;
  TonalPalettes? get hoverTonalPalette => _hoverTonalPalette;
  Future<void> setHoverTonalPalette(
    TonalPalettes? value, [
    bool notify = true,
  ]) async {
    if (value == _hoverTonalPalette) return;
    _hoverTonalPalette = value;
    if (notify) notifyListeners();
  }
}
