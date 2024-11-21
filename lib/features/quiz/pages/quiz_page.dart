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
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int index = 0;
  int correctAnswers = 0;
  Answer _answer = defaultAnswer;

  void checkButton() {
    context.read<BtnBloc>().add(CheckBtnActive(controllers: [_answer.title]));
  }

  void onAnswer(Answer value) {
    _answer = value;
    checkButton();
  }

  void onContinue() {
    if (_answer.isCorrect) correctAnswers++;
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
              index = 0;
              context.pop();
              checkButton();
            },
          );
        },
      );
    } else {
      index++;
      checkButton();
    }
  }

  @override
  void initState() {
    super.initState();
    checkButton();
    questionsList.shuffle();
    for (Questionn question in questionsList) {
      question.answers.shuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getStatusBar(context, height: 56)),
        Center(
          child: BlocBuilder<BtnBloc, BtnState>(
            builder: (context, state) {
              return Text(
                'Question ${index + 1}/20',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: MyFonts.w800,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        BlocBuilder<BtnBloc, BtnState>(
          builder: (context, state) {
            return QuestionWidget(question: questionsList[index].title);
          },
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
        MainButton(
          title: 'Continue',
          horizontalPadding: 16,
          onPressed: onContinue,
        ),
      ],
    );
  }
}
