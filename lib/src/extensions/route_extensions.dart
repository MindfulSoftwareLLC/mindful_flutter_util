import 'package:flutter/material.dart';

extension RouteExtensions on BuildContext {
  void popResult<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

  Future<T?> pushWidget<T extends Object?>(Widget widget) {
    return Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Widget widget, {
    TO? result,
  }) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      result: result,
    );
  }
}
