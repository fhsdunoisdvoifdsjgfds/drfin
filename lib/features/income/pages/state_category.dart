import 'package:dark_fin/blocs/btn/btn_bloc.dart';
import 'package:dark_fin/blocs/incom/incom_bloc.dart';
import 'package:dark_fin/blocs/nav/nav_bloc.dart';
import 'package:dark_fin/core/models/incom.dart';
import 'package:dark_fin/core/utilsss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _IncomeCategory {
  final String name;
  final IconData icon;
  final Color color;

  const _IncomeCategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}

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

  void _showCategoryPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.only(top: 6.0),
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 5,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Category',
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = categoryController.text == category.name;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        categoryController.text = category.name;
                      });
                      checkButton();
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? category.color.withOpacity(0.2)
                            : const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              isSelected ? category.color : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category.icon,
                            color: category.color,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category.name,
                            style: const TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
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

  void onAdd() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        categoryController.text.isEmpty) {
      return;
    }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(12),
                onPressed: _showCategoryPicker,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      categoryController.text.isEmpty
                          ? 'Select Category'
                          : categoryController.text,
                      style: TextStyle(
                        color: categoryController.text.isEmpty
                            ? CupertinoColors.systemGrey
                            : CupertinoColors.white,
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.chevron_down,
                      color: CupertinoColors.systemGrey,
                      size: 20,
                    ),
                  ],
                ),
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

final List<_IncomeCategory> categories = [
  _IncomeCategory(
    name: 'Salary',
    icon: CupertinoIcons.money_dollar_circle_fill,
    color: CupertinoColors.systemGreen,
  ),
  _IncomeCategory(
    name: 'Investments',
    icon: CupertinoIcons.graph_circle_fill,
    color: CupertinoColors.systemBlue,
  ),
  _IncomeCategory(
    name: 'Real Estate',
    icon: CupertinoIcons.house_fill,
    color: CupertinoColors.systemOrange,
  ),
  _IncomeCategory(
    name: 'Dividends',
    icon: CupertinoIcons.chart_bar_fill,
    color: CupertinoColors.systemPurple,
  ),
  _IncomeCategory(
    name: 'Freelance',
    icon: CupertinoIcons.briefcase_fill,
    color: CupertinoColors.systemIndigo,
  ),
  _IncomeCategory(
    name: 'Side Business',
    icon: CupertinoIcons.shopping_cart,
    color: CupertinoColors.systemPink,
  ),
  _IncomeCategory(
    name: 'Consulting',
    icon: CupertinoIcons.person_2_fill,
    color: CupertinoColors.systemTeal,
  ),
  _IncomeCategory(
    name: 'Royalties',
    icon: CupertinoIcons.star_fill,
    color: CupertinoColors.systemYellow,
  ),
  _IncomeCategory(
    name: 'Rental',
    icon: CupertinoIcons.home,
    color: CupertinoColors.systemRed,
  ),
  _IncomeCategory(
    name: 'Other',
    icon: CupertinoIcons.plus_circle_fill,
    color: CupertinoColors.systemGrey,
  ),
];
