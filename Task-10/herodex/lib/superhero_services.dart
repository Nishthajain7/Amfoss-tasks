import 'dart:convert';
import 'package:flutter/services.dart';
import 'superhero.dart';

class SuperheroService {
  Future<List<Superhero>> loadSuperheroes() async {
    final String response = await rootBundle.loadString('superheroes.json');
    final data = await json.decode(response);
    return (data as List).map((json) => Superhero.fromJson(json)).toList();
  }
}
