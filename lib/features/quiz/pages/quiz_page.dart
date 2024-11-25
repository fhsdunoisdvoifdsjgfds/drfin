import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/btn/btn_bloc.dart';
import '../../../core/config/my_fonts.dart';
import '../../../core/models/questionn.dart';
import '../../../core/utilsss.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/my_dialog.dart';
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

  void checkButton() {
    if (_answer.title.isNotEmpty) {
      context.read<BtnBloc>().add(
            CheckBtnActive(
              controllers: ['active'],
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

    setState(() {
      _answer = defaultAnswer;
      if (index == 19) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return MyDialog(
              title: 'Correct answers: $correctAnswers',
              onlyClose: true,
              onYes: () {
                setState(() {
                  index = 0;
                  correctAnswers = 0;
                  _answer = defaultAnswer;
                });
                context.pop();
                checkButton();
              },
            );
          },
        );
      } else {
        index++;
      }
    });
    context.read<BtnBloc>().add(DisableBtn());
  }

  @override
  void initState() {
    super.initState();
    context.read<BtnBloc>().add(DisableBtn());
    widget.questions.shuffle();
    for (Questionn question in widget.questions) {
      question.answers.shuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getStatusBar(context, height: 56)),
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 10),
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
                  answer: questionsList[index].answers[0],
                  current: _answer,
                  onPressed: onAnswer,
                ),
                AnswerWidget(
                  id: 2,
                  answer: questionsList[index].answers[1],
                  current: _answer,
                  onPressed: onAnswer,
                ),
                AnswerWidget(
                  id: 3,
                  answer: questionsList[index].answers[2],
                  current: _answer,
                  onPressed: onAnswer,
                ),
                AnswerWidget(
                  id: 4,
                  answer: questionsList[index].answers[3],
                  current: _answer,
                  onPressed: onAnswer,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 25),
        BlocBuilder<BtnBloc, BtnState>(
          builder: (context, state) {
            return MainButton(
              title: 'Continue',
              horizontalPadding: 16,
              onPressed: onContinue,
            );
          },
        ),
      ],
    );
  }
}
