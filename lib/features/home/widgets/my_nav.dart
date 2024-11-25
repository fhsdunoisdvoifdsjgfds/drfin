import 'package:tsafer/blocs/nav/nav_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xff181818),
        ),
        child: BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavigationButton(
                  index: 1,
                  icon: CupertinoIcons.house_fill,
                  title: 'Home',
                  active: state is NavInitial,
                ),
                _NavigationButton(
                  index: 2,
                  icon: CupertinoIcons.arrow_right_arrow_left_circle_fill,
                  title: 'Income',
                  active: state is NavIncome,
                ),
                _NavigationButton(
                  index: 3,
                  icon: CupertinoIcons.news_solid,
                  title: 'News',
                  active: state is NavNews,
                ),
                _NavigationButton(
                  index: 4,
                  icon: CupertinoIcons.game_controller_solid,
                  title: 'Games',
                  active: state is NavGames,
                ),
                _NavigationButton(
                  index: 5,
                  icon: CupertinoIcons.question_circle_fill,
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

class _NavigationButton extends StatelessWidget {
  const _NavigationButton({
    required this.index,
    required this.icon,
    required this.title,
    required this.active,
  });

  final int index;
  final IconData icon;
  final String title;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: active
          ? null
          : () {
              context.read<NavBloc>().add(ChangeNav(index: index));
            },
      child: Container(
        width: 65,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: active ? 1.2 : 1.0),
              duration: const Duration(milliseconds: 200),
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xffFEDB35).withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: active ? const Color(0xffFEDB35) : Colors.white,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 4),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: active ? 1.1 : 1.0),
              duration: const Duration(milliseconds: 200),
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: Text(
                title,
                style: TextStyle(
                  color: active ? const Color(0xffFEDB35) : Colors.white,
                  fontSize: 11,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
