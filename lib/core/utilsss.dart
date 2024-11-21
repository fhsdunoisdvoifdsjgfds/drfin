import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/incom.dart';

bool onboard = true;
List<Incom> incomsList = [];

Future<void> init() async {
  try {
    await Hive.initFlutter();
    final pref = await SharedPreferences.getInstance();
    onboard = pref.getBool('onboard') ?? true;
    Hive.registerAdapter(IncomAdap());
  } catch (_) {}
}

Future<void> getIncoms() async {
  try {
    final mybox = await Hive.openBox('darkfinbox');
    List data = mybox.get('darkfinincomsList') ?? [];
    incomsList = data.cast<Incom>();
  } catch (_) {}
}

Future<void> updateIncoms() async {
  try {
    final mybox = await Hive.openBox('darkfinbox');
    mybox.put('darkfinincomsList', incomsList);
    incomsList = await mybox.get('darkfinincomsList');
  } catch (_) {}
}

int getTimestamp() => DateTime.now().millisecondsSinceEpoch ~/ 1000;
String formatNumber(int number) => NumberFormat('#,###').format(number);
double getStatusBar(BuildContext context, {int height = 0}) =>
    MediaQuery.of(context).viewPadding.top + height;
double getBot(BuildContext context) =>
    MediaQuery.of(context).viewPadding.bottom;
double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

int getBalance() {
  int total = 0;
  for (Incom incom in incomsList) {
    total += incom.amount;
  }
  print(total);
  return total;
}
