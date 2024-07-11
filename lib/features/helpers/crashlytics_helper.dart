import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

Logger? _logger;
setCrashlyticsLogger(Logger? logger) {
  _logger = logger;
}

Future<void> initCrashlytics({
  Logger? logger,
  @visibleForTesting bool kTestingCrashlytics = false,
  @visibleForTesting bool kShouldTestAsyncErrorOnInit = false,
  CanCrashlytics canCrashlytics = defaultCanCrashlytics,
}) async {
  if (logger != null) {
    setCrashlyticsLogger(logger);
  }
  if (kTestingCrashlytics) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
  }

  if (kShouldTestAsyncErrorOnInit) FirebaseCrashlytics.instance.crash();

  FlutterError.onError = (FlutterErrorDetails details) {
    _logger?.shout('FlutterError.onError', details.exception, details.stack);

    if (!kReleaseMode) return;

    final exception = details.exception;
    final canSend = canCrashlytics(exception);
    if (!canSend) return;

    FirebaseCrashlytics.instance.recordFlutterError(details);
    // await Sentry.captureException(exception, stackTrace: stackTrace);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    recordError(error, stack, canCrashlytics: canCrashlytics);
    return true;
  };

  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    recordError(errorAndStacktrace.first, errorAndStacktrace.last, canCrashlytics: canCrashlytics);
  }).sendPort);
}

typedef CanCrashlytics = bool Function(dynamic exception);
bool defaultCanCrashlytics(dynamic exception) {
  /// TODO: remove if flutter fix. Hotfix remove record error SelectionArea https://github.com/flutter/flutter/issues/115787
  if (exception is AssertionError) {
    final String message;
    if (exception.message is String) {
      message = exception.message as String;
    } else {
      message = exception.toString();
    }

    if (message.contains('_selectionStartsInScrollable') ||
        message.contains('SelectionContainerState') ||
        message.contains('SelectableRegionState')) {
      return false;
    }
  } else if (exception is FlutterError) {
    /// Hotfix remove record error AdWidget render multiple times
    final String message = exception.message;
    if (message.contains('This AdWidget is already in the Widget tree')) {
      return false;
    }
  }
  return true;
}

void recordError(
  dynamic exception,
  StackTrace? stack, {
  dynamic reason,
  Iterable<DiagnosticsNode> information = const [],
  bool? printDetails,
  bool fatal = false,
  CanCrashlytics canCrashlytics = defaultCanCrashlytics,
}) {
  _logger?.shout('recordError', exception, stack);

  if (!kReleaseMode) return;

  final canSend = canCrashlytics(exception);
  if (!canSend) return;

  FirebaseCrashlytics.instance.recordError(exception, stack, reason: reason, information: information, printDetails: printDetails, fatal: fatal);
  // await Sentry.captureException(exception, stackTrace: stackTrace);
}

void recordFatalError(
  dynamic exception,
  StackTrace? stack, {
  dynamic reason,
  Iterable<DiagnosticsNode> information = const [],
  bool? printDetails,
  bool fatal = true,
  CanCrashlytics canCrashlytics = defaultCanCrashlytics,
}) {
  _logger?.shout('recordFatalError', exception, stack);

  if (!kReleaseMode) return;

  final canSend = canCrashlytics(exception);
  if (!canSend) return;

  FirebaseCrashlytics.instance.recordError(exception, stack, reason: reason, information: information, printDetails: printDetails, fatal: fatal);
  // await Sentry.captureException(exception, stackTrace: stackTrace);
}
