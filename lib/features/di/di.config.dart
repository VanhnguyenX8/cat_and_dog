// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import '../cats/cats.dart' as _i5;
import '../dogs/dogs.dart' as _i6;
import '../repo/storage_repo.dart' as _i7;
import 'common_module.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final commonModule = _$CommonModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => commonModule.prefs(),
      preResolve: true,
    );
    gh.singleton<_i4.Dio>(
      () => commonModule.dio(),
      signalsReady: true,
    );
    gh.singleton<_i5.CatRepo>(() => commonModule.catRepo());
    gh.singleton<_i6.DogRepo>(() => commonModule.dogRepo());
    gh.singleton<_i7.StorageRepo>(() => commonModule.storageRepo());
    return this;
  }
}

class _$CommonModule extends _i8.CommonModule {}
