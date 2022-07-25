import 'package:flutter/material.dart';
import 'package:nigeria_mobile_network_ussd_code/pages/code.dart';
import 'package:nigeria_mobile_network_ussd_code/pages/home.dart';
import 'package:nigeria_mobile_network_ussd_code/components/component.dart';

//==================================================
// PAGES NAMES SAVE AS VARIABLES
//==================================================
const String homePage = 'homePage';
const String codePage = 'codePage';

//===================================================
/// GLOBAL CONTEXT
//===================================================
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//================================================================
// A ROUTE CONTROLLER SWITCH STATEMENT FOR EACH PAGES IN THE APP
//================================================================
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const Home());
    case codePage:
      CodePageArgument argument = settings.arguments as CodePageArgument;
      return MaterialPageRoute(
        builder: (context) => CodePage(argument: argument),
      );
    default:
      throw ('This route name does not exist');
  }
}
