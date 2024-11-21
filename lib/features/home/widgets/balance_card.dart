import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/incom/incom_bloc.dart';
import '../../../blocs/nav/nav_bloc.dart';
import '../../../core/config/my_fonts.dart';
import '../../../core/models/newss.dart';
import '../../../core/utilsss.dart';
import '../../../core/widgets/my_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../news/widgets/news_widget.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, this.onExchange});

  final void Function()? onExchange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460,
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xff343434),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          BlocBuilder<IncomBloc, IncomState>(
            builder: (context, state) {
              return Text(
                '\$ ${getBalance()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: MyFonts.w600,
                ),
              );
            },
          ),
          const SizedBox(height: 2),
          const Text(
            'USD',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: MyFonts.w400,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const _Button(
                id: 1,
                title: 'Add',
              ),
              _Button(
                id: 2,
                title: 'Exchange',
                onExchange: onExchange,
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'News',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontFamily: MyFonts.w500,
            ),
          ),
          const SizedBox(height: 14),
          NewsWidget(newss: newsList[0], balanceCard: true),
          NewsWidget(newss: newsList[1], balanceCard: true),
          NewsWidget(newss: newsList[2], balanceCard: true),
          NewsWidget(newss: newsList[3], balanceCard: true),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.id,
    required this.title,
    this.onExchange,
  });

  final int id;
  final String title;
  final void Function()? onExchange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onPressed: onExchange ??
              () {
                if (id == 1) {
                  context.read<NavBloc>().add(ChangeNav(index: 2));
                }
              },
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff404040),
            ),
            child: Center(
              child: SVGWidgett('assets/balance$id.svg'),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontFamily: MyFonts.w500,
          ),
        ),
      ],
    );
  }
}
