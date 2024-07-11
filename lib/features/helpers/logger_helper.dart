import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

void initLogger() {
  Logger.root.level = !kReleaseMode ? Level.ALL : Level.OFF; // Default is Level.INFO.
  Logger.root.onRecord.listen((record) {
    log(
      record.message,
      time: record.time,
      sequenceNumber: record.sequenceNumber,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });
}
