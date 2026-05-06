// import 'dart:developer';

// import 'package:dottimo_franchise_app/core/utils/auth.dart';
// import 'package:flutter/material.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'dart:convert'; // For utf8.encode
// import 'package:crypto/crypto.dart';

// abstract class FingerprintGeneratorService {
//   // Function to generate a unique fingerprint
//   static Future<void> generateUniqueFingerprint() async {
//     // Step 1: Gather various device/browser data

//     // User-Agent (Flutter doesn't have direct access to User-Agent, so we'll omit it or use a custom string)
//     final String userAgent = "dottimo-franchise";

//     // Timezone
//     // final String timeZone = DateTime.now().timeZoneName;

//     // Screen resolution (height x width)
//     final String screenResolution =
//         "${MediaQueryData.fromView(WidgetsBinding.instance.window).size.height}x${MediaQueryData.fromView(WidgetsBinding.instance.window).size.width}";

//     // Language
//     final String language = WidgetsBinding.instance.window.locale.languageCode;

//     // Device Info
//     final deviceInfo = DeviceInfoPlugin();
//     final deviceData = await deviceInfo.deviceInfo;

//     String deviceDetails = '';
//     String androidId = '';

//     if (deviceData is AndroidDeviceInfo) {
//       deviceDetails = deviceData.model; // Get Android model
//       androidId = deviceData.id; // Get Android ID
//     } else if (deviceData is IosDeviceInfo) {
//       deviceDetails = deviceData.utsname.machine; // Get iOS model
//     }

//     // Collect fingerprint data (Include androidId for Android)
//     final dynamicData =
//         "$userAgent|$screenResolution|$language|$deviceDetails|$androidId";

//     final bytes = utf8.encode(dynamicData); // Convert the string to bytes
//     final fingerPrint = sha256
//         .convert(bytes)
//         .toString(); // Hash the data with SHA-256

//     log("FINGERPRINT ID : $fingerPrint");

//     Auth.fingerPrintId = fingerPrint;
//   }
// }
