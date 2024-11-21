part of 'incom_bloc.dart';

@immutable
sealed class IncomEvent {}

class IncomGet extends IncomEvent {}

class IncomAdd extends IncomEvent {
  IncomAdd({required this.incom});

  final Incom incom;
}

class IncomEdit extends IncomEvent {
  IncomEdit({required this.incom});

  final Incom incom;
}

class IncomDelete extends IncomEvent {
  IncomDelete({required this.incom});

  final Incom incom;
}
