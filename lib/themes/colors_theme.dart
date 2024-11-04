import 'package:flutter/material.dart';

class ThemeColor {
  static const Color primary = Color(0xffd6e2ea);
  static const Color white = Color(0xffffffff);
  static const Color black = Color.fromARGB(255, 48, 48, 48);

  static const Color grey = Color.fromARGB(255, 59, 59, 59);
  static const Color darkGrey = Color(0xff121212);
  static const Color red = Color(0xffFF4144);
  // static const Color lightRed = Color(0xffFF5A5A);
  static const Color orange = Color(0xffFF9232);
  static const Color yellow = Color(0xffF9C74F);
  static const Color pastelOrange = Color(0xffF9844A);
  static const Color green = Color(0xff90BE6D);
  static const Color teal = Color(0xff43AA8B);
  static const Color blue = Color(0xff277DA1);

  static const Color darkTeal = Color(0xff4D908E);
  static const Color muteBlue = Color(0xff577590);
  static const Color textPrimary = Color(0xff3c4144);
  static const Color textSecondary = Color(0xff8B8C8D);

  // Material colors

  static const MaterialColor whiteMat = MaterialColor(0xffffffff, myColorMap);
  static const MaterialColor blueMat = MaterialColor(0xff277DA1, myColorMap);
// Dark theme
  static const MaterialColor darkMat = MaterialColor(0x362E2C, myColorMap);
  static const MaterialColor darkBlueMat = MaterialColor(0x767FCC, myColorMap);
  // static const Color grey_50 = Color(0xffFAFAFA);
  // static const Color grey_100 = Color(0xffF5F5F5);
  // static const Color grey_200 = Color(0xffEEEEEE);
  // static const Color grey_300 = Color(0xffE0E0E0);
  // static const Color grey_400 = Color(0xffBDBDBD);
  // static const Color grey_500 = Color(0xff9E9E9E);
  // static const Color grey_800 = Color(0xff424242);
}

//---------------Themes settings here-----------
class MyThemes {
  //-------------DARK THEME SETTINGS----
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff121212),
    primaryColorDark: const Color(0xffFFFFFF),
    // colorScheme:  ColorScheme.dark(),
  );

  //-------------light THEME SETTINGS----
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffFFFFFF),
    primaryColorDark: const Color(0xff121212),
    //colorScheme:  ColorScheme.light(),
  );
}

const Map<int, Color> myColorMap = {
  50: Color.fromRGBO(12, 120, 255, 0.1),
  100: Color.fromRGBO(12, 120, 255, 0.2),
  200: Color.fromRGBO(12, 120, 255, 0.3),
  300: Color.fromRGBO(12, 120, 255, 0.4),
  400: Color.fromRGBO(12, 120, 255, 0.5),
  500: Color.fromRGBO(12, 120, 255, 0.6),
  600: Color.fromRGBO(12, 120, 255, 0.7),
  700: Color.fromRGBO(12, 120, 255, 0.8),
  800: Color.fromRGBO(12, 120, 255, 0.9),
  900: Color.fromRGBO(12, 120, 255, 1.0),
};
