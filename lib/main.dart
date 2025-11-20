import 'package:flutter/material.dart';
import 'widgets/navbar.dart';
import 'widgets/mobile_drawer.dart';


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
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            // Homepage content
            Container(
              height: 400,
              alignment: Alignment.center,
              child: const Text(
                'Homepage content will go here',
                style: TextStyle(fontSize: 18),
              ),
            ),
            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}