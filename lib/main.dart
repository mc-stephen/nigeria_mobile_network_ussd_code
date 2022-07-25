import 'dart:io';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:naija_network_ussd_code/routes/route.dart' as route;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  await Hive.openBox('mtn');
  await Hive.openBox('glo');
  await Hive.openBox('airtel');
  await Hive.openBox('9mobile');
  await Hive.openBox('onlineData');
  await Hive.openBox<bool>('theme');

  runApp(const MaterialApp(
    initialRoute: route.homePage,
    onGenerateRoute: route.controller,
    debugShowCheckedModeBanner: false,
  ));
}
