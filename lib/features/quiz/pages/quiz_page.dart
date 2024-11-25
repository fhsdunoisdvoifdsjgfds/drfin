import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsafer/features/quiz/result.dart';
import '../../../blocs/btn/btn_bloc.dart';
import '../../../core/models/questionn.dart';
import '../widgets/answer_widget.dart';
import '../widgets/question_widget.dart';

class QuizPage extends StatefulWidget {
  final List<Questionn> questions;

  const QuizPage({
    super.key,
    required this.questions,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int index = 0;
  int correctAnswers = 0;
  Answer _answer = defaultAnswer;
  List<String> userAnswers = [];

  void checkButton() {
    if (_answer.title.isNotEmpty) {
      context.read<BtnBloc>().add(
            CheckBtnActive(
              controllers: const ['active'],
            ),
          );
    } else {
      context.read<BtnBloc>().add(DisableBtn());
    }
  }

  void onAnswer(Answer value) {
    setState(() {
      _answer = value;
    });
    checkButton();
  }

  void onContinue() {
    if (_answer.title.isEmpty) return;

    if (_answer.isCorrect) {
      setState(() {
        correctAnswers++;
      });
    }

    userAnswers[index] = _answer.title;

    if (index == widget.questions.length - 1) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => QuizResultsPage(
            questions: widget.questions,
            userAnswers: userAnswers,
          ),
        ),
      );
    } else {
      setState(() {
        _answer = defaultAnswer;
        index++;
      });
      context.read<BtnBloc>().add(DisableBtn());
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<BtnBloc>().add(DisableBtn());
    widget.questions.shuffle();
    for (Questionn question in widget.questions) {
      question.answers.shuffle();
    }
    userAnswers = List.filled(widget.questions.length, '');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CupertinoPageScaffold(
        backgroundColor: const Color(0xFF181818),
        navigationBar: CupertinoNavigationBar(
          backgroundColor: const Color(0xFF181818),
          border: null,
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pop(context),
            child: const Icon(
              CupertinoIcons.back,
              color: CupertinoColors.white,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${index + 1}/${widget.questions.length}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF222222),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Score: $correctAnswers',
                        style: const TextStyle(
                          color: Color(0xffFEDB35),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: QuestionWidget(question: widget.questions[index].title),
              ),
              const SizedBox(height: 30),
              BlocBuilder<BtnBloc, BtnState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      AnswerWidget(
                        id: 1,
                        answer: widget.questions[index].answers[0],
                        current: _answer,
                        onPressed: onAnswer,
                      ),
                      AnswerWidget(
                        id: 2,
                        answer: widget.questions[index].answers[1],
                        current: _answer,
                        onPressed: onAnswer,
                      ),
                      AnswerWidget(
                        id: 3,
                        answer: widget.questions[index].answers[2],
                        current: _answer,
                        onPressed: onAnswer,
                      ),
                      AnswerWidget(
                        id: 4,
                        answer: widget.questions[index].answers[3],
                        current: _answer,
                        onPressed: onAnswer,
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<BtnBloc, BtnState>(
                  builder: (context, state) {
                    final isActive = state is BtnActive;
                    return CupertinoButton(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      color: isActive
                          ? const Color(0xffFEDB35)
                          : const Color(0xFF222222),
                      borderRadius: BorderRadius.circular(16),
                      onPressed: isActive ? onContinue : null,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isActive
                                ? const Color(0xFF181818)
                                : Colors.white30,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
