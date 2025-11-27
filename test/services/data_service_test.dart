import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/data_service.dart';

// Test suite for DataService
void main() {
  group('DataService Tests', () {
    late DataService dataService;

    setUp(() {
      dataService = DataService();
    });

    test('Should return all collections', () {
      final collections = dataService.getCollections();
      
      expect(collections, isNotEmpty);
      expect(collections.length, greaterThan(0));
    });

    test('Should return all products', () {
      final products = dataService.getProducts();
      
      expect(products, isNotEmpty);
      expect(products.length, greaterThan(0));
    });

    test('Should get collection by ID', () {
      final collection = dataService.getCollectionById('clothing');
      
      expect(collection, isNotNull);
      expect(collection!.id, 'clothing');
      expect(collection.name, 'Clothing');
    });

    test('Should return null for invalid collection ID', () {
      final collection = dataService.getCollectionById('invalid_id');
      
      expect(collection, isNull);
    });

    test('Should get collection by name', () {
      final collection = dataService.getCollectionByName('Clothing');
      
      expect(collection, isNotNull);
      expect(collection!.name, 'Clothing');
    });

    test('Should get products by collection ID', () {
      final products = dataService.getProductsByCollection('clothing');
      
      expect(products, isNotEmpty);
      // All products should belong to clothing collection
      for (var product in products) {
        expect(product.collectionId, 'clothing');
      }
    });

    test('Should get product by ID', () {
      final product = dataService.getProductById('prod_001');
      
      expect(product, isNotNull);
      expect(product!.id, 'prod_001');
    });

    test('Should get sale products', () {
      final saleProducts = dataService.getSaleProducts();
      
      expect(saleProducts, isNotEmpty);
      // All products should be on sale
      for (var product in saleProducts) {
        expect(product.isOnSale, true);
        expect(product.originalPrice, isNotNull);
      }
    });

    test('Should search products by name', () {
      final results = dataService.searchProducts('hoodie');
      
      expect(results, isNotEmpty);
      // Results should contain "hoodie" in name
      expect(results.first.name.toLowerCase(), contains('hoodie'));
    });

    test('Should search products by description', () {
      final results = dataService.searchProducts('cotton');
      
      expect(results, isNotEmpty);
    });

    test('Should return empty list for non-matching search', () {
      final results = dataService.searchProducts('xyzabc123notfound');
      
      expect(results, isEmpty);
    });

    test('Should filter products by size', () {
      final products = dataService.getProducts();
      final filtered = dataService.filterProducts(size: 'M');
      
      expect(filtered, isNotEmpty);
      expect(filtered.length, lessThanOrEqualTo(products.length));
      // All filtered products should have size M
      for (var product in filtered) {
        expect(product.sizes, contains('M'));
      }
    });

    test('Should filter products by color', () {
      final filtered = dataService.filterProducts(color: 'Black');
      
      expect(filtered, isNotEmpty);
      for (var product in filtered) {
        expect(product.colors, contains('Black'));
      }
    });

    test('Should filter products by price range', () {
      final filtered = dataService.filterProducts(
        minPrice: 10.0,
        maxPrice: 30.0,
      );
      
      expect(filtered, isNotEmpty);
      for (var product in filtered) {
        expect(product.price, greaterThanOrEqualTo(10.0));
        expect(product.price, lessThanOrEqualTo(30.0));
      }
    });

    test('Should sort products by price low to high', () {
      final products = dataService.getProducts();
      final sorted = dataService.sortProducts(products, 'Price: Low to High');
      
      expect(sorted, isNotEmpty);
      // Check if sorted in ascending order
      for (int i = 0; i < sorted.length - 1; i++) {
        expect(sorted[i].price, lessThanOrEqualTo(sorted[i + 1].price));
      }
    });

    test('Should sort products by price high to low', () {
      final products = dataService.getProducts();
      final sorted = dataService.sortProducts(products, 'Price: High to Low');
      
      expect(sorted, isNotEmpty);
      // Check if sorted in descending order
      for (int i = 0; i < sorted.length - 1; i++) {
        expect(sorted[i].price, greaterThanOrEqualTo(sorted[i + 1].price));
      }
    });

    test('Should sort products by biggest discount', () {
      final products = dataService.getSaleProducts();
      final sorted = dataService.sortProducts(products, 'Biggest Discount');
      
      expect(sorted, isNotEmpty);
      // Check if sorted by discount percentage
      for (int i = 0; i < sorted.length - 1; i++) {
        expect(sorted[i].discountPercentage, 
               greaterThanOrEqualTo(sorted[i + 1].discountPercentage));
      }
    });
  });
}
