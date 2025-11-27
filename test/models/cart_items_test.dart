import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart_item.dart';

// Test suite for CartItem model
void main() {
  group('CartItem Model Tests', () {
    late Product testProduct;

    setUp(() {
      // Create a test product for use in all tests
      testProduct = Product(
        id: 'test_001',
        name: 'Test Product',
        description: 'A test product',
        price: 20.00,
        images: ['image1.jpg'],
        sizes: ['M', 'L'],
        colors: ['Blue', 'Red'],
        category: 'Testing',
        collectionId: 'test_collection',
        sku: 'TEST-001',
        features: [],
      );
    });

    test('CartItem should be created with correct properties', () {
      final cartItem = CartItem(
        product: testProduct,
        selectedSize: 'M',
        selectedColor: 'Blue',
        quantity: 2,
      );

      expect(cartItem.product.id, 'test_001');
      expect(cartItem.selectedSize, 'M');
      expect(cartItem.selectedColor, 'Blue');
      expect(cartItem.quantity, 2);
    });

    test('Total price should be calculated correctly', () {
      final cartItem = CartItem(
        product: testProduct,
        selectedSize: 'L',
        selectedColor: 'Red',
        quantity: 3,
      );

      // 20.00 * 3 = 60.00
      expect(cartItem.totalPrice, 60.00);
    });

    test('Cart item ID should be unique based on product and options', () {
      final cartItem1 = CartItem(
        product: testProduct,
        selectedSize: 'M',
        selectedColor: 'Blue',
        quantity: 1,
      );

      final cartItem2 = CartItem(
        product: testProduct,
        selectedSize: 'L',
        selectedColor: 'Red',
        quantity: 1,
      );

      expect(cartItem1.id, isNot(equals(cartItem2.id)));
    });

    test('Quantity should be modifiable', () {
      final cartItem = CartItem(
        product: testProduct,
        selectedSize: 'M',
        selectedColor: 'Blue',
        quantity: 1,
      );

      cartItem.quantity = 5;
      expect(cartItem.quantity, 5);
      expect(cartItem.totalPrice, 100.00); // 20 * 5
    });
  });
}
