import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/footer.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

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
            const SizedBox(height: 40),
            _buildCollectionsGrid(),
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
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade700, Colors.purple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.collections_bookmark,
            color: Colors.white,
            size: 50,
          ),
          const SizedBox(height: 15),
          const Text(
            'COLLECTIONS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Browse our curated product collections',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionsGrid() {
    final collections = [
      {
        'name': 'Clothing',
        'description': 'Hoodies, t-shirts, jackets and more',
        'itemCount': '45 items',
        'image': 'https://via.placeholder.com/400x300/4A90E2/FFFFFF?text=Clothing',
        'color': Colors.blue.shade700,
      },
      {
        'name': 'Accessories',
        'description': 'Bags, hats, pins and accessories',
        'itemCount': '32 items',
        'image': 'https://via.placeholder.com/400x300/E74C3C/FFFFFF?text=Accessories',
        'color': Colors.red.shade700,
      },
      {
        'name': 'Stationery',
        'description': 'Notebooks, pens, and study essentials',
        'itemCount': '28 items',
        'image': 'https://via.placeholder.com/400x300/F39C12/FFFFFF?text=Stationery',
        'color': Colors.orange.shade700,
      },
      {
        'name': 'Drinkware',
        'description': 'Mugs, bottles, and tumblers',
        'itemCount': '18 items',
        'image': 'https://via.placeholder.com/400x300/27AE60/FFFFFF?text=Drinkware',
        'color': Colors.green.shade700,
      },
      {
        'name': 'Tech & Gadgets',
        'description': 'Phone cases, USB drives, tech accessories',
        'itemCount': '22 items',
        'image': 'https://via.placeholder.com/400x300/8E44AD/FFFFFF?text=Tech',
        'color': Colors.purple.shade700,
      },
      {
        'name': 'Sports & Fitness',
        'description': 'Gym wear, water bottles, sports gear',
        'itemCount': '35 items',
        'image': 'https://via.placeholder.com/400x300/16A085/FFFFFF?text=Sports',
        'color': Colors.teal.shade700,
      },
      {
        'name': 'Home & Living',
        'description': 'Posters, cushions, room decor',
        'itemCount': '26 items',
        'image': 'https://via.placeholder.com/400x300/D35400/FFFFFF?text=Home',
        'color': Colors.deepOrange.shade700,
      },
      {
        'name': 'Limited Edition',
        'description': 'Exclusive and rare items',
        'itemCount': '12 items',
        'image': 'https://via.placeholder.com/400x300/C0392B/FFFFFF?text=Limited',
        'color': Colors.red.shade900,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 1;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 3;
          } else if (constraints.maxWidth > 768) {
            crossAxisCount = 2;
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemCount: collections.length,
            itemBuilder: (context, index) {
              final collection = collections[index];
              return _buildCollectionCard(
                context,
                collection['name'] as String,
                collection['description'] as String,
                collection['itemCount'] as String,
                collection['image'] as String,
                collection['color'] as Color,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCollectionCard(
    BuildContext context,
    String name,
    String description,
    String itemCount,
    String imageUrl,
    Color accentColor,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/collection',
            arguments: name,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: accentColor.withOpacity(0.3),
                        child: Icon(
                          Icons.collections,
                          size: 60,
                          color: accentColor,
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          itemCount,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward, size: 18),
                          label: const Text('View Collection'),
                          style: TextButton.styleFrom(
                            foregroundColor: accentColor,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}