class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final List<String> images;
  final List<String> sizes;
  final List<String> colors;
  final String category;
  final String collectionId;
  final bool isOnSale;
  final bool inStock;
  final String sku;
  final List<String> features;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.images,
    required this.sizes,
    required this.colors,
    required this.category,
    required this.collectionId,
    this.isOnSale = false,
    this.inStock = true,
    required this.sku,
    required this.features,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  int get discountPercentage {
    if (originalPrice == null || originalPrice! <= price) return 0;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }

 double get savings{
    if (originalPrice == null || originalPrice! <= price) return 0;
    return originalPrice! - price;
  }
}
