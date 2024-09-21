class Superhero {
  final String name;
  final int id;
  final Map<String, String> images;
  final Appearance appearance;
  final Biography biography;
  final Work work;
  final Connections connections;

  Superhero({
    required this.name,
    required this.id,
    required this.images,
    required this.appearance,
    required this.biography,
    required this.work,
    required this.connections
  });

  String? getImageUrl(String size) {
      return images[size] ?? images['md']; 
}

  factory Superhero.fromJson(Map<String, dynamic> json) {
    return Superhero(
      name: json['name'] as String,
      id: json['id'] as int,
      images: Map<String, String>.from(json['images']),
      appearance: Appearance.fromJson(json['appearance'] ?? {}),
      biography: Biography.fromJson(json['biography'] ?? {}),
      work: Work.fromJson(json['work'] ?? {}),
      connections: Connections.fromJson(json['connections'] ?? {})
    );
  }
}

class Appearance {
  final String gender;
  final String race;
  final List<String> height;
  final List<String> weight;
  final String eyeColor;
  final String hairColor;

  Appearance({
    required this.gender,
    required this.race,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
  });

  // Create fromJson factory method
  factory Appearance.fromJson(Map<String, dynamic> json) {
    return Appearance(
      gender: json['gender'] ?? 'Unknown',
      race: json['race'] ?? 'Unknown',
      height: List<String>.from(json['height'] ?? ['Unknown']),
      weight: List<String>.from(json['weight'] ?? ['Unknown']),
      eyeColor: json['eyeColor'] ?? 'Unknown',
      hairColor: json['hairColor'] ?? 'Unknown',
    );
  }
}

class Biography {
  final String fullName;
  final String alterEgos;
  final List<String> aliases;
  final String placeOfBirth;
  final String firstAppearance;
  final String publisher;
  final String alignment;

  Biography({
    required this.fullName,
    required this.alterEgos,
    required this.aliases,
    required this.placeOfBirth,
    required this.firstAppearance,
    required this.publisher,
    required this.alignment,
  });

  factory Biography.fromJson(Map<String, dynamic> json) {
    return Biography(
      fullName: json['fullName'] ?? 'Unknown',
      alterEgos: json['alterEgos'] ?? 'None',
      aliases: List<String>.from(json['aliases'] ?? ['None']),
      placeOfBirth: json['placeOfBirth'] ?? 'Unknown',
      firstAppearance: json['firstAppearance'] ?? 'Unknown',
      publisher: json['publisher'] ?? 'Unknown',
      alignment: json['alignment'] ?? 'neutral',
    );
  }
}

class Work {
  final String occupation;
  final String base;

  Work({
    required this.occupation,
    required this.base,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      occupation: json['occupation'] ?? 'Unknown',
      base: json['base'] ?? 'Unknown'
    );
  }
}

class Connections{
  final String groupAffiliation;
  final String relatives;

  Connections({
    required this.groupAffiliation,
    required this.relatives
  });

  factory Connections.fromJson(Map<String, dynamic> json) {
    return Connections(
      groupAffiliation: json['occupation'] ?? 'Unknown',
      relatives: json['base'] ?? 'Unknown'
    );
  }
}