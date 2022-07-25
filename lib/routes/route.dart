import 'package:flutter/material.dart';
import 'package:naija_network_ussd_code/pages/code.dart';
import 'package:naija_network_ussd_code/pages/home.dart';

//==================================================
// PAGES NAMES SAVE AS VARIABLES
//==================================================
const String homePage = 'homePage';
const String codePage = 'codePage';

//================================================================
// A ROUTE CONTROLLER SWITCH STATEMENT FOR EACH PAGES IN THE APP
//================================================================
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const Home());
    case codePage:
      return MaterialPageRoute(builder: (context) => const Mtn());
    default:
      throw ('This route name does not exist');
  }
}
