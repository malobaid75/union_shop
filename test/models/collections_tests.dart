import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';

// Test suite for Collection model
void main() {
  group('Collection Model Tests', () {
    
    // Test collection creation
    test('Collection should be created with all properties', () {
      final collection = Collection(
        id: 'col_001',
        name: 'Summer Collection',
        description: 'Bright and fresh summer wear',
        image: 'summer.jpg',
        itemCount: 12,
        colorHex: '#FF5733',
      );

      expect(collection.id, 'col_001');
      expect(collection.name, 'Summer Collection');
      expect(collection.description, 'Bright and fresh summer wear');
      expect(collection.image, 'summer.jpg');
      expect(collection.itemCount, 12);
      expect(collection.colorHex, '#FF5733');
    });

    // Test empty collection creation
    test('Collection should support zero items', () {
      final collection = Collection(
        id: 'col_000',
        name: 'Empty Collection',
        description: 'No products yet',
        image: 'placeholder.jpg',
        itemCount: 0,
        colorHex: '#000000',
      );

      expect(collection.itemCount, 0);
    });

    // Test colorHex format
    test('colorHex should be a valid hex string', () {
      final collection = Collection(
        id: 'col_002',
        name: 'Winter',
        description: 'Winter warm wear',
        image: 'winter.jpg',
        itemCount: 5,
        colorHex: '#ABC123',
      );

      // Simple regex check for hex color
      final hexRegex = RegExp(r'^#([A-Fa-f0-9]{6})$');

      expect(hexRegex.hasMatch(collection.colorHex), true);
    });
  });
}
