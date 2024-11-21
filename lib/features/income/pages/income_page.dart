import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/btn/btn_bloc.dart';
import '../../../blocs/incom/incom_bloc.dart';
import '../../../blocs/nav/nav_bloc.dart';
import '../../../core/models/incom.dart';
import '../../../core/utilsss.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/tab_button.dart';
import '../../../core/widgets/my_field.dart';
import '../../../core/widgets/page_title.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final categoryController = TextEditingController();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  List<String> categories = [
    'Personal',
    'Real estate',
    'Dividends',
  ];

  void checkButton() {
    context.read<BtnBloc>().add(
          CheckBtnActive(
            controllers: [
              categoryController.text,
              titleController.text,
              amountController.text,
            ],
          ),
        );
  }

  void onCategory(String value) {
    if (categoryController.text == value) {
      categoryController.clear();
    } else {
      categoryController.text = value;
    }
    checkButton();
  }

  void onAdd() {
    final incom = Incom(
      id: getTimestamp(),
      category: categoryController.text,
      title: titleController.text,
      amount: int.parse(amountController.text),
    );
    context.read<IncomBloc>().add(IncomAdd(incom: incom));
    context.read<NavBloc>().add(ChangeNav(index: 1));
    context.read<BtnBloc>().add(DisableBtn());
  }

  @override
  void initState() {
    super.initState();
    checkButton();
  }

  @override
  void dispose() {
    categoryController.dispose();
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getStatusBar(context, height: 6)),
        const PageTitle('Income'),
        const SizedBox(height: 26),
        SizedBox(
          height: 36,
          child: BlocBuilder<BtnBloc, BtnState>(
            builder: (context, state) {
              return ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                children: List.generate(
                  categories.length,
                  (index) {
                    return TabButton(
                      title: categories[index],
                      current: categoryController.text,
                      onPressed: onCategory,
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 50),
        const PageTitle('Add Transaction'),
        const SizedBox(height: 16),
        MyField(
          controller: titleController,
          hintText: 'Income description',
          horizontalPadding: 16,
          onChanged: checkButton,
        ),
        const SizedBox(height: 16),
        MyField(
          controller: amountController,
          hintText: 'Income amount',
          onlyNumber: true,
          length: 7,
          horizontalPadding: 16,
          onChanged: checkButton,
        ),
        const SizedBox(height: 56),
        MainButton(
          title: 'Add income',
          horizontalPadding: 16,
          onPressed: onAdd,
        ),
      ],
    );
  }
}
