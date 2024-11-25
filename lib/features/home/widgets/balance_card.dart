import 'package:dark_fin/blocs/incom/incom_bloc.dart';
import 'package:dark_fin/core/models/newss.dart';
import 'package:dark_fin/core/utilsss.dart';
import 'package:dark_fin/features/news/widgets/news_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Currency {
  final String code;
  final String symbol;
  final String name;
  final double rate; // курс относительно USD

  const Currency({
    required this.code,
    required this.symbol,
    required this.name,
    required this.rate,
  });
}

class BalanceCard extends StatefulWidget {
  const BalanceCard({super.key, this.onExchange});

  final void Function()? onExchange;

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  final currencyController1 = TextEditingController();
  final currencyController2 = TextEditingController();

  int selectedCurrency1 = 0;
  int selectedCurrency2 = 1;

  final List<Currency> currencies = const [
    Currency(code: 'USD', symbol: '\$', name: 'US Dollar', rate: 1.0),
    Currency(code: 'EUR', symbol: '€', name: 'Euro', rate: 0.85),
    Currency(code: 'GBP', symbol: '£', name: 'British Pound', rate: 0.73),
    Currency(code: 'JPY', symbol: '¥', name: 'Japanese Yen', rate: 110.0),
    Currency(code: 'CNY', symbol: '¥', name: 'Chinese Yuan', rate: 6.45),
    Currency(code: 'CHF', symbol: 'Fr', name: 'Swiss Franc', rate: 0.92),
  ];

  void swapCurrencies() {
    setState(() {
      final temp = selectedCurrency1;
      selectedCurrency1 = selectedCurrency2;
      selectedCurrency2 = temp;
      if (currencyController1.text.isNotEmpty) {
        convertCurrency(true);
      }
    });
  }

  void convertCurrency(bool isFromFirst) {
    final fromRate = currencies[selectedCurrency1].rate;
    final toRate = currencies[selectedCurrency2].rate;

    if (isFromFirst) {
      final amount = double.tryParse(currencyController1.text) ?? 0.0;
      final converted = (amount / fromRate * toRate).toStringAsFixed(2);
      currencyController2.text = converted;
    } else {
      final amount = double.tryParse(currencyController2.text) ?? 0.0;
      final converted = (amount / toRate * fromRate).toStringAsFixed(2);
      currencyController1.text = converted;
    }
  }

  void _showCurrencyPicker(bool isFirst) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        color: const Color(0xFF1C1C1E),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('Done'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                backgroundColor: const Color(0xFF1C1C1E),
                itemExtent: 40,
                children: currencies.map((currency) {
                  return Text(
                    '${currency.code} - ${currency.name}',
                    style: const TextStyle(color: CupertinoColors.white),
                  );
                }).toList(),
                onSelectedItemChanged: (index) {
                  setState(() {
                    if (isFirst) {
                      selectedCurrency1 = index;
                    } else {
                      selectedCurrency2 = index;
                    }
                    if (currencyController1.text.isNotEmpty) {
                      convertCurrency(true);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460,
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<IncomBloc, IncomState>(
            builder: (context, state) {
              return Text(
                '${currencies[selectedCurrency1].symbol}${getBalance()}',
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
          const SizedBox(height: 2),
          Text(
            currencies[selectedCurrency1].code,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => _showCurrencyPicker(true),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3C3C3E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          currencies[selectedCurrency1].code,
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CupertinoTextField(
                            controller: currencyController1,
                            decoration: null,
                            style:
                                const TextStyle(color: CupertinoColors.white),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            placeholder: '0.00',
                            placeholderStyle: const TextStyle(
                                color: CupertinoColors.systemGrey),
                            onChanged: (_) => convertCurrency(true),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: swapCurrencies,
                  child: Container(
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
                ),
                const SizedBox(height: 12),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => _showCurrencyPicker(false),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3C3C3E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          currencies[selectedCurrency2].code,
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CupertinoTextField(
                            controller: currencyController2,
                            decoration: null,
                            style:
                                const TextStyle(color: CupertinoColors.white),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            placeholder: '0.00',
                            placeholderStyle: const TextStyle(
                                color: CupertinoColors.systemGrey),
                            onChanged: (_) => convertCurrency(false),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'News',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 4,
              itemBuilder: (context, index) {
                return NewsWidget(
                  newss: newsList[index],
                  balanceCard: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    currencyController1.dispose();
    currencyController2.dispose();
    super.dispose();
  }
}
