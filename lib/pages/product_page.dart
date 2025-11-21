import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/footer.dart';

class ProductPage extends StatefulWidget {
  final String? productId;

  const ProductPage({
    super.key,
    this.productId,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _selectedImageIndex = 0;
  String _selectedSize = 'M';
  String _selectedColor = 'Navy';
  int _quantity = 1;

  final Map<String, dynamic> _product = {
    'name': 'University of Portsmouth Hoodie',
    'price': 35.00,
    'originalPrice': 45.00,
    'description':
        'Show your university pride with this premium quality hoodie. Made from a comfortable cotton-polyester blend, this hoodie features the official University of Portsmouth logo embroidered on the chest. Perfect for staying warm on campus or representing your university anywhere you go.',
    'images': [
      'https://via.placeholder.com/500x500/4A90E2/FFFFFF?text=Hoodie+Front',
      'https://via.placeholder.com/500x500/5A9AE2/FFFFFF?text=Hoodie+Back',
      'https://via.placeholder.com/500x500/6AA4E2/FFFFFF?text=Hoodie+Detail',
      'https://via.placeholder.com/500x500/7AAEE2/FFFFFF?text=Hoodie+Logo',
    ],
    'sizes': ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    'colors': ['Navy', 'Black', 'Grey', 'White'],
    'isOnSale': true,
    'inStock': true,
    'sku': 'UOP-HOD-001',
    'category': 'Clothing',
    'features': [
      '80% Cotton, 20% Polyester',
      'Embroidered university logo',
      'Kangaroo pocket',
      'Drawstring hood',
      'Ribbed cuffs and hem',
      'Machine washable',
    ],
    'reviews': {
      'average': 4.5,
      'count': 128,
    },
  };

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
            _buildBreadcrumb(),
            _buildProductContent(),
            const SizedBox(height: 40),
            _buildProductTabs(),
            const SizedBox(height: 40),
            _buildRelatedProducts(),
            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
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
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
            child: Text(
              'Home',
              style: TextStyle(color: Colors.blue.shade700, fontSize: 14),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, '/collections'),
            child: Text(
              'Collections',
              style: TextStyle(color: Colors.blue.shade700, fontSize: 14),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/collection', arguments: 'Clothing'),
            child: Text(
              _product['category'],
              style: TextStyle(color: Colors.blue.shade700, fontSize: 14),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          Expanded(
            child: Text(
              _product['name'],
              style: const TextStyle(color: Colors.grey, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildImageGallery()),
                const SizedBox(width: 40),
                Expanded(flex: 1, child: _buildProductDetails()),
              ],
            );
          } else {
            return Column(
              children: [
                _buildImageGallery(),
                const SizedBox(height: 30),
                _buildProductDetails(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildImageGallery() {
    final images = _product['images'] as List<String>;

    return Column(
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                images[_selectedImageIndex],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, size: 80),
                  );
                },
              ),
              if (_product['isOnSale'])
                Positioned(
                  top: 15,
                  left: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'SALE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 15,
                right: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImageIndex = index;
                  });
                },
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _selectedImageIndex == index
                          ? Colors.blue.shade700
                          : Colors.grey.shade300,
                      width: _selectedImageIndex == index ? 2 : 1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image, size: 30),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _product['name'],
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _buildRating(),
        const SizedBox(height: 15),
        _buildPrice(),
        const SizedBox(height: 20),
        Text(
          _product['description'],
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade700,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 25),
        _buildColorSelector(),
        const SizedBox(height: 20),
        _buildSizeSelector(),
        const SizedBox(height: 20),
        _buildQuantitySelector(),
        const SizedBox(height: 25),
        _buildAddToCartButton(),
        const SizedBox(height: 15),
        _buildBuyNowButton(),
        const SizedBox(height: 25),
        _buildProductMeta(),
      ],
    );
  }

  Widget _buildRating() {
    final reviews = _product['reviews'];
    return Row(
      children: [
        ...List.generate(5, (index) {
          if (index < reviews['average'].floor()) {
            return const Icon(Icons.star, color: Colors.amber, size: 20);
          } else if (index < reviews['average']) {
            return const Icon(Icons.star_half, color: Colors.amber, size: 20);
          } else {
            return const Icon(Icons.star_border, color: Colors.amber, size: 20);
          }
        }),
        const SizedBox(width: 10),
        Text(
          '${reviews['average']} (${reviews['count']} reviews)',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '£${_product['price'].toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: _product['isOnSale'] ? Colors.red : Colors.blue.shade700,
          ),
        ),
        if (_product['originalPrice'] != null) ...[
          const SizedBox(width: 12),
          Text(
            '£${_product['originalPrice'].toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade500,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${((((_product['originalPrice'] - _product['price']) / _product['originalPrice']) * 100).round())}% OFF',
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildColorSelector() {
    final colors = _product['colors'] as List<String>;
    final colorMap = {
      'Navy': Colors.blue.shade900,
      'Black': Colors.black,
      'Grey': Colors.grey,
      'White': Colors.white,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color: $_selectedColor',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: colors.map((color) {
            final isSelected = _selectedColor == color;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = color;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: colorMap[color] ?? Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.blue.shade700 : Colors.grey.shade300,
                    width: isSelected ? 3 : 1,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: color == 'White' ? Colors.black : Colors.white,
                        size: 20,
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSizeSelector() {
    final sizes = _product['sizes'] as List<String>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Size: $_selectedSize',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Size Guide'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: sizes.map((size) {
            final isSelected = _selectedSize == size;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSize = size;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.shade700 : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? Colors.blue.shade700 : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quantity',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (_quantity > 1) {
                    setState(() {
                      _quantity--;
                    });
                  }
                },
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.shopping_cart),
        label: const Text(
          'ADD TO CART',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildBuyNowButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(color: Colors.blue.shade700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'BUY NOW',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildProductMeta() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildMetaRow('SKU', _product['sku']),
          const Divider(),
          _buildMetaRow('Category', _product['category']),
          const Divider(),
          _buildMetaRow('Availability', _product['inStock'] ? 'In Stock' : 'Out of Stock'),
        ],
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: value == 'In Stock' ? Colors.green : null,
          ),
        ),
      ],
    );
  }

  Widget _buildProductTabs() {
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.blue.shade700,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue.shade700,
              tabs: const [
                Tab(text: 'Features'),
                Tab(text: 'Shipping'),
                Tab(text: 'Reviews'),
              ],
            ),
            SizedBox(
              height: 250,
              child: TabBarView(
                children: [
                  _buildFeaturesTab(),
                  _buildShippingTab(),
                  _buildReviewsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesTab() {
    final features = _product['features'] as List<String>;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: features
            .map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
                      const SizedBox(width: 10),
                      Text(feature, style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildShippingTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShippingRow(Icons.local_shipping, 'Free shipping on orders over £50'),
          _buildShippingRow(Icons.schedule, 'Delivery within 3-5 business days'),
          _buildShippingRow(Icons.replay, '30-day return policy'),
          _buildShippingRow(Icons.inventory, 'Ships from Portsmouth, UK'),
        ],
      ),
    );
  }

  Widget _buildShippingRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 24),
          const SizedBox(width: 15),
          Text(text, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    '${_product['reviews']['average']}',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < _product['reviews']['average'].floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                  ),
                  Text(
                    '${_product['reviews']['count']} reviews',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  children: [
                    _buildRatingBar('5', 0.7),
                    _buildRatingBar('4', 0.2),
                    _buildRatingBar('3', 0.05),
                    _buildRatingBar('2', 0.03),
                    _buildRatingBar('1', 0.02),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(String label, double percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(label),
          const SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedProducts() {
    final relatedProducts = [
      {'name': 'Campus T-Shirt', 'price': 18.00, 'image': 'https://via.placeholder.com/200x200/E74C3C/FFFFFF?text=T-Shirt'},
      {'name': 'Logo Sweatshirt', 'price': 32.00, 'image': 'https://via.placeholder.com/200x200/27AE60/FFFFFF?text=Sweatshirt'},
      {'name': 'Varsity Jacket', 'price': 55.00, 'image': 'https://via.placeholder.com/200x200/8E44AD/FFFFFF?text=Jacket'},
      {'name': 'Sports Jersey', 'price': 28.00, 'image': 'https://via.placeholder.com/200x200/F39C12/FFFFFF?text=Jersey'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'You May Also Like',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: relatedProducts.length,
              itemBuilder: (context, index) {
                final product = relatedProducts[index];
                return Container(
                  width: 180,
                  margin: const EdgeInsets.only(right: 15),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              product['image'] as String,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.shopping_bag, size: 40),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'] as String,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '£${(product['price'] as double).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}