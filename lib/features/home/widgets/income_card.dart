import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/my_fonts.dart';
import '../../../core/models/incom.dart';
import '../../../core/widgets/my_button.dart';

class IncomeCard extends StatelessWidget {
  const IncomeCard({
    super.key,
    required this.incom,
  });

  final Incom incom;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(
        bottom: 8,
        left: 22,
        right: 22,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff343434),
        borderRadius: BorderRadius.circular(12),
      ),
      child: MyButton(
        onPressed: () {
          context.push('/income_edit', extra: incom);
        },
        minSize: 42,
        child: Row(
          children: [
            SizedBox(
              width: 70,
              child: Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    incom.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: MyFonts.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Income',
                    style: TextStyle(
                      color: Color(0xff00AE9A),
                      fontSize: 8,
                      fontFamily: MyFonts.w400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '+ \$${incom.amount}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: MyFonts.w600,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
