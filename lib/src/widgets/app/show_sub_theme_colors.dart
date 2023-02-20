// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';

/// Draw a number of boxes showing the colors of key sub theme color properties
/// in the ColorScheme of the inherited ThemeData and its color properties.
///
/// This widget is just used so we can visually see the active scheme colors
/// in the examples and their used FlexColorScheme based themes.
///
/// These are all Flutter "Universal" Widgets that only depends on the SDK and
/// all the Widgets in this file be dropped into any application. They are
/// however not so generally reusable.
class ShowSubThemeColors extends StatelessWidget {
  const ShowSubThemeColors({
    super.key,
    this.onBackgroundColor,
    this.showSubtitle = true,
  });

  /// The color of the background the color widget are being drawn on.
  ///
  /// Some of the theme colors may have semi transparent fill color. To compute
  /// a legible text color for the sum when it shown on a background color, we
  /// need to alpha merge it with background and we need the exact background
  /// color it is drawn on for that. If not passed in from parent, it is
  /// assumed to be drawn on card color, which usually is close enough.
  final Color? onBackgroundColor;

  /// Show sub-title for the sub-theme colors
  final bool showSubtitle;

  // Return true if the color is light, meaning it needs dark text for contrast.
  static bool _isLight(final Color color) =>
      ThemeData.estimateBrightnessForColor(color) == Brightness.light;

  // On color used when a theme color property does not have a theme onColor.
  static Color _onColor(final Color color, final Color bg) =>
      _isLight(Color.alphaBlend(color, bg)) ? Colors.black : Colors.white;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final useMaterial3 = theme.useMaterial3;

    final media = MediaQuery.of(context);
    final isPhone = media.size.width < UIConst.phoneWidthBreakpoint ||
        media.size.height < UIConst.phoneHeightBreakpoint;
    final spacing = isPhone ? 3.0 : 6.0;

    // Get effective background color.
    final background =
        onBackgroundColor ?? theme.cardTheme.color ?? theme.cardColor;
    // Grab the card border from the theme card shape
    var border = theme.cardTheme.shape;
    // If we had one, copy in a border side to it.
    if (border is RoundedRectangleBorder) {
      border = border.copyWith(
        side: BorderSide(
          color: theme.dividerColor,
        ),
      );
      // If
    } else {
      // If border was null, make one matching Card default, but with border
      // side, if it was not null, we leave it as it was.
      border ??= RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(useMaterial3 ? 12 : 4)),
        side: BorderSide(
          color: theme.dividerColor,
        ),
      );
    }

    // Get the themed or default color of all shown components' colors.
    final elevatedButtonColor = theme.elevatedButtonTheme.style?.backgroundColor
            ?.resolve(<MaterialState>{}) ??
        colorScheme.primary;
    final outlinedButtonColor = theme.outlinedButtonTheme.style?.foregroundColor
            ?.resolve(<MaterialState>{}) ??
        colorScheme.primary;
    final textButtonColor = theme.textButtonTheme.style?.foregroundColor
            ?.resolve(<MaterialState>{}) ??
        colorScheme.primary;
    final toggleButtonsColor =
        theme.toggleButtonsTheme.color ?? colorScheme.primary;
    final floatingActionButtonColor =
        theme.floatingActionButtonTheme.backgroundColor ??
            (theme.useMaterial3
                ? colorScheme.primaryContainer
                : colorScheme.secondary);
    final switchColor = theme.switchTheme.thumbColor
            ?.resolve(<MaterialState>{MaterialState.selected}) ??
        theme.toggleableActiveColor;
    final checkboxColor = theme.checkboxTheme.fillColor
            ?.resolve(<MaterialState>{MaterialState.selected}) ??
        theme.toggleableActiveColor;
    final radioColor = theme.radioTheme.fillColor
            ?.resolve(<MaterialState>{MaterialState.selected}) ??
        theme.toggleableActiveColor;
    final circleAvatarColor =
        isDark ? theme.primaryColorLight : theme.primaryColorDark;
    final chipColor = theme.chipTheme.backgroundColor ?? colorScheme.primary;
    final inputDecoratorColor =
        theme.inputDecorationTheme.focusColor?.withAlpha(0xFF) ??
            colorScheme.primary;
    final tooltipDecoration = theme.tooltipTheme.decoration;
    final tooltipColor = tooltipDecoration is BoxDecoration
        ? tooltipDecoration.color ?? colorScheme.surface
        : colorScheme.surface;
    final appBarColor = theme.appBarTheme.backgroundColor ??
        (isDark ? colorScheme.surface : colorScheme.primary);
    final tabBarColor = theme.tabBarTheme.labelColor ??
        (isDark ? colorScheme.onSurface : colorScheme.onPrimary);
    final dialogColor =
        theme.dialogTheme.backgroundColor ?? theme.dialogBackgroundColor;
    final defaultSnackBackgroundColor = isDark
        ? colorScheme.onSurface
        : Color.alphaBlend(
            colorScheme.onSurface.withOpacity(0.80),
            colorScheme.surface,
          );
    final snackBarColor =
        theme.snackBarTheme.backgroundColor ?? defaultSnackBackgroundColor;
    final snackForeground = theme.snackBarTheme.contentTextStyle?.color ??
        (ThemeData.estimateBrightnessForColor(snackBarColor) == Brightness.light
            ? Colors.black
            : Colors.white);
    final bottomNavBarColor = theme.bottomNavigationBarTheme.backgroundColor ??
        colorScheme.background;
    final bottomNavBarItemColor =
        theme.bottomNavigationBarTheme.selectedItemColor ??
            (isDark ? colorScheme.secondary : colorScheme.primary);
    final navigationBarColor = theme.navigationBarTheme.backgroundColor ??
        (useMaterial3
            ? ElevationOverlay.colorWithOverlay(
                colorScheme.surface,
                colorScheme.primary,
                3,
              )
            : ElevationOverlay.colorWithOverlay(
                colorScheme.surface,
                colorScheme.onSurface,
                3,
              ));
    final navigationBarItemColor = theme.navigationBarTheme.iconTheme
            ?.resolve(<MaterialState>{MaterialState.selected})?.color ??
        (useMaterial3
            ? colorScheme.onSecondaryContainer
            : colorScheme.onSurface);
    final navigationBarIndicatorColor =
        theme.navigationBarTheme.indicatorColor ??
            (useMaterial3
                ? colorScheme.secondaryContainer
                : colorScheme.secondary.withOpacity(.24));
    final navigationRailColor =
        theme.navigationRailTheme.backgroundColor ?? colorScheme.surface;
    final navigationRailItemColor = theme
            .navigationRailTheme.selectedIconTheme?.color ??
        (useMaterial3 ? colorScheme.onSecondaryContainer : colorScheme.primary);
    final navigationRailIndicatorColor =
        theme.navigationRailTheme.indicatorColor ??
            (useMaterial3
                ? colorScheme.onSecondaryContainer
                : colorScheme.secondary.withOpacity(.24));
    final textColor = theme.textTheme.titleMedium?.color ??
        (isDark ? Colors.white : Colors.black);
    final primTextColor = theme.primaryTextTheme.titleMedium?.color ??
        (ThemeData.estimateBrightnessForColor(colorScheme.primary) ==
                Brightness.dark
            ? Colors.white
            : Colors.black);

    // Wrap this widget branch in a custom theme where card has a border outline
    // if it did not have one, but retains in ambient themed border radius.
    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: CardTheme.of(context).copyWith(
          elevation: 0,
          shape: border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Component Colors',
              style: theme.textTheme.titleMedium,
            ),
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: spacing,
            runSpacing: spacing,
            children: <Widget>[
              ColorCard(
                label: 'Elevated\nButton',
                color: elevatedButtonColor,
                textColor: _onColor(elevatedButtonColor, background),
              ),
              ColorCard(
                label: 'Outlined\nButton',
                color: outlinedButtonColor,
                textColor: _onColor(elevatedButtonColor, background),
              ),
              ColorCard(
                label: 'Text\nButton',
                color: textButtonColor,
                textColor: _onColor(textButtonColor, background),
              ),
              ColorCard(
                label: 'Toggle\nButtons',
                color: toggleButtonsColor,
                textColor: _onColor(toggleButtonsColor, background),
              ),
              ColorCard(
                label: 'Switch',
                color: switchColor,
                textColor: _onColor(switchColor, background),
              ),
              ColorCard(
                label: 'Checkbox',
                color: checkboxColor,
                textColor: _onColor(checkboxColor, background),
              ),
              ColorCard(
                label: 'Radio',
                color: radioColor,
                textColor: _onColor(radioColor, background),
              ),
              ColorCard(
                label: 'Floating\nAction\nButton',
                color: floatingActionButtonColor,
                textColor: _onColor(floatingActionButtonColor, background),
              ),
              ColorCard(
                label: 'Circle\nAvatar',
                color: circleAvatarColor,
                textColor: _onColor(circleAvatarColor, background),
              ),
              ColorCard(
                label: 'Chips',
                color: chipColor,
                textColor: _onColor(chipColor, background),
              ),
              ColorCard(
                label: 'Input\nDecorator',
                color: inputDecoratorColor,
                textColor: _onColor(inputDecoratorColor, background),
              ),
              ColorCard(
                label: 'Tooltip',
                color: tooltipColor,
                textColor: _onColor(tooltipColor, background),
              ),
              ColorCard(
                label: 'AppBar',
                color: appBarColor,
                textColor: _onColor(appBarColor, background),
              ),
              ColorCard(
                label: 'TabBar\nItem',
                color: tabBarColor,
                textColor: _onColor(tabBarColor, background),
              ),
              ColorCard(
                label: 'TabBar\nIndicator',
                color: theme.indicatorColor,
                textColor: _onColor(theme.indicatorColor, background),
              ),
              ColorCard(
                label: 'Dialog\nBackground',
                color: dialogColor,
                textColor: _onColor(dialogColor, background),
              ),
              ColorCard(
                label: 'SnackBar\nBackground',
                color: snackBarColor,
                textColor: snackForeground,
              ),
              ColorCard(
                label: 'Bottom\nNaviBar\nBackground',
                color: bottomNavBarColor,
                textColor: _onColor(bottomNavBarColor, background),
              ),
              ColorCard(
                label: 'Bottom\nNaviBar\nSelected',
                color: bottomNavBarItemColor,
                textColor: _onColor(bottomNavBarItemColor, background),
              ),
              ColorCard(
                label: 'Navigation\nBar\nBackground',
                color: navigationBarColor,
                textColor: _onColor(navigationBarColor, background),
              ),
              ColorCard(
                label: 'Navigation\nBar\nSelected',
                color: navigationBarItemColor,
                textColor: _onColor(navigationBarItemColor, background),
              ),
              ColorCard(
                label: 'Navigation\nBar\nIndicator',
                color: navigationBarIndicatorColor,
                textColor: _onColor(navigationBarIndicatorColor, background),
              ),
              ColorCard(
                label: 'Navigation\nRail\nBackground',
                color: navigationRailColor,
                textColor: _onColor(navigationRailColor, background),
              ),
              ColorCard(
                label: 'Navigation\nRail\nSelected',
                color: navigationRailItemColor,
                textColor: _onColor(navigationRailItemColor, background),
              ),
              ColorCard(
                label: 'Navigation\nRail\nIndicator',
                color: navigationRailIndicatorColor,
                textColor: _onColor(navigationRailIndicatorColor, background),
              ),
              ColorCard(
                label: 'Text\nTheme',
                color: textColor,
                textColor: _onColor(textColor, background),
              ),
              ColorCard(
                label: 'PrimaryText\nTheme',
                color: primTextColor,
                textColor: _onColor(primTextColor, background),
              ),
              ColorCard(
                label: 'Card',
                color: theme.cardColor,
                textColor: colorScheme.onSurface,
              ),
              ColorCard(
                label: 'Disabled\nColor',
                color: theme.disabledColor,
                textColor: _onColor(theme.disabledColor, background),
              ),
              ColorCard(
                label: 'Hover\nColor',
                color: theme.hoverColor,
                textColor: _onColor(theme.hoverColor, background),
              ),
              ColorCard(
                label: 'Focus\nColor',
                color: theme.focusColor,
                textColor: _onColor(theme.focusColor, background),
              ),
              ColorCard(
                label: 'Highlight\nColor',
                color: theme.highlightColor,
                textColor: _onColor(theme.highlightColor, background),
              ),
              ColorCard(
                label: 'Splash\nColor',
                color: theme.splashColor,
                textColor: _onColor(theme.splashColor, background),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
