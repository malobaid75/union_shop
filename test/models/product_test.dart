import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

// Test suite for Product model
void main() {
  group('Product Model Tests', () {
    
    // Test product creation
    test('Product should be created with all properties', () {
      final product = Product(
        id: 'test_001',
        name: 'Test Product',
        description: 'A test product',
        price: 25.00,
        originalPrice: 30.00,
        images: ['image1.jpg'],
        sizes: ['M', 'L'],
        colors: ['Blue', 'Red'],
        category: 'Testing',
        collectionId: 'test_collection',
        isOnSale: true,
        inStock: true,
        sku: 'TEST-001',
        features: ['Feature 1', 'Feature 2'],
        rating: 4.5,
        reviewCount: 10,
      );

      expect(product.id, 'test_001');
      expect(product.name, 'Test Product');
      expect(product.price, 25.00);
      expect(product.originalPrice, 30.00);
      expect(product.isOnSale, true);
      expect(product.inStock, true);
    });

    // Test discount percentage calculation
    test('Discount percentage should be calculated correctly', () {
      final product = Product(
        id: 'test_002',
        name: 'Sale Product',
        description: 'A product on sale',
        price: 20.00,
        originalPrice: 25.00,
        images: ['image1.jpg'],
        sizes: ['M'],
        colors: ['Blue'],
        category: 'Testing',
        collectionId: 'test_collection',
        isOnSale: true,
        sku: 'TEST-002',
        features: [],
      );

      // (25 - 20) / 25 * 100 = 20%
      expect(product.discountPercentage, 20);
    });

    // Test savings calculation
    test('Savings should be calculated correctly', () {
      final product = Product(
        id: 'test_003',
        name: 'Discount Product',
        description: 'A discounted product',
        price: 30.00,
        originalPrice: 45.00,
        images: ['image1.jpg'],
        sizes: ['S', 'M', 'L'],
        colors: ['Black'],
        category: 'Testing',
        collectionId: 'test_collection',
        isOnSale: true,
        sku: 'TEST-003',
        features: [],
      );

      expect(product.savings, 15.00);
    });

    // Test product without sale
    test('Product not on sale should have zero discount', () {
      final product = Product(
        id: 'test_004',
        name: 'Regular Product',
        description: 'A regular priced product',
        price: 25.00,
        images: ['image1.jpg'],
        sizes: ['M'],
        colors: ['Red'],
        category: 'Testing',
        collectionId: 'test_collection',
        isOnSale: false,
        sku: 'TEST-004',
        features: [],
      );

      expect(product.discountPercentage, 0);
      expect(product.savings, 0);
    });
  });
}
