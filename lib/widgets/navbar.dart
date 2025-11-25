import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../services/auth_service.dart';


class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = CartService();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          return _buildMobileNavbar(context, cartService);
        }
        return _buildDesktopNavbar(context, cartService);
      },
    );
  }

  Widget _buildMobileNavbar(BuildContext context, CartService cartService) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: InkWell(
        onTap: () => _navigateTo(context, '/'),
        child: const Text(
          'UNION SHOP',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () => _navigateTo(context, '/search'),
        ),
        _buildCartIcon(context, cartService),
      ],
    );
  }

  Widget _buildDesktopNavbar(BuildContext context, CartService cartService) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          InkWell(
            onTap: () => _navigateTo(context, '/'),
            child: const Text(
              'UNION SHOP',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            child: Row(
              children: [
                _buildNavLink(context, 'Home', '/'),
                _buildNavLink(context, 'Collections', '/collections'),
                _buildNavLink(context, 'Sale', '/sale'),
                _buildNavLink(context, 'Print Shack', '/print-shack'),
                _buildNavLink(context, 'About Us', '/about'),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => _navigateTo(context, '/search'),
                tooltip: 'Search',
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: (){
                  final authService = AuthService();
                  if (authService.isLoggedIn) {
                    _navigateTo(context, '/account-dashboard');
                  } else {
                    _navigateTo(context, '/auth');
                  }
                },
                tooltip: 'Account',
              ), 
              _buildCartIcon(context, cartService),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String title, String route) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () => _navigateTo(context, route),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.blue.shade700 : Colors.black,
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

 Widget _buildCartIcon(BuildContext context, CartService cartService) {
  return AnimatedBuilder(
    animation: cartService,
    builder: (context, child) {
      return Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () => _navigateTo(context, '/cart'),
            tooltip: 'Cart',
          ),
          if (cartService.itemCount > 0)
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: Text(
                  '${cartService.itemCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      );
    },
  );
  }
  
  void _navigateTo(BuildContext context, String route) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != route) {
      Navigator.pushNamed(context, route);
    }
  }
}