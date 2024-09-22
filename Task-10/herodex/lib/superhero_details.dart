// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'superhero.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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
            Center(child: Image.network(superhero.getImageUrl('lg') ?? '',)),
            const SizedBox(height: 16.0),
            
            // Powerstat
            const Text('Powerstats', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              shrinkWrap: true,
              children: [
                buildStatBox('Intelligence', superhero.powerstats.intelligence),
                buildStatBox('Strength', superhero.powerstats.strength),
                buildStatBox('Speed', superhero.powerstats.speed),
                buildStatBox('Durability', superhero.powerstats.durability),
                buildStatBox('Power', superhero.powerstats.power),
                buildStatBox('Combat', superhero.powerstats.combat),
  ],
            ),

            // Appearance 
            Text('Appearance', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            appearanceRow('Gender', superhero.appearance.gender),
            appearanceRow('Race', superhero.appearance.race),
            appearanceRow('Height', superhero.appearance.height.join(", ")),
            appearanceRow('Weight', superhero.appearance.weight.join(", ")),
            appearanceRow('Eye Color', superhero.appearance.eyeColor),
            appearanceRow('Hair Color', superhero.appearance.hairColor),
            const SizedBox(height: 16.0),
            
            // Biography
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
          flex: 2,
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
            textAlign: TextAlign.left,
          ),
        ),
      ],
      ),
    );
  }

  Widget buildStatBox(String stat, int value) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.blueAccent.withOpacity(0.2),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.blueAccent, width: 2),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(getIconForStat(stat), size: 40, color: Colors.blueAccent),
        const SizedBox(height: 10),
        Text(
          stat.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          '$value',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    ),
  );
}

  IconData getIconForStat(String stat) {
  switch (stat.toLowerCase()) {
    case 'intelligence':
      return FontAwesomeIcons.brain;
    case 'strength':
      return FontAwesomeIcons.dumbbell;
    case 'speed':
      return FontAwesomeIcons.bolt;
    case 'durability':
      return FontAwesomeIcons.shieldAlt;
    case 'power':
      return FontAwesomeIcons.superpowers;
    case 'combat':
      return FontAwesomeIcons.fistRaised;
    default:
      return FontAwesomeIcons.question;
  }
}
}