import 'package:naija_network_ussd_code/pages/airtel.dart';
import 'package:naija_network_ussd_code/pages/etisalat.dart';
import 'package:naija_network_ussd_code/pages/glo.dart';
import 'package:naija_network_ussd_code/pages/home.dart';
import 'package:naija_network_ussd_code/pages/mtn.dart';
import 'package:flutter/material.dart';

//==================================================
// PAGES NAMES SAVE AS VARIABLES
//==================================================
const String homePage = 'home';
const String mtnPage = 'mtn';
const String airtelPage = 'airtel';
const String etisalatPage = '9mobile';
const String gloPage = 'glo';

//================================================================
// A ROUTE CONTROLLER SWITCH STATEMENT FOR EACH PAGES IN THE APP
//================================================================
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const Home());
    case mtnPage:
      return MaterialPageRoute(builder: (context) => const Mtn());
    case airtelPage:
      return MaterialPageRoute(builder: (context) => const Airtel());
    case etisalatPage:
      return MaterialPageRoute(builder: (context) => const Etisalat());
    case gloPage:
      return MaterialPageRoute(builder: (context) => const Glo());
    default:
      throw ('This route name does not exist');
  }
}
