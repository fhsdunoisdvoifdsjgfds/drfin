import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'btn_event.dart';
part 'btn_state.dart';

class BtnBloc extends Bloc<BtnEvent, BtnState> {
  BtnBloc() : super(BtnInitial()) {
    on<BtnEvent>(
      (event, emit) => switch (event) {
        CheckBtnActive() => _checkBtnActive(event, emit),
        DisableBtn() => _disableBtn(event, emit),
      },
    );
  }

  void _checkBtnActive(
    CheckBtnActive event,
    Emitter<BtnState> emit,
  ) {
    final isEmpty = event.controllers.any((controller) => controller.isEmpty);
    emit(isEmpty ? BtnInactive() : BtnInitial());
  }

  void _disableBtn(
    DisableBtn event,
    Emitter<BtnState> emit,
  ) {
    emit(BtnInactive());
  }
}
