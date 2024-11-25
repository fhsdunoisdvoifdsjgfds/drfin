import 'package:tsafer/blocs/incom/incom_bloc.dart';
import 'package:tsafer/blocs/nav/nav_bloc.dart';
import 'package:tsafer/core/utilsss.dart';
import 'package:tsafer/features/splash/check_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => InitialPageState();
}

class InitialPageState extends State<InitialPage> {
  final currencyController1 = TextEditingController();
  final currencyController2 = TextEditingController();

  String page = 'Balance';
  final List<String> pages = [
    'Balance',
    'Currency rate',
    'History',
  ];

  void onPage(String value) {
    setState(() {
      page = value;
    });
  }

  void onCurrency(bool usd) {
    if (usd) {
      double usdValue = double.tryParse(currencyController1.text) ?? 0.0;
      double euroValue = usdValue * 0.95;
      currencyController2.text = euroValue.toStringAsFixed(2);
    } else {
      double euroValue = double.tryParse(currencyController2.text) ?? 0.0;
      double usdValue = euroValue / 0.95;
      currencyController1.text = usdValue.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    currencyController1.dispose();
    currencyController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        border: null,
        middle: Text(
          'Income',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CupertinoSlidingSegmentedControl<String>(
              backgroundColor: const Color(0xFF1C1C1E),
              thumbColor: CupertinoColors.systemYellow,
              groupValue: page,
              children: {
                for (var p in pages)
                  p: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      p,
                      style: TextStyle(
                        color: page == p
                            ? CupertinoColors.black
                            : CupertinoColors.white,
                      ),
                    ),
                  ),
              },
              onValueChanged: (value) {
                if (value != null) onPage(value);
              },
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: pages.indexOf(page),
              children: [
                _buildBalanceView(),
                _buildCurrencyView(),
                _buildHistoryView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceView() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${getBalance().toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Accumulated amount',
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionButton(
                          icon: CupertinoIcons.plus_circle_fill,
                          label: 'Add',
                          onTap: () =>
                              context.read<NavBloc>().add(ChangeNav(index: 2)),
                        ),
                        _buildActionButton(
                          icon: CupertinoIcons.arrow_2_circlepath,
                          label: 'Exchange',
                          onTap: () => onPage('Currency rate'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xffFEDB35).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const FinanceChecklist(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xffFEDB35).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            CupertinoIcons.checkmark_rectangle,
                            color: Color(0xffFEDB35),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Financial Checklist',
                                style: TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Monitor your financial aims',
                                style: TextStyle(
                                  color: CupertinoColors.systemGrey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          CupertinoIcons.chevron_right,
                          color: CupertinoColors.systemGrey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Recent Actions',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: BlocBuilder<IncomBloc, IncomState>(
            builder: (context, state) {
              if (state is IncomLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < 2) {
                        final incom = state.incoms[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Dismissible(
                            key: Key(incom.id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemRed,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                CupertinoIcons.delete,
                                color: CupertinoColors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              context
                                  .read<IncomBloc>()
                                  .add(IncomDelete(incom: incom));
                              ScaffoldMessenger.of(context).showSnackBar(
                                CupertinoSnackBar(
                                  content: const Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.delete,
                                        color: CupertinoColors.white,
                                        size: 18,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Transaction deleted',
                                        style: TextStyle(
                                            color: CupertinoColors.white),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: const Color(0xFF1C1C1E),
                                ),
                              );
                            },
                            child: _buildTransactionCard(incom),
                          ),
                        );
                      }
                      return null;
                    },
                    childCount: state.incoms.length.clamp(0, 2),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCurrencyCard(
            controller: currencyController1,
            currency: 'USD',
            symbol: '\$',
            onChanged: onCurrency,
          ),
          const SizedBox(height: 16),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: CupertinoColors.systemYellow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              CupertinoIcons.arrow_up_arrow_down,
              color: CupertinoColors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildCurrencyCard(
            controller: currencyController2,
            currency: 'EUR',
            symbol: '€',
            onChanged: onCurrency,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryView() {
    return BlocBuilder<IncomBloc, IncomState>(
      builder: (context, state) {
        if (state is IncomLoaded) {
          if (state.incoms.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.doc_text_search,
                    size: 48,
                    color: CupertinoColors.systemGrey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No transactions yet',
                    style: TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: state.incoms.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildTransactionCard(state.incoms[index]),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6.darkColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: CupertinoColors.white),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyCard({
    required TextEditingController controller,
    required String currency,
    required String symbol,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            currency,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              decoration: null,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 17,
              ),
              placeholder: symbol,
              placeholderStyle: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 17,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              onChanged: (value) {
                onChanged(currency == 'USD');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(dynamic incom) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6.darkColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              CupertinoIcons.money_dollar_circle,
              color: CupertinoColors.systemGreen,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  incom.title ?? 'Transaction',
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  incom.category ?? 'Uncategorized',
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${incom.amount?.toStringAsFixed(2) ?? '0.00'}',
            style: const TextStyle(
              color: CupertinoColors.systemGreen,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class CupertinoSnackBar extends SnackBar {
  CupertinoSnackBar({
    super.key,
    required Widget content,
    Color? backgroundColor,
  }) : super(
          content: content,
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          width: 300,
          duration: const Duration(seconds: 2),
        );
}
