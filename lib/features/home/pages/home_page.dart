import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utilsss.dart';
import '../../../blocs/nav/nav_bloc.dart';
import '../../income/pages/income_page.dart';
import '../../news/pages/news_page.dart';
import '../../quiz/pages/quiz_page.dart';
import '../widgets/my_nav.dart';
import 'initial_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 62 + getBot(context)),
            child: BlocBuilder<NavBloc, NavState>(
              builder: (context, state) {
                if (state is NavIncome) return const IncomePage();
                if (state is NavNews) return const NewsPage();
                if (state is NavQuiz) return const QuizPage();
                return const InitialPage();
              },
            ),
          ),
          const MyNav(),
        ],
      ),
    );
  }
}
