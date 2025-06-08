class FoodItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final String weight;
  final String imagePath;
  final String description;
  final double rating;
  final bool isPopular;
  final bool isBestSeller;

  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.weight,
    required this.imagePath,
    required this.description,
    required this.rating,
    required this.isPopular,
    this.isBestSeller = false,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      weight: json['weight'] ?? '',
      imagePath: json['imagePath'] ?? '',
      description: json['description'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      isPopular: json['isPopular'] ?? false,
      isBestSeller: json['isBestSeller'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'weight': weight,
      'imagePath': imagePath,
      'description': description,
      'rating': rating,
      'isPopular': isPopular,
      'isBestSeller': isBestSeller,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
