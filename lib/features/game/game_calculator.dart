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
  final TextEditingController _answerController = TextEditingController();
  int score = 0;
  int firstNumber = 0;
  int secondNumber = 0;
  String operator = '';
  int correctAnswer = 0;
  int timeLeft = 30;
  Timer? _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _generateNewEquation();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          _timer?.cancel();
          _showGameOverDialog();
        }
      });
    });
  }

  void _generateNewEquation() {
    firstNumber = _random.nextInt(10) + 1;
    secondNumber = _random.nextInt(10) + 1;
    final operators = ['+', '-', '×'];
    operator = operators[_random.nextInt(operators.length)];

    switch (operator) {
      case '+':
        correctAnswer = firstNumber + secondNumber;
        break;
      case '-':
        correctAnswer = firstNumber - secondNumber;
        break;
      case '×':
        correctAnswer = firstNumber * secondNumber;
        break;
    }
  }

  void _checkAnswer() {
    final userAnswer = int.tryParse(_answerController.text);
    if (userAnswer == correctAnswer) {
      setState(() {
        score += 10;
        _answerController.clear();
        _generateNewEquation();
      });
    } else {
      _answerController.clear();
    }
  }

  void _showGameOverDialog() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Game Over!'),
        content: Text('Your final score: $score'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Play Again'),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                score = 0;
                timeLeft = 30;
                _generateNewEquation();
                _startTimer();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CupertinoPageScaffold(
        backgroundColor: const Color(0xFF181818),
        navigationBar: CupertinoNavigationBar(
          backgroundColor: const Color(0xFF222222),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              _timer?.cancel();
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.back,
              color: CupertinoColors.white,
            ),
          ),
          middle: const Text(
            'Speed Calculator',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF222222),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Score: $score',
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xFF222222),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '$firstNumber $operator $secondNumber = ?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF222222),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CupertinoTextField(
                    controller: _answerController,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 24,
                    ),
                    keyboardType: TextInputType.number,
                    placeholder: 'Enter your answer',
                    placeholderStyle: TextStyle(
                      color: CupertinoColors.white.withOpacity(0.4),
                      fontSize: 20,
                    ),
                    padding: const EdgeInsets.all(16),
                    onSubmitted: (_) => _checkAnswer(),
                  ),
                ),
                const SizedBox(height: 24),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: const Color(0xffFEDB35),
                  borderRadius: BorderRadius.circular(15),
                  onPressed: _checkAnswer,
                  child: const Text(
                    'Check Answer',
                    style: TextStyle(
                      color: Color(0xFF181818),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _answerController.dispose();
    super.dispose();
  }
}
