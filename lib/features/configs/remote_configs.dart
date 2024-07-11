// import 'dart:async';

// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/foundation.dart';
// import 'package:rxdart/rxdart.dart';

// import 'default_configs.dart' as cfg;

abstract class ConfigKeys {
  static const String minVersion = 'minVersion';
  static const String latestVersion = 'latestVersion';
  static const String forceUpdate = 'forceUpdate';
  static const String popupRatingAfter = 'popupRatingAfter';
  static const String showMoveApp = 'showMoveApp';
  static const String hiddenFeatures = 'hiddenFeatures';

  static const String androidLink = 'androidLink';
  static const String iosLink = 'iosLink';
  static const String supportEmail = 'support.email';
  static const String supportFanpage = 'support.fanpage';
  static const String supportFanpageId = 'support.fanpageId';

  static const String domain = 'domain';
  static const String privacyPolicyUrl = 'privacyPolicyUrl';
  static const String termsConditionsUrl = 'termsConditionsUrl';
  static const String apiBaseUrl = 'apiBaseUrl';
  static const String mainOrigin = 'mainOrigin';
  static const String resourceOrigin = 'resourceOrigin';
  static const String webviewOrigin = 'webviewOrigin';
}
