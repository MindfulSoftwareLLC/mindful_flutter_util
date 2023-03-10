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
  final EventBusFunction<T> on;

  Type get eventType => T.runtimeType;

  @override
  State<StatefulWidget> createState() {
    return EventBusBuilderState();
  }
}

class EventBusBuilderState extends State<EventBusBuilder> {
  StreamSubscription? eventStream;

  @override
  void initState() {
    eventStream = EventBus.subscribe(widget.eventType, widget.on);
    super.initState();
  }

  @override
  void dispose() {
    if (eventStream != null) {
      eventStream!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
