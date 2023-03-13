import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/src/event_bus/event_bus.dart';

class EventBusBuilder<T> extends StatefulWidget {
  EventBusBuilder({
    required this.child,
    required this.on,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final void Function(T) on;
  late StreamSubscription<T> eventStreamSubscription;
  //
  // Type get eventType => T.runtimeType;

  @override
  State<StatefulWidget> createState() {
    return EventBusBuilderState<T>();
  }
}

class EventBusBuilderState<T> extends State<EventBusBuilder> {
  @override
  void initState() {
    super.initState();
    widget.eventStreamSubscription = EventBus.on<T>(widget.on);
    // eventStreamSubscription.pause();
    // widget.eventStreamSubscription.resume();
  }

  @override
  void activate() {
    super.activate();
    widget.eventStreamSubscription.resume();
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.eventStreamSubscription.pause();
  }

  @override
  void dispose() {
    super.dispose();
    widget.eventStreamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
