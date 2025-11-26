import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../services/auth_service.dart';
class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = CartService();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade700, Colors.blue.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.blue.shade700,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'UNION SHOP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'University Merchandise',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerSection('SHOP'),
          _buildDrawerItem(context, Icons.home, 'Home', '/'),
          _buildDrawerItem(context, Icons.collections, 'Collections', '/collections'),
          _buildDrawerItem(context, Icons.local_offer, 'Sale', '/sale'),
          _buildDrawerItem(context, Icons.print, 'Print Shack', '/print-shack'),
          _buildDrawerItem(context, Icons.info, 'About Us', '/about'),
          const Divider(),
          _buildDrawerSection('ACCOUNT'),
          _buildDrawerItem(context, Icons.search, 'Search', '/search'),
           _buildDrawerCustomAccount(context),
          _buildCartItem(context, cartService),
        ],
      ),
    );
  }

  Widget _buildDrawerSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, String route) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? Colors.blue.shade700 : Colors.grey.shade700,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.blue.shade700 : Colors.black,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isActive,
      selectedTileColor: Colors.blue.shade50,
      onTap: () {
        Navigator.pop(context); // Close drawer first
        if (currentRoute != route) {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }

 Widget _buildCartItem(BuildContext context, CartService cartService) {
  return AnimatedBuilder(
    animation: cartService,
    builder: (context, child) {
      final currentRoute = ModalRoute.of(context)?.settings.name;
      final isActive = currentRoute == '/cart';

      return ListTile(
        leading: Icon(
          Icons.shopping_cart,
          color: isActive ? Colors.blue.shade700 : Colors.grey.shade700,
        ),
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            color: isActive ? Colors.blue.shade700 : Colors.black,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: cartService.itemCount > 0
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${cartService.itemCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        selected: isActive,
        selectedTileColor: Colors.blue.shade50,
        onTap: () {
          Navigator.pop(context);
          if (currentRoute != '/cart') {
            Navigator.pushNamed(context, '/cart');
          }
        },
      );
    },
  );
  }

  Widget _buildDrawerCustomAccount(BuildContext context) {
  return ListTile(
    leading: const Icon(Icons.person),
    title: const Text('Account'),
    onTap: () {
      Navigator.pop(context); // close drawer

      final authService = AuthService();
      if (authService.isLoggedIn) {
        Navigator.pushNamed(context, '/account-dashboard');
      } else {
        Navigator.pushNamed(context, '/auth');
      }
    },
  );
}

}