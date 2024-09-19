import 'package:flutter/material.dart';
import 'superhero.dart';


class SuperheroDetailsScreen extends StatelessWidget {
  final Superhero superhero;

  // Constructor to receive the Superhero object
  const SuperheroDetailsScreen({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(superhero.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Display the large version of the superhero's image
            Image.network(superhero.getImageUrl('lg') ?? '',),
            const SizedBox(height: 20),
            Text(
              superhero.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Id: ${superhero.id}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            // You can add more details about the superhero here
          ],
        ),
      ),
    );
  }
}
