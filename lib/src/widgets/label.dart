import 'package:flutter/cupertino.dart';

import '../../mindful_flutter_util.dart';

class Label extends StatelessWidget {
  const Label(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: formLabelStyle,
    );
  }
}
