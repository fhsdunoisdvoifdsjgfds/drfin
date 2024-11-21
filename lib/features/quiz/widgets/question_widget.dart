import 'package:flutter/material.dart';

import '../../../core/config/my_fonts.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.question,
  });

  final String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 222,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 4,
          color: Colors.white,
        ),
      ),
      child: Center(
        child: Text(
          question,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: MyFonts.w800,
          ),
        ),
      ),
    );
  }
}
