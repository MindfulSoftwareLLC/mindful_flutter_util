import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'dart:io' show Platform;

import 'device_utils.dart';
import 'geo_utils.dart';

/// All the data we can get about the user, device, session, location...
/// conveniently in storable JSON
/// Call this once, asynchronously on startup, and cache the result.
Future<Map<String, dynamic>> getUserMetaData() async {
  Map<String, dynamic> result = {};
  try {
    result['deviceInfo'] = await getDeviceInfo();
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
  try {
    result['locationInfo'] = await getGeoInfo();
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  }
  return result;
}
