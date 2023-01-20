import 'package:app_themes_bakapp/src/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_themes_bakapp/src/theme/theme.dart';
import 'package:app_themes_bakapp/src/share_preferences/preferences.dart';


class LauncherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //body: const _ListaOptions(),
      body: const _ListFija(),
      drawer: const _Menu(),
    );
  }
}

class _ListaOptions extends StatelessWidget {
  const _ListaOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: 25,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.blue,
      ),
      itemBuilder: (BuildContext context, int index) => const ListTile(
        leading: Icon(Icons.slideshow),
        title: Text('hola'),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: size.height * 0.2,
                child: const CircleAvatar(
                  child: Text(
                    'RB',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: _ListaOptions(),
            ),
            const _ListFija()
          ],
        ),
      ),
    );
  }
}

class _ListFija extends StatefulWidget {
  const _ListFija({super.key});

  @override
  State<_ListFija> createState() => _ListFijaState();
}

class _ListFijaState extends State<_ListFija> {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);

    return Container(
        child: Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        ListTile(
          leading: const Icon(
            Icons.lightbulb_outline,
            color: Colors.lightBlue,
          ),
          title: const Text('Dark Mode'),
          trailing: Switch.adaptive(
            value: appTheme.darkTheme,
            onChanged: (value) {
              appTheme.darkTheme = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.lightbulb_outline,
            color: Colors.lightBlue,
          ),
          title: const Text('Custom Theme'),
          trailing: Switch.adaptive(value: appTheme.customTheme, onChanged: (value) {
            appTheme.customTheme = value;
          }),
        ),
        ListTile(
          leading: const Icon(
            Icons.lightbulb_outline,
            color: Colors.lightBlue,
          ),
          title: const Text('Dark Mode Preferencias'),
          trailing: Switch.adaptive(
            value: Preferences.isDarkMode,
            onChanged: (value) {
              setState(() {
                Preferences.isDarkMode = value;
                final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                value ? themeProvider.setDarkMode() : themeProvider.setLightMode();
              });
            },
          ),
        ),
      ],
    ));
  }
}
