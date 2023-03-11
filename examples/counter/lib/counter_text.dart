import 'dart:async';

import 'package:counter/counter_increment_event.dart';
import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';

class CounterText extends StatefulWidget {
  const CounterText({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return CounterTextState();
  }
}

class CounterTextState extends State<CounterText> {
  /// State is be better put in a service/riverpod, etc.,
  /// This is just a simple example. A real app would update the state
  /// from the click event and then send another event that
  /// the state was updated.
  int _counter = 0;

  /// Keep your subscription to cancel and avoid leaks.
  late StreamSubscription _subscription;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _subscription =
        EventBus.on<CounterIncrementEvent>((event) => _incrementCounter());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
