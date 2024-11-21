import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/router_config.dart';
import 'core/config/dark_theme.dart';
import 'blocs/btn/btn_bloc.dart';
import 'blocs/nav/nav_bloc.dart';
import 'blocs/incom/incom_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyAppp());
}

class MyAppp extends StatelessWidget {
  const MyAppp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/onboarding.png'), context);
    precacheImage(const AssetImage('assets/onboarding2.png'), context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return IncomBloc()..add(IncomGet());
          },
        ),
        BlocProvider(
          create: (context) {
            return NavBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return BtnBloc();
          },
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        darkTheme: darkTheme,
        routerConfig: routerConfig,
      ),
    );
  }
}
