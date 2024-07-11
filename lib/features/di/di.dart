import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

final GetIt getIt = GetIt.instance;

// default
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
  includeMicroPackages: false,
  // externalPackageModulesBefore: [
  //   ExternalModule(AwesomePackageModule),
  //   ExternalModule(ThirdPartyMicroModule),
  // ],
  // externalPackageModulesAfter: [
  //   ExternalModule(CoolPackageModule),
  // ],
)
configInjector(GetIt getIt, {String? env, EnvironmentFilter? environmentFilter}) {
  return getIt.init(environmentFilter: environmentFilter, environment: env);
}
