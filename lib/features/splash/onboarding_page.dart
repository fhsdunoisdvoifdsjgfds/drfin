import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config/my_fonts.dart';
import '../../core/utilsss.dart';
import '../../core/widgets/main_button.dart';
import '../../core/widgets/my_button.dart';
import '../../core/widgets/degree_widget.dart';
import '../../core/widgets/svg_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int index = 1;

  void onContinue() async {
    if (index == 2) {
      final pref = await SharedPreferences.getInstance();
      pref.setBool('onboard', false);
      if (mounted) context.go('/home');
      // setState(() {
      //   index = 1;
      // });
    } else {
      setState(() {
        index++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: getStatusBar(context, height: 30)),
          Row(
            children: [
              const SizedBox(width: 20),
              _Indicator(active: index == 1),
              const SizedBox(width: 6),
              _Indicator(active: index == 2),
              const SizedBox(width: 20),
            ],
          ),
          const Spacer(),
          if (index == 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Image.asset('assets/onboarding.png'),
            )
          else
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 234,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff767676),
                            blurRadius: 94,
                            spreadRadius: -30,
                            offset: Offset(0, 40),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          SizedBox(height: 44),
                          Text(
                            'Emily Walkers',
                            style: TextStyle(
                              color: Color(0xff171B34),
                              fontSize: 12,
                              fontFamily: MyFonts.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Glad to hear that! It\'s always nice when a mobile app helps improve financial management. Simplified income tracking, as well as easy methods for adding income sources, setting categories, and entering specific information help save a lot of time and make financial management more efficient. Keep using the app to easily take control of your finances!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff505050),
                              fontSize: 10,
                              fontFamily: MyFonts.w500,
                              height: 1.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 66,
                      width: 66,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset('assets/onboarding2.png'),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 30,
                    child: SVGWidgett('assets/onboarding2.svg'),
                  ),
                  Positioned(
                    top: 36,
                    right: 15,
                    child: Transform.scale(
                      scale: 0.9,
                      child: const DegreeWidget(
                        degree: 20,
                        child: SVGWidgett('assets/onboarding2.svg'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 60,
                    child: Transform.scale(
                      scale: 0.7,
                      child: const DegreeWidget(
                        degree: -20,
                        child: SVGWidgett('assets/onboarding2.svg'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        height: 26,
                        width: 102,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffEDEDED),
                              Colors.white,
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            height: 22,
                            width: 98,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.white,
                                  Color(0xffEDEDED),
                                ],
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SVGWidgett('assets/star.svg'),
                                SVGWidgett('assets/star.svg'),
                                SVGWidgett('assets/star.svg'),
                                SVGWidgett('assets/star.svg'),
                                SVGWidgett('assets/star.svg'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const Spacer(),
          Container(
            height: 280,
            decoration: const BoxDecoration(
              color: Color(0xff343434),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                const Spacer(),
                if (index == 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Text(
                      'Manage your income, stay informed and control your finances - all available in one app!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: MyFonts.w600,
                      ),
                    ),
                  ),
                if (index == 2)
                  const Text(
                    'We value your feedback',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: MyFonts.w800,
                    ),
                  ),
                if (index == 2) const Spacer(),
                if (index == 2)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Every day we are getting better due to your ratings and reviews — that helps us protect your accounts.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: MyFonts.w500,
                      ),
                    ),
                  ),
                const Spacer(),
                MainButton(
                  title: 'Continue',
                  horizontalPadding: 16,
                  onPressed: onContinue,
                ),
                const SizedBox(height: 32),
                MyButton(
                  onPressed: () {},
                  minSize: 20,
                  child: Text(
                    'Terms of use  |  Privacy Policy',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.active,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 3,
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
