import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsafer/core/models/questionn.dart';

class QuizResultsPage extends StatelessWidget {
  final List<Questionn> questions;
  final List<String> userAnswers;

  const QuizResultsPage({
    super.key,
    required this.questions,
    required this.userAnswers,
  });

  int get correctAnswers {
    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      final correctAnswer =
          questions[i].answers.firstWhere((answer) => answer.isCorrect).title;
      if (correctAnswer == userAnswers[i]) {
        correct++;
      }
    }
    return correct;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CupertinoPageScaffold(
        backgroundColor: const Color(0xFF181818),
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: Color(0xFF181818),
          border: null,
          middle: Text(
            'Quiz Results',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF222222),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$correctAnswers/${questions.length}',
                          style: const TextStyle(
                            color: Color(0xffFEDB35),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Correct Answers',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white24,
                    ),
                    Column(
                      children: [
                        Text(
                          '${(correctAnswers / questions.length * 100).round()}%',
                          style: const TextStyle(
                            color: Color(0xffFEDB35),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Score',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    final userAnswer = userAnswers[index];
                    final correctAnswer = question.answers
                        .firstWhere((answer) => answer.isCorrect)
                        .title;
                    final isCorrect = correctAnswer == userAnswer;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF222222),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isCorrect
                              ? const Color(0xFF4CAF50).withOpacity(0.3)
                              : const Color(0xFFFF5252).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isCorrect
                                    ? CupertinoIcons.checkmark_circle_fill
                                    : CupertinoIcons.xmark_circle_fill,
                                color: isCorrect
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFFFF5252),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Question ${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            question.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Your answer: $userAnswer',
                            style: TextStyle(
                              color: isCorrect
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFFF5252),
                              fontSize: 14,
                            ),
                          ),
                          if (!isCorrect) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Correct answer: $correctAnswer',
                              style: const TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
