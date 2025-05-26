import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('O aplikacji')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filmy TMDB',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Aplikacja edukacyjna stworzona w Flutterze do przeglądania popularnych filmów z wykorzystaniem API TMDB.',
            ),
            SizedBox(height: 16),
            Text('Autor: Dawid Bodzęta'),
            Text('Wersja: 1.0.0'),
          ],
        ),
      ),
    );
  }
}
