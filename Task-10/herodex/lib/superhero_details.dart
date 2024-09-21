import 'package:flutter/material.dart';
import 'superhero.dart';


class SuperheroDetailsScreen extends StatelessWidget {
  final Superhero superhero;

  const SuperheroDetailsScreen({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(superhero.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display large image
            Center(child: Image.network(superhero.getImageUrl('lg') ?? '',)),
            const SizedBox(height: 16.0),
            
            // Appearance section
            Text('Appearance', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            appearanceRow('Gender', superhero.appearance.gender),
            appearanceRow('Race', superhero.appearance.race),
            appearanceRow('Height', superhero.appearance.height.join(", ")),
            appearanceRow('Weight', superhero.appearance.weight.join(", ")),
            appearanceRow('Eye Color', superhero.appearance.eyeColor),
            appearanceRow('Hair Color', superhero.appearance.hairColor),
            const SizedBox(height: 16.0),
            
            // Biography section
            Text('Biography', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            appearanceRow('Full Name', superhero.biography.fullName),
            appearanceRow('Alter Egos', superhero.biography.alterEgos),
            appearanceRow('Place of Birth', superhero.biography.placeOfBirth),
            appearanceRow('First Appearance', superhero.biography.firstAppearance),
            appearanceRow('Publisher', superhero.biography.publisher),
            appearanceRow('Alignment', superhero.biography.alignment),
            const SizedBox(height: 16.0),
            
            // Work section
            Text('Work', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            appearanceRow('Occupation', superhero.work.occupation),
            appearanceRow('Base', superhero.work.base),
            const SizedBox(height: 16.0),

            // Connections section
            Text('Connections', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            appearanceRow('Group Affiliation', superhero.connections.groupAffiliation),
            appearanceRow('Relatives', superhero.connections.relatives),
          ],
        ),
      ),
    );
  }
  Widget appearanceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
        Expanded(
          flex: 2, // Adjust the flex based on how much space you need
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.left, // Align the value left
          ),
        ),
      ],
      ),
    );
  }
}
