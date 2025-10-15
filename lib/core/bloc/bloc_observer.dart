import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/core.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onCreate(BlocBase bloc) {
    log('Bloc created: ${bloc.runtimeType}');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log('Event: ${event.runtimeType} in ${bloc.runtimeType}');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log('State changed in ${bloc.runtimeType}: '); // $change
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('\n');
    log('Error in ${bloc.runtimeType}: $error', stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
    log('\n');
  }

  @override
  void onClose(BlocBase bloc) {
    log('Bloc closed: ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
