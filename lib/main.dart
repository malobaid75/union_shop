import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/collections_page.dart';
import 'pages/collection_page.dart';
import 'pages/product_page.dart';
import 'pages/sale_page.dart';
import 'pages/auth_page.dart';
import 'pages/cart_page.dart';
import 'pages/print_shack_page.dart';
import 'pages/account_dashboard_page.dart';
import 'pages/orders_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setUrlStrategy(PathUrlStrategy());


  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAasG1amvOvIMt9S-m032F7SfmTA50wdVE",
      authDomain: "union-shop-18031.firebaseapp.com",
      projectId: "union-shop-18031",
      storageBucket: "union-shop-18031.firebasestorage.app",
      messagingSenderId: "801222443100",
      appId: "1:801222443100:web:9650e02adb9d0743d22699",
    ),
  );

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
        '/account-dashboard': (context) => const AccountDashboardPage(),
        '/orders': (context) => const OrdersPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/collection') {
          final collectionName =
              settings.arguments as String? ?? 'Collection';
          return MaterialPageRoute(
            builder: (context) =>
                CollectionPage(collectionName: collectionName),
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
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('$title page - Coming soon'),
      ),
    );
  }
}
