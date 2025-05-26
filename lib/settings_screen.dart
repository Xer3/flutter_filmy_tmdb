import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingsScreen({
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ustawienia')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Ciemny motyw'),
            value: isDarkMode,
            onChanged: onThemeChanged,
          ),
          ListTile(
            title: Text('O aplikacji'),
            leading: Icon(Icons.info_outline),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }
}
