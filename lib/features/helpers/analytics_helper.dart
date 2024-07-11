import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

Future<FirebaseAnalyticsObserver?> initAnalytics({bool createObserver = true, @visibleForTesting bool kTestingAnalytics = false}) async {
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(kTestingAnalytics || !kDebugMode);
  if (createObserver) return FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
  return null;
}
