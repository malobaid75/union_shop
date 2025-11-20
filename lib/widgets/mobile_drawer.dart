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
          _buildDrawerItem(Icons.home, 'Home', () {}),
          _buildDrawerItem(Icons.collections, 'Collections', () {}),
          _buildDrawerItem(Icons.local_offer, 'Sale', () {}),
          _buildDrawerItem(Icons.info, 'About Us', () {}),
          const Divider(),
          _buildDrawerItem(Icons.person, 'Account', () {}),
          _buildDrawerItem(Icons.shopping_cart, 'Cart', () {}),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}