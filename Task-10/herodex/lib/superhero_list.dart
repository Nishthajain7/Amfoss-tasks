import 'package:flutter/material.dart';
import 'superhero.dart';
import 'dart:convert';
import 'package:flutter/services.dart'; 
import 'superhero_details.dart';

class SuperheroListScreen extends StatefulWidget {
  const SuperheroListScreen({super.key});

  @override
  _SuperheroListScreenState createState() => _SuperheroListScreenState();
}

class _SuperheroListScreenState extends State<SuperheroListScreen> {
  List<Superhero> _superheroes = [];
  List<Superhero> _filteredSuperheroes = [];

  @override
  void initState() {
    super.initState();
    _loadSuperheroes(); 
  }

  void _loadSuperheroes() async {
  try {
    final String response = await rootBundle.loadString('lib/superhero.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _superheroes = data.map((json) => Superhero.fromJson(json as Map<String, dynamic>)).toList();
      _filteredSuperheroes = _superheroes;
    });
  } catch (error) {
    print('Error loading superheroes: $error');
  }
}

  // Search
  void _filterSuperheroes(String query) {
    final filtered = _superheroes.where((superhero) {
      return superhero.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _filteredSuperheroes = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search Superheroes...',
          ),
          onChanged: _filterSuperheroes,
      ),
    ),
    body: _filteredSuperheroes.isEmpty
        ? const Center(child: Text('No superheroes found.'))
        : ListView.builder(
            itemCount: _filteredSuperheroes.length,
            itemBuilder: (context, index) {
              final superhero = _filteredSuperheroes[index];
              return ListTile(
                leading: Image.network(superhero.getImageUrl('sm') ?? 'https://example.com/default_image.jpg'),
                title: Text(superhero.name),
                subtitle: Text('ID: ${superhero.id}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuperheroDetailsScreen(superhero: superhero),
                    ),
                  );
                },
              );
            },
          ),
  );
}


  //  Superheroes list
  Widget _buildSuperheroList() {
    return ListView.builder(
      itemCount: _filteredSuperheroes.length,
      itemBuilder: (context, index) {
        final superhero = _filteredSuperheroes[index];
        return ListTile(
          leading: Image.network(superhero.getImageUrl('lg') ?? '',),
          title: Text(superhero.name),
          subtitle: Text('ID: ${superhero.id}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuperheroDetailsScreen(superhero: superhero),
      ),
    );
  },
);


      },
    );
  }
}