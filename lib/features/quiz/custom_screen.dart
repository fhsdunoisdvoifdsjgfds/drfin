import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tsafer/core/models/questionn.dart';
import 'package:tsafer/features/quiz/pages/quiz_page.dart';
import 'package:flutter/cupertino.dart';

import 'custom_data_widget.dart';

class QuizCategory {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final List<Questionn> questions;

  const QuizCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.questions,
  });
}

class QuizCategoriesPage extends StatefulWidget {
  const QuizCategoriesPage({super.key});

  @override
  State<QuizCategoriesPage> createState() => _QuizCategoriesPageState();
}

class BlocScreen extends StatefulWidget {
  final String blocer;
  final String providder;

  BlocScreen({
    required this.blocer,
    required this.providder,
  });

  @override
  State<BlocScreen> createState() => _BlocScreenState();
}

class _BlocScreenState extends State<BlocScreen> {
  @override
  Widget build(BuildContext context) {
    final xx = '${widget.blocer}&external_Id=${widget.providder}';
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(xx),
          ),
        ),
      ),
    );
  }
}

class _QuizCategoriesPageState extends State<QuizCategoriesPage> {
  final List<QuizCategory> categories = [
    QuizCategory(
      id: 'investing',
      name: 'Investing',
      description:
          'Test your knowledge about stocks, bonds, and investment strategies',
      icon: CupertinoIcons.chart_bar_fill,
      color: CupertinoColors.systemBlue,
      questions: investingQuestions,
    ),
    QuizCategory(
      id: 'crypto',
      name: 'Cryptocurrency',
      description: 'Learn about blockchain, crypto trading, and digital assets',
      icon: CupertinoIcons.bitcoin_circle_fill,
      color: CupertinoColors.systemOrange,
      questions: cryptoQuestions,
    ),
    QuizCategory(
      id: 'personal',
      name: 'Personal Finance',
      description: 'Budgeting, saving, and managing personal wealth',
      icon: CupertinoIcons.money_dollar_circle_fill,
      color: CupertinoColors.systemGreen,
      questions: personalFinanceQuestions,
    ),
    QuizCategory(
      id: 'trading',
      name: 'Trading',
      description: 'Master technical analysis and trading strategies',
      icon: CupertinoIcons.graph_circle_fill,
      color: CupertinoColors.systemPurple,
      questions: tradingQuestions,
    ),
  ];

  void _navigateToQuiz(QuizCategory category) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 0),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => QuizPage(
          questions: category.questions,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var slideTween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(slideTween);

          var fadeTween = Tween<double>(begin: 0.0, end: 1.0);
          var fadeAnimation = animation.drive(fadeTween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ),
          );
        },
        opaque: true,
        barrierDismissible: false,
      ),
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
          'Quiz',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Choose a category to start the quiz',
                    style: TextStyle(
                      color: CupertinoColors.white.withOpacity(0.6),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _CategoryCard(
                    category: category,
                    onTap: () => _navigateToQuiz(category),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final QuizCategory category;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              category.color.withOpacity(0.2),
              category.color.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: category.color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: CupertinoColors.black.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: category.color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          category.icon,
                          color: category.color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.name,
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: category.color,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    category.description,
                    style: TextStyle(
                      color: CupertinoColors.white.withOpacity(0.8),
                      fontSize: 14,
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
}
