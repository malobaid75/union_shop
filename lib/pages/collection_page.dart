import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/footer.dart';

class CollectionPage extends StatefulWidget {
  final String collectionName;

  const CollectionPage({
    super.key,
    required this.collectionName,
  });

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  String _sortBy = 'Featured';
  String _sizeFilter = 'All Sizes';
  String _colorFilter = 'All Colors';
  String _priceFilter = 'All Prices';

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'University Hoodie',
      'price': 35.00,
      'originalPrice': 45.00,
      'image': 'https://via.placeholder.com/300x300/4A90E2/FFFFFF?text=Hoodie',
      'isOnSale': true,
    },
    {
      'name': 'Campus T-Shirt',
      'price': 18.00,
      'originalPrice': null,
      'image': 'https://via.placeholder.com/300x300/E74C3C/FFFFFF?text=T-Shirt',
      'isOnSale': false,
    },
    {
      'name': 'Logo Sweatshirt',
      'price': 32.00,
      'originalPrice': null,
      'image': 'https://via.placeholder.com/300x300/27AE60/FFFFFF?text=Sweatshirt',
      'isOnSale': false,
    },
    {
      'name': 'Varsity Jacket',
      'price': 55.00,
      'originalPrice': 70.00,
      'image': 'https://via.placeholder.com/300x300/8E44AD/FFFFFF?text=Jacket',
      'isOnSale': true,
    },
    {
      'name': 'Sports Jersey',
      'price': 28.00,
      'originalPrice': null,
      'image': 'https://via.placeholder.com/300x300/F39C12/FFFFFF?text=Jersey',
      'isOnSale': false,
    },
    {
      'name': 'Polo Shirt',
      'price': 24.00,
      'originalPrice': null,
      'image': 'https://via.placeholder.com/300x300/16A085/FFFFFF?text=Polo',
      'isOnSale': false,
    },
    {
      'name': 'Zip-Up Hoodie',
      'price': 40.00,
      'originalPrice': 50.00,
      'image': 'https://via.placeholder.com/300x300/C0392B/FFFFFF?text=Zip+Hoodie',
      'isOnSale': true,
    },
    {
      'name': 'Long Sleeve Tee',
      'price': 22.00,
      'originalPrice': null,
      'image': 'https://via.placeholder.com/300x300/2980B9/FFFFFF?text=Long+Sleeve',
      'isOnSale': false,
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
            _buildPageHeader(),
            _buildBreadcrumb(),
            _buildFiltersSection(),
            _buildResultsInfo(),
            _buildProductsGrid(),
            const SizedBox(height: 20),
            _buildPagination(),
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
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            widget.collectionName.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${_products.length} products',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Text(
              'Home',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 14,
              ),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/collections');
            },
            child: Text(
              'Collections',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 14,
              ),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          Text(
            widget.collectionName,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            return Row(
              children: [
                Expanded(child: _buildSortDropdown()),
                const SizedBox(width: 15),
                Expanded(child: _buildSizeDropdown()),
                const SizedBox(width: 15),
                Expanded(child: _buildColorDropdown()),
                const SizedBox(width: 15),
                Expanded(child: _buildPriceDropdown()),
              ],
            );
          } else {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildSortDropdown()),
                    const SizedBox(width: 10),
                    Expanded(child: _buildSizeDropdown()),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _buildColorDropdown()),
                    const SizedBox(width: 10),
                    Expanded(child: _buildPriceDropdown()),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sortBy,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: ['Featured', 'Price: Low to High', 'Price: High to Low', 'Newest', 'Best Selling']
              .map((String value) {
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
    );
  }

  Widget _buildSizeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sizeFilter,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: ['All Sizes', 'XS', 'S', 'M', 'L', 'XL', 'XXL']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _sizeFilter = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildColorDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _colorFilter,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: ['All Colors', 'Black', 'White', 'Navy', 'Grey', 'Red', 'Blue']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _colorFilter = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildPriceDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _priceFilter,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: ['All Prices', 'Under £20', '£20 - £40', '£40 - £60', 'Over £60']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _priceFilter = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildResultsInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing ${_products.length} results',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.grid_view, size: 22),
                color: Colors.blue.shade700,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.view_list, size: 22),
                color: Colors.grey,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
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
              childAspectRatio: 0.7,
            ),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];
              return _buildProductCard(product);
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
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
                  if (product['isOnSale'])
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'SALE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
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
                    Row(
                      children: [
                        Text(
                          '£${product['price'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: product['isOnSale']
                                ? Colors.red
                                : Colors.blue.shade700,
                          ),
                        ),
                        if (product['originalPrice'] != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            '£${product['originalPrice'].toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
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

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {},
          color: Colors.grey,
        ),
        _buildPageNumber(1, isActive: true),
        _buildPageNumber(2),
        _buildPageNumber(3),
        const Text('...'),
        _buildPageNumber(10),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {},
          color: Colors.blue.shade700,
        ),
      ],
    );
  }

  Widget _buildPageNumber(int number, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue.shade700 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? Colors.blue.shade700 : Colors.grey.shade300,
            ),
          ),
          child: Text(
            '$number',
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey.shade700,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}