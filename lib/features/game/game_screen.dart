import 'dart:ui';

import 'package:tsafer/features/game/game_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'number_patterns.dart';
import 'percentage_master.dart';
import 'quick_convert.dart';

class MathGame {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final String difficulty;
  final Widget gameScreen;

  const MathGame({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.difficulty,
    required this.gameScreen,
  });
}

class MathGamesPage extends StatelessWidget {
  MathGamesPage({super.key});

  final List<MathGame> mathGames = [
    MathGame(
      id: 'speed_calc',
      name: 'Speed Calculator',
      description:
          'Solve math problems as quickly as possible. Train your mental math skills!',
      icon: CupertinoIcons.timer,
      color: CupertinoColors.systemBlue,
      difficulty: 'Medium',
      gameScreen: const SpeedCalculatorGame(),
    ),
    MathGame(
      id: 'number_sequence',
      name: 'Number Patterns',
      description:
          'Find the missing number in sequences. Improve your logical thinking!',
      icon: CupertinoIcons.chart_bar_alt_fill,
      color: CupertinoColors.systemPurple,
      difficulty: 'Hard',
      gameScreen: const NumberPatternsGame(),
    ),
    MathGame(
      id: 'percentage_master',
      name: 'Percentage Master',
      description:
          'Calculate percentages quickly. Essential for finance and trading!',
      icon: CupertinoIcons.percent,
      color: CupertinoColors.systemGreen,
      difficulty: 'Easy',
      gameScreen: const PercentageMasterGame(),
    ),
    MathGame(
      id: 'currency_converter',
      name: 'Quick Convert',
      description:
          'Convert currencies in your head. Perfect for forex traders!',
      icon: CupertinoIcons.money_dollar_circle_fill,
      color: CupertinoColors.systemOrange,
      difficulty: 'Medium',
      gameScreen: const QuickConvertGame(),
    ),
  ];

  void _navigateToGame(BuildContext context, MathGame game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => game.gameScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        border: null,
        middle: Text(
          'Math Games',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final game = mathGames[index];
                    return _GameCard(
                      game: game,
                      onTap: () => _navigateToGame(context, game),
                    );
                  },
                  childCount: mathGames.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final MathGame game;
  final VoidCallback onTap;

  const _GameCard({
    required this.game,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              game.color.withOpacity(0.2),
              game.color.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: game.color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: game.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      game.icon,
                      color: game.color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    game.name,
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    game.description,
                    style: TextStyle(
                      color: CupertinoColors.white.withOpacity(0.7),
                      fontSize: 13,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color:
                          _getDifficultyColor(game.difficulty).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      game.difficulty,
                      style: TextStyle(
                        color: _getDifficultyColor(game.difficulty),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return CupertinoColors.systemGreen;
      case 'medium':
        return CupertinoColors.systemYellow;
      case 'hard':
        return CupertinoColors.systemRed;
      default:
        return CupertinoColors.systemGrey;
    }
  }
}
