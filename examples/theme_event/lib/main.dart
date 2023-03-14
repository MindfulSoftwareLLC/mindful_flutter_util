import 'package:flutter/material.dart';
import 'package:flutter_bus/flutter_bus.dart';
import 'package:mindful_flutter_themes/mindful_flutter_themes.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var defaultTheme = MindfulFlutterThemes.themes[0];
    return FlutterBusBuilder<ThemeChangedEvent>(
      initialData: ThemeChangedEvent(
          defaultTheme.lightThemeDataFor(), defaultTheme.darkThemeDataFor()),
      builder: (context, themeEvent) {
        return ThemedApp(
          title: 'Theme Changed Event Demo',
          //Events are never null if initialData is set
          //FlutterBus does not publish null and the non-builder
          //API does not allow nulls. The only null is for initialData.
          lightTheme: themeEvent!.lightTheme,
          darkTheme: themeEvent.darkTheme,
          useDynamicColor: true,
          child: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
