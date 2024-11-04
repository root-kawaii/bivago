import 'package:flutter/material.dart';

//---This to switch theme from Switch button----
class ThemeSelector extends ChangeNotifier {
  //-----Store the theme of our app--
  ThemeMode themeSelected = ThemeMode.dark;

  //----If theme mode is equal to dark then we return True----
  //-----isDarkMode--is the field we will use in our switch---
  bool get isDarkMode => themeSelected == ThemeMode.dark;

  //---implement ToggleTheme function----
  void toggleTheme(List<Widget> themesList, index) {
    switch (index) {
      case 0:
        themeSelected = ThemeMode.dark;
        print('You chose an apple');
        break;
      case 1:
        themeSelected = ThemeMode.light;
        print('You chose a banana');
        break;
      default:
        print('Unknown fruit');
    }

    //---notify material app to update UI----
    notifyListeners();
  }
}
