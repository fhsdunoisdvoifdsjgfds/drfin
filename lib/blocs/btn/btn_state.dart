part of 'btn_bloc.dart';

@immutable
abstract class BtnState {}

class BtnInitial extends BtnState {}

class BtnActive extends BtnState {}

class BtnInactive extends BtnState {}
