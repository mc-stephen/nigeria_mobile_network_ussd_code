import 'package:flutter/material.dart';

// the defalut value for the light theme
bool lightTheme = true;

//==================================================
// FOR THE LIGHT AND DARK THEM OF THE APP
//==================================================
class ThemeColor {
  Color lightOpacity =
      lightTheme == true ? const Color(0xfff5f5f5) : const Color(0xff1A1A40);
  Color textColor = lightTheme == true ? Colors.black : Colors.white;
  Color primaryColor = lightTheme == true
      ? Colors.indigo.withOpacity(0.9)
      : const Color(0xff270082);
  Color primaryTextColor = lightTheme == true ? Colors.white : Colors.white;
  Color secondaryColor = lightTheme == true ? Colors.white : Colors.grey;
  Color shadowColor =
      lightTheme == true ? const Color(0xff999999) : const Color(0xff270082);
}
