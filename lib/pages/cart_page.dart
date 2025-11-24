import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/footer.dart';
import '../services/cart_service.dart';
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _cartService.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: const Navbar(),
      ),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPageHeader(),
            _buildBreadcrumb(),
            if (_cartService.items.isEmpty)
              _buildEmptyCart()
            else
              _buildCartContent(),
            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade700, Colors.green.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 50,
          ),
          const SizedBox(height: 15),
          const Text(
            'SHOPPING CART',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${_cartService.itemCount} items in your cart',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/'),
            child: Text(
              'Home',
              style: TextStyle(color: Colors.blue.shade700, fontSize: 14),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          const Text(
            'Cart',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Container(
      padding: const EdgeInsets.all(60),
      child: Column(
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Add some products to get started!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/collections'),
            icon: const Icon(Icons.shopping_bag),
            label: const Text('BROWSE COLLECTIONS'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildCartItems()),
                const SizedBox(width: 20),
                Expanded(flex: 1, child: _buildOrderSummary()),
              ],
            );
          } else {
            return Column(
              children: [
                _buildCartItems(),
                const SizedBox(height: 20),
                _buildOrderSummary(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildCartItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cart Items (${_cartService.itemCount})',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Cart'),
                    content: const Text('Are you sure you want to remove all items?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _cartService.clearCart();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text('Clear Cart', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ..._cartService.items.map((item) => _buildCartItemCard(item)),
      ],
    );
  }

  Widget _buildCartItemCard(CartItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.images.first,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image),
                  );
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (item.selectedSize != 'N/A')
                    Text(
                      'Size: ${item.selectedSize}',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                  if (item.selectedColor != 'N/A')
                    Text(
                      'Color: ${item.selectedColor}',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        '£${item.product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      if (item.product.originalPrice != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          '£${item.product.originalPrice!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 18),
                        onPressed: () {
                          if (item.quantity > 1) {
                            _cartService.updateQuantity(item.id, item.quantity - 1);
                          }
                        },
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, size: 18),
                        onPressed: () {
                          if (item.quantity < 10) {
                            _cartService.updateQuantity(item.id, item.quantity + 1);
                          }
                        },
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    _cartService.removeItem(item.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.product.name} removed from cart'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildSummaryRow('Subtotal', '£${_cartService.subtotal.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            _buildSummaryRow(
              'Shipping',
              _cartService.shipping == 0
                  ? 'FREE'
                  : '£${_cartService.shipping.toStringAsFixed(2)}',
            ),
            if (_cartService.shipping > 0)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Free shipping on orders over £50',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            _buildSummaryRow('Tax (20%)', '£${_cartService.tax.toStringAsFixed(2)}'),
            if (_cartService.totalSavings > 0) ...[
              const SizedBox(height: 10),
              _buildSummaryRow(
                'You Save',
                '-£${_cartService.totalSavings.toStringAsFixed(2)}',
                valueColor: Colors.green,
              ),
            ],
            const Divider(height: 30),
            _buildSummaryRow(
              'Total',
              '£${_cartService.total.toStringAsFixed(2)}',
              isTotal: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleCheckout(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'PROCEED TO CHECKOUT',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/collections'),
                child: const Text('CONTINUE SHOPPING'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: valueColor ?? (isTotal ? Colors.blue.shade700 : null),
          ),
        ),
      ],
    );
  }

  void _handleCheckout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade700, size: 30),
            const SizedBox(width: 10),
            const Text('Order Placed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Thank you for your order!'),
            const SizedBox(height: 10),
            Text(
              'Order Total: £${_cartService.total.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Items: ${_cartService.itemCount}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 15),
            const Text(
              'Your order has been placed successfully. You will receive a confirmation email shortly.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cartService.clearCart();
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Text('GO TO HOME'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _cartService.clearCart();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
            ),
            child: const Text('VIEW ORDERS'),
          ),
        ],
      ),
    );
  }
}
     