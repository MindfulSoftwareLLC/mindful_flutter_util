import 'package:counter/counter_increment_event.dart';
import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';

/// This button shows an Add icon and the text Increment and
/// when clicked, publishes a CounterIncrementEvent on the EventBus.
class CounterIncrementEventButton extends StatelessWidget {
  const CounterIncrementEventButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => EventBus.publish(CounterIncrementEvent()),
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
