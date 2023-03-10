import 'package:flutter/material.dart';

class CounterText extends StatelessWidget {
  const CounterText({
    super.key,
    required int counter,
  }) : _counter = counter;

  final int _counter;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
