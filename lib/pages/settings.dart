import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../themes/themeButton.dart";

const List<Widget> themeHue = <Widget>[Text('Dark'), Text('Light')];

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _controller = TextEditingController();
  String _savedSetting = '';
  final List<bool> _selectedTherme = <bool>[true, false];
  bool vertical = false;

  @override
  void initState() {
    super.initState();
    _loadSetting();
  }

  Future<void> _loadSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedSetting = prefs.getString('mySetting') ?? '';
    });
  }

  Future<void> _saveSetting(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mySetting', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              final result = await _showSettingsDialog(context);
              if (result != null) {
                _saveSetting(result);
              }
            },
          ),
        ],
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text('Saved Setting: $_savedSetting'),
          const SizedBox(
            height: 20,
          ),
          const Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Select Theme        "),
            ChangeThemeButtonWidget(),
          ]),
        ],
      )),
    );
  }

  Future<String?> _showSettingsDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Enter Setting'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
