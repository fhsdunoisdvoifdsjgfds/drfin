import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/btn/btn_bloc.dart';
import '../../../blocs/incom/incom_bloc.dart';
import '../../../core/config/my_fonts.dart';
import '../../../core/utilsss.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/tab_button.dart';
import '../../../core/widgets/nodata.dart';
import '../../../core/widgets/page_title.dart';
import '../widgets/balance_card.dart';
import '../widgets/income_card.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => InitialPageState();
}

class InitialPageState extends State<InitialPage> {
  final currencyController1 = TextEditingController();
  final currencyController2 = TextEditingController();

  String page = 'Balance';
  List<String> pages = [
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
                  pages.length,
                  (index) {
                    return TabButton(
                      title: pages[index],
                      current: page,
                      onPressed: onPage,
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        if (page == 'Balance')
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 10),
                BalanceCard(
                  onExchange: () {
                    onPage('Currency rate');
                  },
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    SizedBox(width: 22),
                    Text(
                      'Actions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: MyFonts.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                BlocBuilder<IncomBloc, IncomState>(
                  builder: (context, state) {
                    if (state is IncomLoaded) {
                      return Column(
                        children: [
                          ...List.generate(
                            state.incoms.length,
                            (index) {
                              if (index < 2) {
                                return IncomeCard(incom: state.incoms[index]);
                              }
                              return Container();
                            },
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        else if (page == 'History')
          Expanded(
            child: BlocBuilder<IncomBloc, IncomState>(
              builder: (context, state) {
                if (state is IncomLoaded) {
                  if (state.incoms.isEmpty) {
                    return const Nodata();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: state.incoms.length,
                    itemBuilder: (context, index) {
                      return IncomeCard(incom: state.incoms[index]);
                    },
                  );
                }

                return Container();
              },
            ),
          )
        else
          SizedBox(
            height: 288,
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40),
                    _CurrencyCard(
                      controller: currencyController1,
                      currency: 'USD',
                      onChanged: onCurrency,
                    ),
                    const SizedBox(height: 8),
                    _CurrencyCard(
                      controller: currencyController2,
                      currency: 'EUR',
                      onChanged: onCurrency,
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 144,
                  child: Center(
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: SVGWidgett('assets/arrow.svg'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CurrencyCard extends StatelessWidget {
  const _CurrencyCard({
    required this.controller,
    required this.currency,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String currency;
  final void Function(bool usd) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xff343434),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            currency,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: MyFonts.w600,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: MyFonts.w600,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: currency == 'USD' ? '\$' : '€',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontFamily: MyFonts.w600,
                ),
              ),
              onChanged: (value) {
                onChanged(currency == 'USD' ? true : false);
              },
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
