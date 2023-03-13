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
    var theme = MindfulFlutterThemes.themes[0];
    StreamBuilder s;
    var themedApp = ThemedApp(
      title: 'Theme Changed Event Demo',
      lightTheme: theme.lightThemeDataFor(),
      darkTheme: theme.darkThemeDataFor(),
      useDynamicColor: true,
      child: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
    return FlutterBusBuilder<ThemeChangedEvent>(
        on: (event) {
          themedApp.setState(() {});
        },
        child: themedApp);
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
