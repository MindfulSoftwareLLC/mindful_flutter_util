import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;

Future<Map<String, dynamic>> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  var deviceData = <String, dynamic>{};

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceData = androidInfo.data;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceData = iosInfo.data;
  } else if (Platform.isLinux) {
    LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
    deviceData = linuxInfo.data;
  } else if (Platform.isWindows) {
    WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
    deviceData = windowsInfo.data;
  } else if (Platform.isMacOS) {
    MacOsDeviceInfo macInfo = await deviceInfo.macOsInfo;
    deviceData = macInfo.data;
    // } else if (Platform.isFuchsia) {
    //   // Fuchsia is not commonly supported by many packages, and device_info_plus does not support it as of now.
    //   deviceData = {
    //     'deviceType': 'Fuchsia',
    //   };
  } else {
    // Web or other platforms
    WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
    deviceData = webInfo.data;
  }

  return deviceData;
}
