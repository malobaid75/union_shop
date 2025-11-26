import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import 'auth_service.dart';

/// Cart service with Firestore persistence
/// Syncs cart with user account when logged in
class CartService extends ChangeNotifier {
  // Singleton pattern
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal() {
    _initializeCart();
  }

  // Firebase instances
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // Cart items list
  final List<CartItem> _items = [];

  // Getters
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

  /// Initialize cart - load from Firestore if user is logged in
  Future<void> _initializeCart() async {
    // Listen to auth state changes
    _authService.authStateChanges.listen((user) {
      if (user != null) {
        _loadCartFromFirestore();
      } else {
        
      }
    });

    // Load cart immediately if user is already logged in
    if (_authService.isLoggedIn) {
      await _loadCartFromFirestore();
    }
  }

  /// Load cart from Firestore
  Future<void> _loadCartFromFirestore() async {
    if (!_authService.isLoggedIn) return;

    try {
      final doc = await _firestore
          .collection('carts')
          .doc(_authService.currentUser!.uid)
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null && data['items'] != null) {
          _items.clear();
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint('Error loading cart from Firestore: $e');
    }
  }

  /// Save cart to Firestore
  Future<void> _saveCartToFirestore() async {
    if (!_authService.isLoggedIn) return;

    try {
      // Convert cart items to serializable format
      final cartData = {
        'items': _items.map((item) => {
          'productId': item.product.id,
          'productName': item.product.name,
          'productPrice': item.product.price,
          'productImage': item.product.images.first,
          'selectedSize': item.selectedSize,
          'selectedColor': item.selectedColor,
          'quantity': item.quantity,
          'originalPrice': item.product.originalPrice,
        }).toList(),
        'subtotal': subtotal,
        'total': total,
        'itemCount': itemCount,
        'lastUpdated': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('carts')
          .doc(_authService.currentUser!.uid)
          .set(cartData, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error saving cart to Firestore: $e');
    }
  }

  /// Add item to cart
  void addItem(Product product, String size, String color, {int quantity = 1}) {
    // Check if item already exists in cart
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id && 
                item.selectedSize == size && 
                item.selectedColor == color,
    );

    if (existingIndex >= 0) {
      // Update quantity of existing item
      _items[existingIndex].quantity += quantity;
    } else {
      // Add new item to cart
      _items.add(CartItem(
        product: product,
        selectedSize: size,
        selectedColor: color,
        quantity: quantity,
      ));
    }

    // Notify listeners and save to Firestore
    notifyListeners();
    _saveCartToFirestore();
  }

  /// Remove item from cart
  void removeItem(String cartItemId) {
    _items.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
    _saveCartToFirestore();
  }

  /// Update item quantity
  void updateQuantity(String cartItemId, int quantity) {
    final index = _items.indexWhere((item) => item.id == cartItemId);
    
    if (index >= 0) {
      if (quantity <= 0) {
        // Remove item if quantity is 0 or less
        _items.removeAt(index);
      } else {
        // Update quantity
        _items[index].quantity = quantity;
      }
      notifyListeners();
      _saveCartToFirestore();
    }
  }

  /// Clear entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
    _saveCartToFirestore();
  }

  /// Check if product is in cart
  bool isInCart(String productId) {
    return _items.any((item) => item.product.id == productId);
  }

  /// Get cart item count for a specific product
  int getProductQuantity(String productId) {
    return _items
        .where((item) => item.product.id == productId)
        .fold(0, (sum, item) => sum + item.quantity);
  }

  /// Place order - save order to Firestore and clear cart
  Future<Map<String, dynamic>> placeOrder() async {
    if (!_authService.isLoggedIn) {
      return {
        'success': false,
        'message': 'Please sign in to place an order',
      };
    }

    if (_items.isEmpty) {
      return {
        'success': false,
        'message': 'Your cart is empty',
      };
    }

    try {
      // Generate order ID
      final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';

      // Create order document
      final orderData = {
        'orderId': orderId,
        'userId': _authService.currentUser!.uid,
        'userEmail': _authService.currentUser!.email,
        'userName': _authService.currentUser!.displayName,
        'items': _items.map((item) => {
          'productId': item.product.id,
          'productName': item.product.name,
          'productPrice': item.product.price,
          'productImage': item.product.images.first,
          'selectedSize': item.selectedSize,
          'selectedColor': item.selectedColor,
          'quantity': item.quantity,
        }).toList(),
        'subtotal': subtotal,
        'shipping': shipping,
        'tax': tax,
        'total': total,
        'totalSavings': totalSavings,
        'itemCount': itemCount,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Save order to Firestore
      await _firestore.collection('orders').doc(orderId).set(orderData);

      // Update user's orders list
      await _firestore
          .collection('users')
          .doc(_authService.currentUser!.uid)
          .update({
        'orders': FieldValue.arrayUnion([orderId]),
      });

      // Clear cart after successful order
      clearCart();

      return {
        'success': true,
        'message': 'Order placed successfully!',
        'orderId': orderId,
      };
    } catch (e) {
      debugPrint('Error placing order: $e');
      return {
        'success': false,
        'message': 'Failed to place order. Please try again.',
      };
    }
  }

  /// Get user's order history
  Future<List<Map<String, dynamic>>> getUserOrders() async {
    if (!_authService.isLoggedIn) return [];

    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: _authService.currentUser!.uid)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      return [];
    }
  }
}