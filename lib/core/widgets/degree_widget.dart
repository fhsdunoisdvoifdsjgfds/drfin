import 'package:flutter/material.dart';

class DegreeWidget extends StatelessWidget {
  const DegreeWidget({
    super.key,
    required this.degree,
    required this.child,
  });

  final int degree;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(degree / 360),
      child: child,
    );
  }
}
