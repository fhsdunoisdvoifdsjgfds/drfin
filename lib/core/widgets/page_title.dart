import 'package:flutter/material.dart';

import '../config/my_fonts.dart';

class PageTitle extends StatelessWidget {
  const PageTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 22),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: MyFonts.w600,
          ),
        ),
      ],
    );
  }
}
