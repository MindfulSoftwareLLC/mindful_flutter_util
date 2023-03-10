import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';

class IncrementCounterWidget extends StatelessWidget {
  const IncrementCounterWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: EventBus.fire(),
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    ),;
  }
}

