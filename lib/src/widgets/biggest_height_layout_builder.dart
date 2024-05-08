import 'package:flutter/cupertino.dart';

class GridHeightLayoutBuilder extends StatelessWidget {
  final Widget child;

  const GridHeightLayoutBuilder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (content, BoxConstraints boxConstraints) {
      return ConstrainedBox(
          //height: 700, /*boxConstraints.biggest.height,*/
          constraints: BoxConstraints.expand(),
          child: child);
    });
  }
}
