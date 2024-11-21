import 'package:flutter/cupertino.dart';

import '../config/dark_theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.onPressed,
    this.minSize = kMinInteractiveDimensionCupertino,
    this.padding = 0,
    required this.child,
  });

  final double minSize;
  final double padding;
  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: cupertinoTheme,
      child: CupertinoButton(
        padding: EdgeInsets.all(padding),
        minSize: minSize,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
