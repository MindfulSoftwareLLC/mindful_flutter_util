import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';
import 'package:mindful_flutter_util/src/theme_selection/theme_controller.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
// Home Page for EXAMPLE 3 - Four Themes
//
// The content of the HomePage below is not relevant for using FlexColorScheme
// based application theming. The critical parts are in the MaterialApp
// theme definitions. The HomePage contains UI to visually show what the
// defined example looks like in an application and with commonly used Widgets.
// -----------------------------------------------------------------------------
class ThemePage extends StatefulWidget {
  @override
  State<ThemePage> createState() => _ThemeIndexState();
}

class _ThemeIndexState extends State<ThemePage> {
  // const ThemeSelectPage({
  @override
  Widget build(BuildContext context) {
    final margins = UIConst.responsiveInsets(MediaQuery.of(context).size.width);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final headlineMedium = textTheme.headlineMedium!;

    // final flexSchemeData = context.watch<ThemeController>();

    final controller = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Theme",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: PageBody(
        constraints: const BoxConstraints(maxWidth: UIConst.maxBodyWidth),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(margins),
          children: <Widget>[
            // const Text(
            //   'FlexColorScheme example 3 shows how to use three built-in '
            //   'color schemes, plus one custom color scheme as selectable '
            //   'themes in an application.\n'
            //   'The example uses primary color alpha blended surface colors. '
            //   'Widget component theming is ON. You can '
            //   'turn it OFF to use default widget themes. '
            //   'Key color generated ColorSchemes can be enabled.\n'
            //   'A theme showcase displays the resulting theme using '
            //   'common Material widgets. Settings are persisted.',
            // ),
            Text(
              "Theme Mode",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: margins,
                  horizontal: margins + 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // A 3-way theme mode toggle switch that shows the scheme.
                    ButtonSplash(
                        onTap: () {
                          controller.setThemeMode(ThemeMode.system);
                        },
                        borderRadius: 8,
                        splashColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Radio<ThemeMode>(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  focusColor: MaterialStateColor.resolveWith(
                                      (states) => Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  value: ThemeMode.system,
                                  groupValue: controller.themeMode,
                                  onChanged: (ThemeMode? value) {
                                    // setState(() {
                                    //  controller.themeMode = value!;
                                    // });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("system"),
                              ],
                            ))),
                    ButtonSplash(
                        onTap: () {
                          controller.setThemeMode(ThemeMode.light);
                        },
                        borderRadius: 8,
                        splashColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Radio<ThemeMode>(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  focusColor: MaterialStateColor.resolveWith(
                                      (states) => Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  value: ThemeMode.light,
                                  groupValue: controller.themeMode,
                                  onChanged: (ThemeMode? value) {
                                    // setState(() {
                                    //  controller.themeMode = value!;
                                    // });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("light"),
                              ],
                            ))),

                    ButtonSplash(
                        onTap: () {
                          controller.setThemeMode(ThemeMode.dark);
                        },
                        borderRadius: 8,
                        splashColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Radio<ThemeMode>(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  focusColor: MaterialStateColor.resolveWith(
                                      (states) => Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  value: ThemeMode.dark,
                                  groupValue: controller.themeMode,
                                  onChanged: (ThemeMode? value) {
                                    // setState(() {
                                    //  controller.themeMode = value!;
                                    // });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("dark"),
                              ],
                            )))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Color Mode",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            // The content is wrapped in a card so we can see the
            // theme's surface blend impact better via the Card widget.
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: margins,
                  horizontal: margins + 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // A 3-way theme mode toggle switch that shows the scheme.

                    ThemeSelectButtons(
                      scheme: controller.usedScheme,
                      onChanged: controller.setUsedScheme,
                    ),
                  ],
                ),
              ),
            ),

            // ThemeSelectButtons(
            //             scheme: controller.usedScheme,
            //             onChanged: controller.setUsedScheme,
            //           ),
          ],
        ),
      ),
    );
  }
}
