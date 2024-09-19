import 'package:flutter/material.dart';
import 'superhero_list.dart'; // Import the list screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superhero Encyclopedia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SuperheroListScreen(), // Set the home screen to SuperheroListScreen
    );
  }
}
