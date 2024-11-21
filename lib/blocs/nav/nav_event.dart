part of 'nav_bloc.dart';

@immutable
sealed class NavEvent {}

class ChangeNav extends NavEvent {
  ChangeNav({required this.index});

  final int index;
}
