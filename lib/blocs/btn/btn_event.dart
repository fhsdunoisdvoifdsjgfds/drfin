part of 'btn_bloc.dart';

@immutable
sealed class BtnEvent {}

class CheckBtnActive extends BtnEvent {
  CheckBtnActive({required this.controllers});

  final List<String> controllers;
}

class DisableBtn extends BtnEvent {}
