import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavInitial()) {
    on<NavEvent>(
      (event, emit) => switch (event) {
        ChangeNav() => _changePage(event, emit),
      },
    );
  }

  void _changePage(
    ChangeNav event,
    Emitter<NavState> emit,
  ) {
    if (event.index == 1) emit(NavInitial());
    if (event.index == 2) emit(NavIncome());
    if (event.index == 3) emit(NavNews());
    if (event.index == 4) emit(NavQuiz());
  }
}
