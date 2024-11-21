import 'package:flutter/material.dart';

import '../../../core/config/my_fonts.dart';
import '../../../core/models/questionn.dart';
import '../../../core/widgets/my_button.dart';

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({
    super.key,
    required this.id,
    required this.answer,
    required this.current,
    required this.onPressed,
  });

  final int id;
  final Answer answer;
  final Answer current;
  final void Function(Answer) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff343434),
        borderRadius: BorderRadius.circular(14),
      ),
      child: MyButton(
        onPressed: () {
          onPressed(answer);
        },
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              '$id. ',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: MyFonts.w500,
              ),
            ),
            Expanded(
              child: Text(
                answer.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: MyFonts.w500,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: answer == current
                    ? const Color(0xffFEDB35)
                    : const Color(0xffB8BBBE),
              ),
            ),
            const SizedBox(width: 18),
          ],
        ),
      ),
    );
  }
}
