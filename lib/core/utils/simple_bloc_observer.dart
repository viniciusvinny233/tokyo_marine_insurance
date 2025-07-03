import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      debugPrint('--- EVENTO ---\n${bloc.runtimeType}: $event');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      debugPrint('--- MUDANÇA ---\n${bloc.runtimeType}: \nCURRENT: ${change.currentState}\nNEXT: ${change.nextState}');
    }
  }
}
