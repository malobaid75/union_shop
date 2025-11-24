import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get totalSavings => _items.fold(0.0, (sum, item) {
    if (item.product.originalPrice != null) {
      return sum + (item.product.originalPrice! - item.product.price) * item.quantity;
    }
    return sum;
  });

  double get shipping => subtotal > 50 ? 0 : 5.99;

  double get tax => subtotal * 0.2; // 20% VAT

  double get total => subtotal + shipping + tax;

  void addItem(Product product, String size, String color, {int quantity = 1}) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id && 
                item.selectedSize == size && 
                item.selectedColor == color,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(
        product: product,
        selectedSize: size,
        selectedColor: color,
        quantity: quantity,
      ));
    }
    notifyListeners();
  }

  void removeItem(String cartItemId) {
    _items.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  void updateQuantity(String cartItemId, int quantity) {
    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(String productId) {
    return _items.any((item) => item.product.id == productId);
  }
}