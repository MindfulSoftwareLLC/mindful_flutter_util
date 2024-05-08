import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

Future<ui.Image> loadImage(String imagePath, VoidCallback callback) async {
  final ByteData data = await rootBundle.load(imagePath);
  Uint8List img = Uint8List.view(data.buffer);
  final Completer<ui.Image> completer = new Completer();
  ui.decodeImageFromList(img, (ui.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}

// void drawImage(String assetPath, Offset offset, Canvas canvas, Paint paint) {
//   final image = AssetImage(assetPath);
//
//   final imgWidth = image.width.toDouble();
//   final imgHeight = image.height.toDouble();
//
//   final srcRect = Rect.fromLTWH(0, 0, imgWidth, imgHeight);
//   final dstRect = Rect.fromPoints(
//     offset,
//     Offset(offset.dx + image.width, offset.dy + hatSize.height),
//   );
//
//   paintImage(
//     canvas: canvas,
//     rect: dstRect,
//     image: image,
//     fit: BoxFit.fill, // Adjust this fit mode as per your requirement
//     sourceRect: srcRect,
//     paint: paint,
//   );
// }
