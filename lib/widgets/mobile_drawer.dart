import 'package:flutter/material.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
            ),
            child: const Text(
              'UNION SHOP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDrawerItem(context, Icons.home, 'Home', '/'),
          _buildDrawerItem(context, Icons.collections, 'Collections', '/collections'),
          _buildDrawerItem(context, Icons.local_offer, 'Sale', '/sale'),
          _buildDrawerItem(context, Icons.info, 'About Us', '/about'),
          const Divider(),
          _buildDrawerItem(context, Icons.person, 'Account', '/account'),
          _buildDrawerItem(context, Icons.shopping_cart, 'Cart', '/cart'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Close drawer
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}