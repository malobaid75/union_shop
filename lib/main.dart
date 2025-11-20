import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';

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
        '/collections': (context) => const PlaceholderPage(title: 'Collections'),
        '/sale': (context) => const PlaceholderPage(title: 'Sale'),
        '/account': (context) => const PlaceholderPage(title: 'Account'),
        '/cart': (context) => const PlaceholderPage(title: 'Cart'),
      },
    );
  }
}

// Temporary placeholder page for routes not yet implemented
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