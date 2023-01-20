import 'package:app_themes_bakapp/src/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_themes_bakapp/src/screens/launcher_screen.dart';
import 'package:app_themes_bakapp/src/share_preferences/preferences.dart';
import 'package:app_themes_bakapp/src/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeChanger(1),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDarkMode: Preferences.isDarkMode),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// Este Widget le da inicio a la aplicacion.

  @override
  Widget build(BuildContext context) {
    //Usando Providers, sin dejarlo alojado en la memoria
    //del dispositivo
    final appTheme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temas para nuestra app, usando Provider',
      //Sin preferencias
      //theme: appTheme.currentTheme,

      //Con preferencias
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: LauncherScreen(),
    );
  }
}
