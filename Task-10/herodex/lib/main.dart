import 'package:flutter/material.dart';
import 'superhero_list.dart'; // Import the list screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superhero Encyclopedia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SuperheroListScreen(), // Set the home screen to SuperheroListScreen
    );
  }
}
