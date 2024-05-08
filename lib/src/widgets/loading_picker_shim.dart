import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class LoadingPickerShim extends StatelessWidget {
  final double height;

  const LoadingPickerShim({super.key, this.height = 100});

  @override
  Widget build(BuildContext context) {
    return CardLoading(
      height: height,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}
