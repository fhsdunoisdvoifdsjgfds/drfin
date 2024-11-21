part of 'btn_bloc.dart';

@immutable
sealed class BtnState {}

final class BtnInitial extends BtnState {}

final class BtnInactive extends BtnState {}
