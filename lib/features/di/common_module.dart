import 'package:cat_and_dog/features/cats/cats.dart';
import 'package:cat_and_dog/features/dogs/dogs.dart';
import 'package:cat_and_dog/features/repo/storage_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features.dart';

@module
abstract class CommonModule {
  // @Singleton(signalsReady: true)
  // AppDatabase appDatabase() => AppDatabase(dbName: dbName);

  @preResolve
  Future<SharedPreferences> prefs() async => SharedPreferences.getInstance();

  @Singleton(signalsReady: true)
  Dio dio() => Dio(
        BaseOptions(
          baseUrl: apiBaseUrl,
          sendTimeout: const Duration(seconds: sendTimeout),
          receiveTimeout: const Duration(seconds: recieveTimeout),
          connectTimeout: const Duration(seconds: connectTimeout),
          validateStatus: (int? status) {
            return (status != null && status >= 200 && status < 300) || status == 304;
          },
        ),
      );
  @singleton
  CatRepo catRepo() => CatRepo();

  @singleton
  DogRepo dogRepo() => DogRepo();
  
  @singleton
  StorageRepo storageRepo() => StorageRepoIpml();
}
