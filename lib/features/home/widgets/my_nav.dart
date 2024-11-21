import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/my_fonts.dart';
import '../../../core/utilsss.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/my_button.dart';
import '../../../blocs/nav/nav_bloc.dart';

class MyNav extends StatelessWidget {
  const MyNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 62 + getBot(context),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xff181818),
        ),
        child: BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _NavBarButton(
                  index: 1,
                  title: 'Home',
                  active: state is NavInitial,
                ),
                _NavBarButton(
                  index: 2,
                  title: 'Income',
                  active: state is NavIncome,
                ),
                _NavBarButton(
                  index: 3,
                  title: 'News',
                  active: state is NavNews,
                ),
                _NavBarButton(
                  index: 4,
                  title: 'Quiz',
                  active: state is NavQuiz,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    required this.index,
    required this.title,
    required this.active,
  });

  final int index;
  final String title;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: active
          ? null
          : () {
              context.read<NavBloc>().add(ChangeNav(index: index));
            },
      padding: 0,
      child: SizedBox(
        width: 62,
        child: Column(
          children: [
            const SizedBox(height: 14),
            SizedBox(
              height: 25,
              child: SVGWidgett(
                index == 2 && active
                    ? 'assets/tab5.svg'
                    : 'assets/tab$index.svg',
                color: active ? const Color(0xffFEDB35) : Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: active ? const Color(0xffFEDB35) : Colors.white,
                fontSize: 10,
                fontFamily: MyFonts.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
