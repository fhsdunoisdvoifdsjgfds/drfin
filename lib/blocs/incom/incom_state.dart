part of 'incom_bloc.dart';

@immutable
sealed class IncomState {}

final class IncomInitial extends IncomState {}

final class IncomLoaded extends IncomState {
  IncomLoaded({required this.incoms});

  final List<Incom> incoms;
}

final class IncomLoading extends IncomState {}
