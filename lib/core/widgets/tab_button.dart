import 'package:flutter/material.dart';

import '../config/my_fonts.dart';
import 'my_button.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    super.key,
    required this.title,
    required this.current,
    required this.onPressed,
  });

  final String title;
  final String current;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(right: 1),
      decoration: BoxDecoration(
        color: title == current
            ? const Color(0xffFEDB35)
            : const Color(0xff343434),
        borderRadius: BorderRadius.circular(36),
      ),
      child: MyButton(
        onPressed: () {
          onPressed(title);
        },
        minSize: 36,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: title == current ? Colors.black : Colors.white,
              fontSize: 15,
              fontFamily: MyFonts.w500,
            ),
          ),
        ),
      ),
    );
  }
}
