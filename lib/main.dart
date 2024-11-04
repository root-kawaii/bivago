import 'package:flutter/material.dart';
import 'package:bivago/pages/home.dart';
import 'package:bivago/pages/registerPage.dart';
// import 'package:bivago/state/homeState.dart';
import 'themes/colors_theme.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'themes/themeSelector.dart';
import 'package:provider/provider.dart';
import 'state/boardState.dart';
import 'state/homeState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'kTRyZF5LiLTo1kiQbhldomqPfAhIhqyITzlt4Ll1';
  const keyClientKey = 'XMdCQhOw3rbHpcJJzJnPrQPJgwcQtEHygKRgp6eo';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  // MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(create: (_) => BoardState()),
  //   ],
  //   child: MyApp(),
  // );
  // super.initState();
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeState()),
          ChangeNotifierProvider(create: (_) => BoardState()),
          ChangeNotifierProvider(create: (context) => ThemeSelector())
        ],
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeSelector>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            themeMode: themeProvider.themeSelected,
            home: HomePage(),
          );
        });
  }
}
