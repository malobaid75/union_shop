import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/collections_page.dart';
import 'pages/collection_page.dart';
import 'pages/product_page.dart';
import 'pages/sale_page.dart';
import 'pages/auth_page.dart';
import 'pages/cart_page.dart';
import 'pages/print_shack_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/sale': (context) => const SalePage(),
        '/auth': (context) => const AuthPage(),
        '/account': (context) => const AuthPage(),
        '/cart': (context) => const CartPage(),
        '/print-shack': (context) => const PrintShackPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/collection') {
          final collectionName = settings.arguments as String? ?? 'Collection';
          return MaterialPageRoute(
            builder: (context) => CollectionPage(collectionName: collectionName),
          );
        }
        if (settings.name == '/product') {
          final productId = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) => ProductPage(productId: productId),
          );
        }
        return null;
      },
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('$title page - Coming soon'),
      ),
    );
  }
}