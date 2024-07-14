import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showAlert(
    String message, {
    int duration = 2000,
  }) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(milliseconds: duration),
        ),
      );

  Future<T?> showBottomSheet<T>({
    required Widget child,
  }) =>
      showModalBottomSheet<T>(
        context: this,
        builder: (_) => child,
      );
}

SizedBox spacer(double height) {
  return SizedBox(
    height: height,
  );
}

/// Set of extension methods to easily display a snackbar
extension DisplaySnackBar on BuildContext {
  /// Displays a basic snackbar
  void displaySnackBar(
    String message, {
    Color? textColor,
    Color? backgroundColor,
    String? actionLabel,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: textColor == null ? null : TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      action: SnackBarAction(
        label: actionLabel ?? 'ok',
        onPressed: () {},
      ),
    ));
  }

  /// Displays a red snackbar indicating error
  void showErrorSnackBar(
    String message, {
    String? actionLabel,
  }) {
    displaySnackBar(
      message,
      textColor: Theme.of(this).colorScheme.onErrorContainer,
      backgroundColor: Theme.of(this).colorScheme.errorContainer,
      actionLabel: actionLabel,
    );
  }
}
