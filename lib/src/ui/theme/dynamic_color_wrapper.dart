import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

/// This is taken from the generated output of the Material 3 color
/// generator.
///
///
class DynamicColorBuilderWrapper extends StatelessWidget {
  const DynamicColorBuilderWrapper(this.lightDynamic, this.darkDynamic,
      this.lightDefault, this.darkDefault, this.themedWidget);

  final Widget themedWidget; //"Home"
  final ColorScheme? lightDynamic;
  final ColorScheme? darkDynamic;
  final ColorScheme lightDefault;
  final ColorScheme darkDefault;

  @override
  Widget build(BuildContext context) {
    ColorScheme lightScheme;
    ColorScheme darkScheme;
    DynamicColorBuilder dcb;
    if (lightDynamic != null && darkDynamic != null) {
      lightScheme = lightDynamic!.harmonized();
      darkScheme = darkDynamic!.harmonized();
    } else {
      lightScheme = lightDefault;
      darkScheme = darkDefault;
    }

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightScheme,
        //extensions: [lightCustomColors],
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkScheme,
        //extensions: [darkCustomColors],
      ),
      home: themedWidget,
    );
  }
}
