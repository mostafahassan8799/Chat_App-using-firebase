import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    print(transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    print(change);
  }
}
