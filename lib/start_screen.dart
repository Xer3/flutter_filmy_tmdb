import 'package:flutter/material.dart';
import 'home_screen.dart';

class StartScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const StartScreen({required this.isDarkMode, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wybierz kategorię')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CategoryButton(
              label: 'Popularne',
              category: 'popular',
              isDarkMode: isDarkMode,
              onThemeChanged: onThemeChanged,
            ),
            SizedBox(height: 16),
            CategoryButton(
              label: 'Top oceny',
              category: 'top_rated',
              isDarkMode: isDarkMode,
              onThemeChanged: onThemeChanged,
            ),
            SizedBox(height: 16),
            CategoryButton(
              label: 'Nadchodzące',
              category: 'upcoming',
              isDarkMode: isDarkMode,
              onThemeChanged: onThemeChanged,
            ),
            SizedBox(height: 16),
            CategoryButton(
              label: 'W kinach',
              category: 'now_playing',
              isDarkMode: isDarkMode,
              onThemeChanged: onThemeChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final String category;
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const CategoryButton({
    required this.label,
    required this.category,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48),
        textStyle: TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => HomeScreen(
                  isDarkMode: isDarkMode,
                  onThemeChanged: onThemeChanged,
                  category: category,
                ),
          ),
        );
      },
      child: Text(label),
    );
  }
}
