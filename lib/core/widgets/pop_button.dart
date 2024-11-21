import 'package:flutter/material.dart';

import '../config/my_fonts.dart';
import 'my_button.dart';

class PopButton extends StatelessWidget {
  const PopButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: onPressed,
      minSize: 20,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontFamily: MyFonts.w300,
        ),
      ),
    );
  }
}
