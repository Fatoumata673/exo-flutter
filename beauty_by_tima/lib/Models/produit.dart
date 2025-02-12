class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String imageUrl;
  final String description;
  bool isFavorite;
  int quantity;
  
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
    this.quantity = 1,
  });
}