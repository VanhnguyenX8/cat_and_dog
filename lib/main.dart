import 'dart:async';

import 'package:cat_and_dog/features/ads/manager/ads_banner_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'app/app.dart';
import 'app/app_bloc_observer.dart';
import 'firebase_options.dart';

import 'features/features.dart';

void main() async {
  final logger = Logger('main');
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // await initSpineFlutter(enableMemoryDebugging: false);
      initLogger();
      // unawaited(MobileAds.instance.initialize());
      AdManager().initialize();
      //// START: firebase
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      final FirebaseAnalyticsObserver? observer;
      if (kDebugMode) {
        // ignore: invalid_use_of_visible_for_testing_member
        await initCrashlytics(logger: logger, kTestingCrashlytics: kTestingCrashlytics, kShouldTestAsyncErrorOnInit: kShouldTestAsyncErrorOnInit);
        // ignore: invalid_use_of_visible_for_testing_member
        observer = await initAnalytics(kTestingAnalytics: kTestingAnalytics);
      } else {
        await initCrashlytics();
        observer = await initAnalytics();
      }
      if (observer != null) getIt.registerLazySingleton(() => observer!);
      //// END: firebase

      if (kShouldBlocObserver) Bloc.observer = AppBlocObserver();

      await configInjector(GetIt.I);
      final client = getIt.get<Dio>();

      //// START: config cache api
      CacheStore cacheStore;
      CacheOptions cacheOptions;
      if (kDebugMode) {
        cacheStore = MemCacheStore();
      } else if (kIsWeb) {
        cacheStore = MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576);
      } else {
        final databaseDir = await getTemporaryDirectory();
        cacheStore = DbCacheStore(databasePath: p.join(databaseDir.path, 'databases'), databaseName: 'cache', logStatements: true);
      }
      cacheOptions = CacheOptions(store: cacheStore, hitCacheOnErrorExcept: [401, 403]);
      client.interceptors.add(DioCacheInterceptor(options: cacheOptions));
      //// START: config api logger and X509 and http adapter
      if (kDebugMode) {
        // HttpOverrides.global = MyHttpOverrides();
        client.interceptors.add(LogInterceptor(logPrint: Logger('Api').info, responseHeader: false));
        if (!kIsWeb) {
          if (client.httpClientAdapter is IOHttpClientAdapter) {
            (client.httpClientAdapter as IOHttpClientAdapter).validateCertificate = (certificate, String host, int port) => true;
          }
        }
      }
      runApp(const App());
    },
    recordError,
  );
}
