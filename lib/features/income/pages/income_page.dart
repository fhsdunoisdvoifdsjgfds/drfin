import 'package:tsafer/blocs/btn/btn_bloc.dart';
import 'package:tsafer/blocs/incom/incom_bloc.dart';
import 'package:tsafer/blocs/nav/nav_bloc.dart';
import 'package:tsafer/core/models/incom.dart';
import 'package:tsafer/core/utilsss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state_category.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final categoryController = TextEditingController();
  final titleController = TextEditingController();
  final amountController = TextEditingController();

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

  void onCategory(String category) {
    setState(() {
      if (categoryController.text == category) {
        categoryController.clear();
      } else {
        categoryController.text = category;
      }
    });
    checkButton();
  }

  void onAdd() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        categoryController.text.isEmpty) {
      return;
    }

    try {
      final amount =
          double.tryParse(amountController.text.replaceAll(',', '.'));
      if (amount == null) return;

      final incom = Incom(
        id: getTimestamp(),
        category: categoryController.text,
        title: titleController.text,
        amount: amount,
      );
      context.read<IncomBloc>().add(IncomAdd(incom: incom));
      titleController.clear();
      amountController.clear();
      categoryController.clear();
      context.read<NavBloc>().add(ChangeNav(index: 1));
      context.read<BtnBloc>().add(DisableBtn());
    } catch (e) {
      debugPrint('Error adding income: $e');
    }
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
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        border: null,
        middle: const Text(
          'Add Income',
          style: TextStyle(color: CupertinoColors.white),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.back,
            color: CupertinoColors.white,
          ),
          onPressed: () => context.read<NavBloc>().add(ChangeNav(index: 1)),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = categoryController.text == category.name;

                  return CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: isSelected
                        ? CupertinoColors.systemYellow
                        : const Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(20),
                    onPressed: () => onCategory(category.name),
                    child: Text(
                      category.name,
                      style: TextStyle(
                        color: isSelected
                            ? CupertinoColors.black
                            : CupertinoColors.white,
                        fontSize: 15,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Transaction Details',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        CupertinoTextField(
                          controller: titleController,
                          decoration: null,
                          style: const TextStyle(color: CupertinoColors.white),
                          placeholder: 'Income description',
                          placeholderStyle: const TextStyle(
                            color: CupertinoColors.systemGrey,
                          ),
                          padding: const EdgeInsets.all(16),
                          onChanged: (_) => checkButton(),
                        ),
                        Container(
                          height: 1,
                          color: CupertinoColors.systemGrey6,
                        ),
                        CupertinoTextField(
                          controller: amountController,
                          decoration: null,
                          style: const TextStyle(color: CupertinoColors.white),
                          placeholder: 'Income amount',
                          placeholderStyle: const TextStyle(
                            color: CupertinoColors.systemGrey,
                          ),
                          padding: const EdgeInsets.all(16),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}')),
                          ],
                          onChanged: (_) => checkButton(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<BtnBloc, BtnState>(
                builder: (context, state) {
                  final isActive = state is BtnActive;

                  return SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      borderRadius: BorderRadius.circular(12),
                      color: isActive
                          ? CupertinoColors.systemYellow
                          : const Color(0xFF1C1C1E),
                      onPressed: isActive ? onAdd : null,
                      child: Text(
                        'Add Income',
                        style: TextStyle(
                          color: isActive
                              ? CupertinoColors.black
                              : CupertinoColors.systemGrey,
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
    );
  }
}
