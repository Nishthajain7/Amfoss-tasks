class Superhero {
  final String name;
  final int id;
  final Map<String, String> images;

  Superhero({required this.name, required this.id, required this.images});

  factory Superhero.fromJson(Map<String, dynamic> json) {
    return Superhero(
      name: json['name'],
      id: json['id'] ?? '',
      images: Map<String, String>.from(json['images']), // Parse images map
    );
  }

  // Helper method to get image by size
  String? getImageUrl(String size) {
    return images[size] ?? images['md']; // Default to 'md' if size not found
  }
}