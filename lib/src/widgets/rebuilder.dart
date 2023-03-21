import 'package:flutter/material.dart';

class RebuildController {
  final GlobalKey rebuildKey = GlobalKey();

  void rebuild() {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (rebuildKey.currentContext as Element).visitChildren(rebuild);
  }
}

/// Rebuilds a child widget
/// class MyApp extends StatelessWidget {
///   final RebuildController controller = RebuildController();
///
///   MyApp({Key? key}) : super(key: key);
///
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       home: RebuildWrapper(
///         controller: controller,
///         child: HomePage(
///           rebuildController: controller,
///         ),
///       ),
///     );
///   }
/// }
// on some button or pull to refresh
// rebuildController.rebuild
class Rebuilder extends StatelessWidget {
  final RebuildController controller;
  final Widget child;

  const Rebuilder({Key? key, required this.controller, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        key: controller.rebuildKey,
        child: child,
      );
}
