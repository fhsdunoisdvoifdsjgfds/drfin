import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utilsss.dart';
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
    } else {
      setState(() {
        index++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
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
                        color: const Color(0xFF222222),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 94,
                            spreadRadius: -30,
                            offset: const Offset(0, 40),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          SizedBox(height: 44),
                          Text(
                            'Sarah Johnson',
                            style: TextStyle(
                              color: Color(0xffFEDB35),
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'TSafer has completely transformed how I manage my finances. The intuitive interface makes tracking income and expenses effortless, while the built-in currency converter helps me make quick financial decisions. The smart categorization system gives me a clear picture of my spending patterns.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
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
                        color: const Color(0xFF222222),
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
                          color: const Color(0xFF222222),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              5,
                              (index) => const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Icon(
                                  CupertinoIcons.star_fill,
                                  color: Color(0xffFEDB35),
                                  size: 14,
                                ),
                              ),
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
              color: Color(0xFF222222),
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
                      'Take Control of Your Finances\nTrack, Convert, Grow',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                if (index == 2)
                  const Text(
                    'Join Our Community',
                    style: TextStyle(
                      color: Color(0xffFEDB35),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                if (index == 2) const Spacer(),
                if (index == 2)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Your feedback drives our innovation. Help us make TSafer even better for managing your finances.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                const Spacer(),
                Container(
                  height: 56,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xffFEDB35),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: CupertinoButton(
                    onPressed: onContinue,
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Color(0xFF181818),
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                CupertinoButton(
                  onPressed: () {},
                  minSize: 20,
                  child: Text(
                    'Terms of use  |  Privacy Policy',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
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
          color: active ? const Color(0xffFEDB35) : const Color(0xFF222222),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
