import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/footer.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  String _sortBy = 'Biggest Discount';

  final List<Map<String, dynamic>> _saleProducts = [
    {
      'name': 'University Hoodie',
      'price': 35.00,
      'originalPrice': 45.00,
      'discount': 22,
      'image': 'https://via.placeholder.com/300x300/4A90E2/FFFFFF?text=Hoodie',
    },
    {
      'name': 'Varsity Jacket',
      'price': 55.00,
      'originalPrice': 70.00,
      'discount': 21,
      'image': 'https://via.placeholder.com/300x300/8E44AD/FFFFFF?text=Jacket',
    },
    {
      'name': 'Zip-Up Hoodie',
      'price': 40.00,
      'originalPrice': 50.00,
      'discount': 20,
      'image': 'https://via.placeholder.com/300x300/C0392B/FFFFFF?text=Zip+Hoodie',
    },
    {
      'name': 'Premium Backpack',
      'price': 32.00,
      'originalPrice': 45.00,
      'discount': 29,
      'image': 'https://via.placeholder.com/300x300/27AE60/FFFFFF?text=Backpack',
    },
    {
      'name': 'Winter Beanie',
      'price': 10.00,
      'originalPrice': 15.00,
      'discount': 33,
      'image': 'https://via.placeholder.com/300x300/E74C3C/FFFFFF?text=Beanie',
    },
    {
      'name': 'Sports Water Bottle',
      'price': 8.00,
      'originalPrice': 12.00,
      'discount': 33,
      'image': 'https://via.placeholder.com/300x300/16A085/FFFFFF?text=Bottle',
    },
    {
      'name': 'Campus Polo Shirt',
      'price': 20.00,
      'originalPrice': 28.00,
      'discount': 29,
      'image': 'https://via.placeholder.com/300x300/F39C12/FFFFFF?text=Polo',
    },
    {
      'name': 'Laptop Sleeve',
      'price': 18.00,
      'originalPrice': 25.00,
      'discount': 28,
      'image': 'https://via.placeholder.com/300x300/9B59B6/FFFFFF?text=Sleeve',
    },
    {
      'name': 'Gym Shorts',
      'price': 15.00,
      'originalPrice': 22.00,
      'discount': 32,
      'image': 'https://via.placeholder.com/300x300/3498DB/FFFFFF?text=Shorts',
    },
    {
      'name': 'University Scarf',
      'price': 12.00,
      'originalPrice': 18.00,
      'discount': 33,
      'image': 'https://via.placeholder.com/300x300/E67E22/FFFFFF?text=Scarf',
    },
  ];

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
            _buildSaleHero(),
            _buildCountdownBanner(),
            _buildFiltersBar(),
            _buildSaleProductsGrid(),
            const SizedBox(height: 30),
            _buildPromoBanner(),
            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSaleHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade700, Colors.red.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '🔥 LIMITED TIME OFFER',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'MEGA SALE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'UP TO 50% OFF',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Shop amazing deals on university merchandise',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      color: Colors.grey.shade900,
      child: Column(
        children: [
          const Text(
            'SALE ENDS IN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCountdownBox('02', 'DAYS'),
              _buildCountdownSeparator(),
              _buildCountdownBox('14', 'HOURS'),
              _buildCountdownSeparator(),
              _buildCountdownBox('36', 'MINS'),
              _buildCountdownSeparator(),
              _buildCountdownBox('22', 'SECS'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownBox(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.red.shade600,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        ':',
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFiltersBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_saleProducts.length} items on sale',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _sortBy,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: [
                  'Biggest Discount',
                  'Price: Low to High',
                  'Price: High to Low',
                  'Newest',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _sortBy = newValue!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaleProductsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth > 768) {
            crossAxisCount = 3;
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.65,
            ),
            itemCount: _saleProducts.length,
            itemBuilder: (context, index) {
              final product = _saleProducts[index];
              return _buildSaleProductCard(product);
            },
          );
        },
      ),
    );
  }

  Widget _buildSaleProductCard(Map<String, dynamic> product) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/product', arguments: product['name']);
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
                    product['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.shopping_bag, size: 50),
                      );
                    },
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-${product['discount']}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border, size: 18),
                        color: Colors.grey.shade600,
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '£${product['originalPrice'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '£${product['price'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'SAVE £${(product['originalPrice'] - product['price']).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ),
                          ],
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

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade700, Colors.purple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                Expanded(child: _buildPromoContent()),
                const SizedBox(width: 20),
                _buildPromoButton(),
              ],
            );
          } else {
            return Column(
              children: [
                _buildPromoContent(),
                const SizedBox(height: 20),
                _buildPromoButton(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildPromoContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'EXTRA 10% OFF',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Use code STUDENT10 at checkout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Valid for students with university email',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPromoButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.purple.shade700,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'COPY CODE',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
