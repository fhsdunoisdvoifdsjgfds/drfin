import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/btn/btn_bloc.dart';
import '../../../core/models/newss.dart';
import '../../../core/utilsss.dart';
import '../../../core/widgets/tab_button.dart';
import '../../../core/widgets/page_title.dart';
import '../widgets/news_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String category = 'All';
  List<String> newsCategory = [
    'All',
    'Politics',
    'Finance',
    'Analytics',
    'Statistics',
  ];

  void onCategory(String value) {
    category = value;
    context.read<BtnBloc>().add(CheckBtnActive(controllers: const ['']));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getStatusBar(context, height: 6)),
        const PageTitle('News'),
        const SizedBox(height: 26),
        SizedBox(
          height: 36,
          child: BlocBuilder<BtnBloc, BtnState>(
            builder: (context, state) {
              return ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                children: List.generate(
                  newsCategory.length,
                  (index) {
                    return TabButton(
                      title: newsCategory[index],
                      current: category,
                      onPressed: onCategory,
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocBuilder<BtnBloc, BtnState>(
            builder: (context, state) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  if (category == 'All') {
                    return NewsWidget(newss: newsList[index]);
                  } else if (newsList[index].category == category) {
                    return NewsWidget(newss: newsList[index]);
                  }
                  return const SizedBox();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
