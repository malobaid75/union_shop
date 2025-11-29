import '../models/product.dart';
import '../models/collection.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  // Collections Data
  final List<Collection> collections = [
    Collection(
      id: 'clothing',
      name: 'Clothing',
      description: 'Hoodies, t-shirts, jackets and more',
      image:'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=800&h=600&fit=crop',
      itemCount: 12,
      colorHex: '4A90E2',
    ),
    Collection(
      id: 'accessories',
      name: 'Accessories',
      description: 'Bags, hats, pins and accessories',
      image: 'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=800&h=600&fit=crop',
      itemCount: 8,
      colorHex: 'E74C3C',
    ),
    Collection(
      id: 'stationery',
      name: 'Stationery',
      description: 'Notebooks, pens, and study essentials',
      image:'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=300&fit=crop',
      itemCount: 10,
      colorHex: 'F39C12',
    ),
    Collection(
      id: 'drinkware',
      name: 'Drinkware',
      description: 'Mugs, bottles, and tumblers',
      image:'https://images.unsplash.com/photo-1525385133512-2f3bdd039054?w=400&h=300&fit=crop',
      itemCount: 6,
      colorHex: '27AE60',
    ),
    Collection(
      id: 'tech',
      name: 'Tech & Gadgets',
      description: 'Phone cases, USB drives, tech accessories',
      image: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400&h=300&fit=crop',
      itemCount: 7,
      colorHex: '8E44AD',
    ),
    Collection(
      id: 'sports',
      name: 'Sports & Fitness',
      description: 'Gym wear, water bottles, sports gear',
      image: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=300&fit=crop',
      itemCount: 9,
      colorHex: '16A085',
    ),
  ];

  // Products Data
final List<Product> products = [
  // Clothing
  Product(
    id: 'prod_001',
    name: 'University Hoodie',
    description: 'Show your university pride with this premium quality hoodie. Made from a comfortable cotton-polyester blend, featuring the official University of Portsmouth logo.',
    price: 35.00,
    originalPrice: 45.00,
    images: [
      'https://picsum.photos/seed/hoodie-navy-1/800/800',
      'https://picsum.photos/seed/hoodie-navy-2/800/800',
      'https://picsum.photos/seed/hoodie-navy-3/800/800',
    ],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    colors: ['Navy', 'Black', 'Grey'],
    category: 'Clothing',
    collectionId: 'clothing',
    sku: 'UOP-HOD-001',
    features: ['80% Cotton, 20% Polyester', 'Embroidered logo', 'Kangaroo pocket', 'Machine washable'],
    rating: 4.5,
    reviewCount: 128,
  ),
  Product(
    id: 'prod_002',
    name: 'Campus T-Shirt',
    description: 'Classic university t-shirt perfect for everyday wear. Soft cotton fabric with printed logo.',
    price: 18.00,
    images: [
      'https://picsum.photos/seed/tshirt-white-1/800/800',
      'https://picsum.photos/seed/tshirt-white-2/800/800',
    ],
    sizes: ['XS', 'S', 'M', 'L', 'XL'],
    colors: ['White', 'Black', 'Navy', 'Grey'],
    category: 'Clothing',
    collectionId: 'clothing',
    sku: 'UOP-TSH-001',
    features: ['100% Cotton', 'Printed logo', 'Crew neck', 'Machine washable'],
    rating: 4.3,
    reviewCount: 95,
  ),
  Product(
    id: 'prod_003',
    name: 'Varsity Jacket',
    description: 'Premium varsity jacket with embroidered patches. Perfect for showing school spirit.',
    price: 55.00,
    originalPrice: 70.00,
    images: [
      'https://picsum.photos/seed/jacket-varsity-1/800/800',
      'https://picsum.photos/seed/jacket-varsity-2/800/800',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Navy', 'Black'],
    category: 'Clothing',
    collectionId: 'clothing',
    isOnSale: true,
    sku: 'UOP-JAC-001',
    features: ['Wool blend body', 'Leather sleeves', 'Embroidered patches', 'Snap buttons'],
    rating: 4.7,
    reviewCount: 42,
  ),
  Product(
    id: 'prod_004',
    name: 'Zip-Up Hoodie',
    description: 'Comfortable zip-up hoodie with university branding. Great for layering.',
    price: 40.00,
    originalPrice: 50.00,
    images: [
      'https://picsum.photos/seed/zip-hoodie-1/800/800',
    ],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    colors: ['Grey', 'Navy', 'Black'],
    category: 'Clothing',
    collectionId: 'clothing',
    isOnSale: true,
    sku: 'UOP-ZHD-001',
    features: ['80% Cotton, 20% Polyester', 'Full zip front', 'Two pockets', 'Drawstring hood'],
    rating: 4.4,
    reviewCount: 67,
  ),
  Product(
    id: 'prod_005',
    name: 'Polo Shirt',
    description: 'Smart casual polo shirt with embroidered university crest.',
    price: 24.00,
    images: [
      'https://picsum.photos/seed/polo-navy-1/800/800',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['White', 'Navy', 'Black'],
    category: 'Clothing',
    collectionId: 'clothing',
    sku: 'UOP-POL-001',
    features: ['100% Cotton pique', 'Embroidered crest', 'Button placket', 'Ribbed collar'],
    rating: 4.2,
    reviewCount: 38,
  ),
  Product(
    id: 'prod_006',
    name: 'Sports Jersey',
    description: 'Breathable sports jersey for athletic activities. Moisture-wicking fabric.',
    price: 28.00,
    images: [
      'https://picsum.photos/seed/jersey-sports-1/800/800',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Blue', 'White'],
    category: 'Clothing',
    collectionId: 'clothing',
    sku: 'UOP-JER-001',
    features: ['100% Polyester', 'Moisture-wicking', 'Mesh panels', 'Printed number'],
    rating: 4.6,
    reviewCount: 54,
  ),

  // Accessories
  Product(
    id: 'prod_007',
    name: 'Premium Backpack',
    description: 'Durable backpack with laptop compartment and university branding.',
    price: 32.00,
    originalPrice: 45.00,
    images: [
      'https://picsum.photos/seed/backpack-navy-1/800/800',
    ],
    sizes: ['One Size'],
    colors: ['Navy', 'Black', 'Grey'],
    category: 'Accessories',
    collectionId: 'accessories',
    sku: 'UOP-BAG-001',
    features: ['Padded laptop sleeve', 'Multiple compartments', 'Water resistant', 'Adjustable straps'],
    rating: 4.8,
    reviewCount: 89,
  ),
  Product(
    id: 'prod_008',
    name: 'Winter Beanie',
    description: 'Warm knitted beanie with embroidered university logo.',
    price: 10.00,
    originalPrice: 15.00,
    images: [
      'https://picsum.photos/seed/beanie-grey-1/800/800',
    ],
    sizes: ['One Size'],
    colors: ['Navy', 'Grey', 'Black'],
    category: 'Accessories',
    collectionId: 'accessories',
    isOnSale: true,
    sku: 'UOP-BEA-001',
    features: ['100% Acrylic', 'Double layer knit', 'Embroidered logo', 'One size fits most'],
    rating: 4.5,
    reviewCount: 112,
  ),
  Product(
    id: 'prod_009',
    name: 'University Scarf',
    description: 'Soft knitted scarf in university colors.',
    price: 12.00,
    originalPrice: 18.00,
    images: [
      'https://picsum.photos/seed/scarf-navy-1/800/800',
    ],
    sizes: ['One Size'],
    colors: ['Navy/Gold'],
    category: 'Accessories',
    collectionId: 'accessories',
    isOnSale: true,
    sku: 'UOP-SCF-001',
    features: ['100% Acrylic', 'University colors', 'Fringed ends', '180cm length'],
    rating: 4.3,
    reviewCount: 45,
  ),
  Product(
    id: 'prod_010',
    name: 'Baseball Cap',
    description: 'Classic baseball cap with adjustable strap and embroidered logo.',
    price: 14.00,
    images: [
      'https://picsum.photos/seed/cap-navy-1/800/800',
    ],
    sizes: ['One Size'],
    colors: ['Navy', 'Black', 'White'],
    category: 'Accessories',
    collectionId: 'accessories',
    sku: 'UOP-CAP-001',
    features: ['100% Cotton twill', 'Adjustable strap', 'Embroidered logo', 'Curved brim'],
    rating: 4.4,
    reviewCount: 73,
  ),

  // Drinkware
  Product(
    id: 'prod_011',
    name: 'Ceramic Mug',
    description: 'Classic ceramic mug with university crest. Perfect for your morning coffee.',
    price: 8.00,
    images: [
      'https://picsum.photos/seed/mug-ceramic-1/800/800',
    ],
    sizes: ['One Size'],
    colors: ['White', 'Navy'],
    category: 'Drinkware',
    collectionId: 'drinkware',
    sku: 'UOP-MUG-001',
    features: ['Ceramic material', '330ml capacity', 'Dishwasher safe', 'Printed crest'],
    rating: 4.6,
    reviewCount: 156,
  ),
  Product(
    id: 'prod_012',
    name: 'Sports Water Bottle',
    description: 'BPA-free sports bottle with flip-top lid.',
    price: 8.00,
    originalPrice: 12.00,
    images: [
      'https://picsum.photos/seed/bottle-sports-1/800/800',
    ],
    sizes: ['500ml', '750ml'],
    colors: ['Blue', 'Black', 'Clear'],
    category: 'Drinkware',
    collectionId: 'drinkware',
    isOnSale: true,
    sku: 'UOP-BOT-001',
    features: ['BPA-free plastic', 'Flip-top lid', 'Carry loop', 'Dishwasher safe'],
    rating: 4.2,
    reviewCount: 88,
  ),
  Product(
    id: 'prod_013',
    name: 'Insulated Travel Mug',
    description: 'Double-walled insulated mug keeps drinks hot or cold for hours.',
    price: 15.00,
    images: [
      'https://picsum.photos/seed/mug-travel-1/800/800',
    ],
    sizes: ['One Size'],
    colors: ['Silver', 'Black', 'Navy'],
    category: 'Drinkware',
    collectionId: 'drinkware',
    sku: 'UOP-TMG-001',
    features: ['Stainless steel', 'Double-walled', '450ml capacity', 'Leak-proof lid'],
    rating: 4.7,
    reviewCount: 64,
  ),

  // Stationery
  Product(
    id: 'prod_014',
    name: 'Notebook Set',
    description: 'Set of 3 notebooks with university branding. Perfect for lectures.',
    price: 12.00,
    images: [
      'https://picsum.photos/seed/notebook-set-1/800/800',
    ],
    sizes: ['A4', 'A5'],
    colors: ['Navy', 'Black'],
    category: 'Stationery',
    collectionId: 'stationery',
    sku: 'UOP-NTB-001',
    features: ['3 notebooks per set', '80 pages each', 'Lined pages', 'Card cover'],
    rating: 4.4,
    reviewCount: 92,
  ),
  Product(
    id: 'prod_015',
    name: 'Pen Set',
    description: 'Quality ballpoint pens with university branding.',
    price: 6.00,
    images: [
      'https://picsum.photos/seed/pen-set-1/800/800',
    ],
    sizes: ['One Size'],
    colors: ['Blue Ink', 'Black Ink'],
    category: 'Stationery',
    collectionId: 'stationery',
    sku: 'UOP-PEN-001',
    features: ['5 pens per set', 'Ballpoint', 'University logo', 'Smooth writing'],
    rating: 4.1,
    reviewCount: 67,
  ),
  Product(
    id: 'prod_016',
    name: 'Laptop Sleeve',
    description: 'Protective laptop sleeve with padding and university logo.',
    price: 18.00,
    originalPrice: 25.00,
    images: [
      'https://picsum.photos/seed/laptop-sleeve-1/800/800',
    ],
    sizes: ['13 inch', '15 inch'],
    colors: ['Grey', 'Navy', 'Black'],
    category: 'Stationery',
    collectionId: 'stationery',
    isOnSale: true,
    sku: 'UOP-SLV-001',
    features: ['Neoprene material', 'Padded interior', 'Zip closure', 'Front pocket'],
    rating: 4.5,
    reviewCount: 48,
  ),

  // Tech
  Product(
    id: 'prod_017',
    name: 'Phone Case',
    description: 'Protective phone case with university design.',
    price: 12.00,
    images: [
      'https://picsum.photos/seed/phone-case-1/800/800',
    ],
    sizes: ['iPhone 14', 'iPhone 15', 'Samsung S23'],
    colors: ['Clear', 'Navy', 'Black'],
    category: 'Tech',
    collectionId: 'tech',
    sku: 'UOP-PHN-001',
    features: ['Hard shell', 'Printed design', 'Raised edges', 'Wireless charging compatible'],
    rating: 4.3,
    reviewCount: 76,
  ),
  Product(
    id: 'prod_018',
    name: 'USB Flash Drive',
    description: '32GB USB flash drive with university branding.',
    price: 10.00,
    images: [
      'https://picsum.photos/seed/usb-drive-1/800/800',
    ],
    sizes: ['32GB', '64GB'],
    colors: ['Navy', 'Black'],
    category: 'Tech',
    collectionId: 'tech',
    sku: 'UOP-USB-001',
    features: ['USB 3.0', 'Keyring attachment', 'University logo', 'Cap included'],
    rating: 4.2,
    reviewCount: 53,
  ),

  // Sports
  Product(
    id: 'prod_019',
    name: 'Gym Shorts',
    description: 'Comfortable gym shorts with university logo.',
    price: 15.00,
    originalPrice: 22.00,
    images: [
      'https://picsum.photos/seed/gym-shorts-1/800/800',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Navy', 'Black', 'Grey'],
    category: 'Sports',
    collectionId: 'sports',
    isOnSale: true,
    sku: 'UOP-SHT-001',
    features: ['100% Polyester', 'Elastic waist', 'Side pockets', 'Breathable fabric'],
    rating: 4.4,
    reviewCount: 61,
  ),
  Product(
    id: 'prod_020',
    name: 'Sports Towel',
    description: 'Quick-dry microfiber towel for gym or sports.',
    price: 10.00,
    images: [
      'https://picsum.photos/seed/sports-towel-1/800/800',
    ],
    sizes: ['Small', 'Large'],
    colors: ['Navy', 'Grey'],
    category: 'Sports',
    collectionId: 'sports',
    sku: 'UOP-TWL-001',
    features: ['Microfiber', 'Quick-dry', 'Compact', 'Carry pouch included'],
    rating: 4.5,
    reviewCount: 44,
),  
];


  // Get all collections
  List<Collection> getCollections() => collections;

  // Get collection by ID
  Collection? getCollectionById(String id) {
    try {
      return collections.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get collection by name
  Collection? getCollectionByName(String name) {
    try {
      return collections.firstWhere(
        (c) => c.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Get all products
  List<Product> getProducts() => products;

  // Get products by collection ID
  List<Product> getProductsByCollection(String collectionId) {
    return products.where((p) => p.collectionId == collectionId).toList();
  }

  // Get products by collection name
  List<Product> getProductsByCollectionName(String collectionName) {
    final collection = getCollectionByName(collectionName);
    if (collection == null) return [];
    return getProductsByCollection(collection.id);
  }

  // Get product by ID
  Product? getProductById(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get sale products
  List<Product> getSaleProducts() {
    return products.where((p) => p.isOnSale).toList();
  }

  // Search products
  List<Product> searchProducts(String query) {
    final lowerQuery = query.toLowerCase();
    return products.where((p) {
      return p.name.toLowerCase().contains(lowerQuery) ||
          p.description.toLowerCase().contains(lowerQuery) ||
          p.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Filter products
  List<Product> filterProducts({
    String? collectionId,
    String? size,
    String? color,
    double? minPrice,
    double? maxPrice,
    bool? onSale,
  }) {
    return products.where((p) {
      if (collectionId != null && p.collectionId != collectionId) return false;
      if (size != null && size != 'All Sizes' && !p.sizes.contains(size)) return false;
      if (color != null && color != 'All Colors' && !p.colors.contains(color)) return false;
      if (minPrice != null && p.price < minPrice) return false;
      if (maxPrice != null && p.price > maxPrice) return false;
      if (onSale != null && p.isOnSale != onSale) return false;
      return true;
    }).toList();
  }

  // Sort products
  List<Product> sortProducts(List<Product> products, String sortBy) {
    final sorted = List<Product>.from(products);
    switch (sortBy) {
      case 'Price: Low to High':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Newest':
        sorted.sort((a, b) => b.id.compareTo(a.id));
        break;
      case 'Best Selling':
        sorted.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
      case 'Biggest Discount':
        sorted.sort((a, b) => b.discountPercentage.compareTo(a.discountPercentage));
        break;
      default: // Featured
        break;
    }
    return sorted;
  }
}
