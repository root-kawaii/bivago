import 'package:flutter/material.dart';
import '../themes/themeSelector.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<Widget> themeHue = <Widget>[Text('Dark'), Text('Light')];

class ChangeThemeButtonWidget extends StatefulWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<ChangeThemeButtonWidget> {
  int _selectedTheme = 0;
  List<bool> _selection = <bool>[true, false];
  bool vertical = false;

  Future<void> _saveSetting(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_theme', value);
  }

  Future<void> _loadSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedTheme = prefs.getInt('selected_theme') ?? 0;
    if (_selectedTheme == 0) {
      _selection = [true, false];
    }
    if (_selectedTheme == 1) {
      _selection = [false, true];
    }
  }

  @override
  void initState() {
    super.initState();
    // Call your function here
    _loadSetting();
  }

  @override
  Widget build(BuildContext context) {
    //----First we want to get the theme provider----
    final themeProvider = Provider.of<ThemeSelector>(context);

    return ToggleButtons(
      direction: vertical ? Axis.vertical : Axis.horizontal,
      onPressed: (int index) {
        var provider = Provider.of<ThemeSelector>(context, listen: false);
        provider.toggleTheme(themeHue, index);
        // The button that is tapped is set to true, and the others to false.
        _saveSetting(index);
        _loadSetting();
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.red[700],
      selectedColor: Colors.white,
      fillColor: Colors.red[200],
      color: Colors.red[400],
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      isSelected: _selection,
      children: themeHue,
    );
  }
}
