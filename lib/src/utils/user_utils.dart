import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;

import 'device_utils.dart';
import 'geo_utils.dart';

/// All the data we can get about the user, device, session, location...
/// conveniently in storable JSON
/// Call this once, asynchronously on startup, and cache the result.
Future<Map<String, dynamic>> getUserMetaData() async {
  Map<String, dynamic> deviceInfo = await getDeviceInfo();
  Map<String, double> locationInfo = await getGeoInfo();

  Map<String, dynamic> result = {
    'device': deviceInfo,
    'location': locationInfo,
    // Add other metadata fields as needed
  };
  return result;
}
