/// Much is courtesy marcojakob/dart-event-bus
import 'dart:async';

typedef EventBusFunction<T> = void Function(T);
//void Function<T>(T) sub;

/// A universal EventBus pub/sub for Flutter Apps.
/// Use like so
/// EventBus.on<Foo>(foo -> print(foo));
/// EventBus.fire(Foo());
///
class EventBus {
  static StreamController _streamController =
      StreamController.broadcast(sync: false);

  /// Fires a new event on the event bus with the specified [event].
  static void publish(event) {
    _streamController.add(event);
  }

  /// Listens for events of Type [T] and its subtypes.
  ///
  /// The method is called like this:
  /// EventBus.on<MyType>((myInstance) -> print(myInstance));
  ///
  /// To listen to all events, call this method without a type parameter.
  ///
  /// The returned [StreamSubscription] must be used to unsubscribe when
  /// appropriate.
  ///
  /// Each listener is handled independently, and if they pause, only the pausing
  /// listener is affected. A paused listener will buffer events internally until
  /// unpaused or canceled. So it's usually better to just cancel and later
  /// subscribe again (avoids memory leak).
  static StreamSubscription<T> on<T>(void on(T event)) {
    final Stream<T> stream;
    if (T == dynamic) {
      stream = _streamController.stream as Stream<T>;
      stream;
    } else {
      stream = _streamController.stream.where((event) => event is T).cast<T>();
    }
    return stream.listen(on);
  }

  /// Subscribes to a type known at runtime
  static StreamSubscription? subscribe(Type eventType, void on(dynamic event)) {
    return _streamController.stream
        .where((event) => event.runtimeType == eventType)
        .listen(on);
  }

  /// Destroy this [EventBus]. This is generally only in a testing context.
  static void destroy() {
    _streamController.close();
  }
}
