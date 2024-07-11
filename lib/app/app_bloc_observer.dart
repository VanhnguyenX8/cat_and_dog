import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class AppBlocObserver extends BlocObserver {
  static final logger = Logger('AppBlocObserver');

  @override
  void onTransition(Bloc bloc, Transition transition) {
    logger.info('onTransition -- (${bloc.runtimeType}, $transition)');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.info('onError -- (${bloc.runtimeType}, $error, $stackTrace)');
  }

  // @override
  // void onCreate(BlocBase bloc) {
  //   super.onCreate(bloc);
  //   log('onCreate -- (${bloc.runtimeType})');
  // }

  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   super.onEvent(bloc, event);
  //   log('onEvent -- (${bloc.runtimeType}, $event)');
  // }

  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   super.onChange(bloc, change);
  //   log('onChange -- (${bloc.runtimeType}, $change)');
  // }

  // @override
  // void onClose(BlocBase bloc) {
  //   super.onClose(bloc);
  //   log('onClose -- (${bloc.runtimeType})');
  // }
}
