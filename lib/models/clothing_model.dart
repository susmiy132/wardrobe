class Clothing {
  final String id;
  final String name;
  final String category;
  final String color;
  final String season;
  final String occasion;
  final String image;

  Clothing({
    required this.id,
    required this.name,
    required this.category,
    required this.color,
    required this.season,
    required this.occasion,
    required this.image,

  });

  factory Clothing.fromJson(Map<String, dynamic> json) {
    return Clothing(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      color: json['color'],
      season: json['season'],
      occasion: json['occasion'],
      image: json['image']
    );
  }
}