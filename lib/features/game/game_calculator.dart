import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpeedCalculatorGame extends StatefulWidget {
  const SpeedCalculatorGame({super.key});

  @override
  State<SpeedCalculatorGame> createState() => _SpeedCalculatorGameState();
}

class _SpeedCalculatorGameState extends State<SpeedCalculatorGame> {
  int score = 0;
  int timeLeft = 60;
  String currentProblem = '';
  int correctAnswer = 0;
  TextEditingController answerController = TextEditingController();
  Timer? timer;
  bool isGameActive = false;

  @override
  void initState() {
    super.initState();
    generateNewProblem();
  }

  void startGame() {
    setState(() {
      score = 0;
      timeLeft = 60;
      isGameActive = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          endGame();
        }
      });
    });
  }

  void endGame() {
    timer?.cancel();
    setState(() {
      isGameActive = false;
    });
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Game Over!'),
        content: Text('Your score: $score'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Play Again'),
            onPressed: () {
              Navigator.pop(context);
              startGame();
            },
          ),
          CupertinoDialogAction(
            child: const Text('Exit'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void generateNewProblem() {
    final random = Random();
    int num1 = random.nextInt(20) + 1;
    int num2 = random.nextInt(20) + 1;
    String operator = ['+', '-', '×'][random.nextInt(3)];

    setState(() {
      currentProblem = '$num1 $operator $num2';
      switch (operator) {
        case '+':
          correctAnswer = num1 + num2;
          break;
        case '-':
          correctAnswer = num1 - num2;
          break;
        case '×':
          correctAnswer = num1 * num2;
          break;
      }
    });
  }

  void checkAnswer() {
    if (answerController.text == correctAnswer.toString()) {
      setState(() {
        score += 10;
      });
      generateNewProblem();
    }
    answerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        border: null,
        middle: const Text(
          'Speed Calculator',
          style: TextStyle(color: CupertinoColors.white),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.back,
            color: CupertinoColors.white,
          ),
          onPressed: () {
            timer?.cancel();
            Navigator.pop(context);
          },
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Time: $timeLeft',
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              if (!isGameActive)
                CupertinoButton(
                  color: CupertinoColors.systemYellow,
                  child: const Text(
                    'Start Game',
                    style: TextStyle(
                      color: CupertinoColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: startGame,
                )
              else
                Column(
                  children: [
                    Text(
                      currentProblem,
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CupertinoTextField(
                      controller: answerController,
                      keyboardType: TextInputType.number,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      style: const TextStyle(color: CupertinoColors.white),
                      textAlign: TextAlign.center,
                      onSubmitted: (_) => checkAnswer(),
                    ),
                    const SizedBox(height: 16),
                    CupertinoButton(
                      color: CupertinoColors.systemYellow,
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          color: CupertinoColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: checkAnswer,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    answerController.dispose();
    super.dispose();
  }
}
