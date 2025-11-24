import 'package:flutter/material.dart';
import 'package:union_shop/services/cart_service.dart';
import '../widgets/navbar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/footer.dart';
import '../services/data_service.dart';
import '../models/product.dart';

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
  final DataService _dataService = DataService();
  
  Product? _product;
  int _selectedImageIndex = 0;
  String? _selectedSize;
  String? _selectedColor;
  int _quantity = 1;
  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() {
    if (widget.productId != null) {
      _product = _dataService.getProductById(widget.productId!);
    }
    
    // If product not found by ID, try to get first product (fallback for demo)
    if (_product == null && _dataService.getProducts().isNotEmpty) {
      _product = _dataService.getProducts().first;
    }

    if (_product != null) {
      // Set default selections
      _selectedSize = _product!.sizes.isNotEmpty ? _product!.sizes.first : null;
      _selectedColor = _product!.colors.isNotEmpty ? _product!.colors.first : null;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_product == null) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: const Navbar(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: Colors.grey),
              const SizedBox(height: 20),
              const Text(
                'Product not found',
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/collections'),
                child: const Text('Browse Collections'),
              ),
            ],
          ),
        ),
      );
    }

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
    final collection = _dataService.getCollectionById(_product!.collectionId);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Colors.grey.shade100,
      child: Wrap(
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/'),
            child: Text(
              'Home',
              style: TextStyle(color: Colors.blue.shade700, fontSize: 14),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/collections'),
            child: Text(
              'Collections',
              style: TextStyle(color: Colors.blue.shade700, fontSize: 14),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          if (collection != null) ...[
            InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                '/collection',
                arguments: collection.name,
              ),
              child: Text(
                collection.name,
                style: TextStyle(color: Colors.blue.shade700, fontSize: 14),
              ),
            ),
            const Text(' / ', style: TextStyle(color: Colors.grey)),
          ],
          Text(
            _product!.name,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                _product!.images[_selectedImageIndex],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, size: 80),
                  );
                },
              ),
              if (_product!.isOnSale)
                Positioned(
                  top: 15,
                  left: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '-${_product!.discountPercentage}% OFF',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              if (!_product!.inStock)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    child: const Center(
                      child: Text(
                        'OUT OF STOCK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
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
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added to wishlist!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
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
            itemCount: _product!.images.length,
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
                    _product!.images[index],
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
          _product!.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _buildRating(),
        const SizedBox(height: 15),
        _buildPrice(),
        const SizedBox(height: 5),
        _buildStockStatus(),
        const SizedBox(height: 20),
        Text(
          _product!.description,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade700,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 25),
        if (_product!.colors.isNotEmpty) ...[
          _buildColorSelector(),
          const SizedBox(height: 20),
        ],
        if (_product!.sizes.isNotEmpty) ...[
          _buildSizeSelector(),
          const SizedBox(height: 20),
        ],
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
    return Row(
      children: [
        ...List.generate(5, (index) {
          if (index < _product!.rating.floor()) {
            return const Icon(Icons.star, color: Colors.amber, size: 20);
          } else if (index < _product!.rating) {
            return const Icon(Icons.star_half, color: Colors.amber, size: 20);
          } else {
            return const Icon(Icons.star_border, color: Colors.amber, size: 20);
          }
        }),
        const SizedBox(width: 10),
        Text(
          '${_product!.rating} (${_product!.reviewCount} reviews)',
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
          '£${_product!.price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: _product!.isOnSale ? Colors.red : Colors.blue.shade700,
          ),
        ),
        if (_product!.originalPrice != null) ...[
          const SizedBox(width: 12),
          Text(
            '£${_product!.originalPrice!.toStringAsFixed(2)}',
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
              'SAVE £${_product!.savings.toStringAsFixed(2)}',
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

  Widget _buildStockStatus() {
    return Row(
      children: [
        Icon(
          _product!.inStock ? Icons.check_circle : Icons.cancel,
          color: _product!.inStock ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          _product!.inStock ? 'In Stock' : 'Out of Stock',
          style: TextStyle(
            color: _product!.inStock ? Colors.green : Colors.red,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    final colorMap = {
      'Navy': Colors.blue.shade900,
      'Black': Colors.black,
      'Grey': Colors.grey,
      'White': Colors.white,
      'Blue': Colors.blue,
      'Red': Colors.red,
      'Green': Colors.green,
      'Navy/Gold': Colors.blue.shade900,
      'Clear': Colors.grey.shade200,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Color: ${_selectedColor ?? "Select"}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (_selectedColor != null)
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedColor = null;
                  });
                },
                child: const Text('Clear'),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _product!.colors.map((color) {
            final isSelected = _selectedColor == color;
            final colorValue = colorMap[color] ?? Colors.grey;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = color;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: colorValue,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.blue.shade700 : Colors.grey.shade300,
                    width: isSelected ? 3 : 2,
                  ),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: Colors.blue.shade700.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: color == 'White' || color == 'Clear'
                            ? Colors.black
                            : Colors.white,
                        size: 24,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Size: ${_selectedSize ?? "Select"}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                if (_selectedSize != null)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedSize = null;
                      });
                    },
                    child: const Text('Clear'),
                  ),
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Size Guide'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Size Chart:'),
                            const SizedBox(height: 10),
                            _buildSizeGuideRow('XS', 'Chest: 34-36"'),
                            _buildSizeGuideRow('S', 'Chest: 36-38"'),
                            _buildSizeGuideRow('M', 'Chest: 38-40"'),
                            _buildSizeGuideRow('L', 'Chest: 40-42"'),
                            _buildSizeGuideRow('XL', 'Chest: 42-44"'),
                            _buildSizeGuideRow('XXL', 'Chest: 44-46"'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.straighten, size: 18),
                  label: const Text('Size Guide'),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _product!.sizes.map((size) {
            final isSelected = _selectedSize == size;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSize = size;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.shade700 : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? Colors.blue.shade700 : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSizeGuideRow(String size, String measurement) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(size, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(measurement),
        ],
      ),
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
                onPressed: _quantity > 1
                    ? () {
                        setState(() {
                          _quantity--;
                        });
                      }
                    : null,
                color: _quantity > 1 ? Colors.blue.shade700 : Colors.grey,
              ),
              Container(
                width: 60,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
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
                onPressed: _quantity < 10
                    ? () {
                        setState(() {
                          _quantity++;
                        });
                      }
                    : null,
                color: _quantity < 10 ? Colors.blue.shade700 : Colors.grey,
              ),
            ],
          ),
        ),
        if (_quantity >= 10)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Maximum quantity: 10',
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange.shade700,
              ),
            ),
          ),
      ],
    );
  }

 Widget _buildAddToCartButton() {
  final canAddToCart = _product!.inStock &&
      (_product!.sizes.isEmpty || _selectedSize != null) &&
      (_product!.colors.isEmpty || _selectedColor != null);

  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: canAddToCart
          ? () {
              final cartService = CartService();
              cartService.addItem(
                _product!,
                _selectedSize ?? 'N/A',
                _selectedColor ?? 'N/A',
                quantity: _quantity,
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added ${_quantity}x ${_product!.name} to cart!',
                  ),
                  action: SnackBarAction(
                    label: 'VIEW CART',
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                  duration: const Duration(seconds: 3),
                  backgroundColor: Colors.green,
                ),
              );
            }
          : null,
      icon: const Icon(Icons.shopping_cart),
      label: Text(
        canAddToCart ? 'ADD TO CART' : 'SELECT OPTIONS',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: canAddToCart ? Colors.blue.shade700 : Colors.grey,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBackgroundColor: Colors.grey.shade300,
        disabledForegroundColor: Colors.grey.shade600,
      ),
    ),
  );
}
  Widget _buildBuyNowButton() {
    final canBuyNow = _product!.inStock &&
        (_product!.sizes.isEmpty || _selectedSize != null) &&
        (_product!.colors.isEmpty || _selectedColor != null);

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: canBuyNow
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Proceeding to checkout...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            : null,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(
            color: canBuyNow ? Colors.blue.shade700 : Colors.grey.shade300,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'BUY NOW',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: canBuyNow ? Colors.blue.shade700 : Colors.grey,
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
          _buildMetaRow('SKU', _product!.sku),
          const Divider(),
          _buildMetaRow('Category', _product!.category),
          const Divider(),
          _buildMetaRow(
            'Availability',
            _product!.inStock ? 'In Stock' : 'Out of Stock',
            valueColor: _product!.inStock ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildMetaRow(String label, String value, {Color? valueColor}) {
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
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProductTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                _buildTab('Features', 0),
                _buildTab('Shipping', 1),
                _buildTab('Reviews', 2),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isActive = _activeTabIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _activeTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? Colors.blue.shade700 : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? Colors.blue.shade700 : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_activeTabIndex) {
      case 0:
        return _buildFeaturesTab();
      case 1:
        return _buildShippingTab();
      case 2:
        return _buildReviewsTab();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildFeaturesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _product!.features
          .map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildShippingTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShippingRow(Icons.local_shipping, 'Free shipping on orders over £50'),
        _buildShippingRow(Icons.schedule, 'Delivery within 3-5 business days'),
        _buildShippingRow(Icons.replay, '30-day return policy'),
        _buildShippingRow(Icons.inventory, 'Ships from Portsmouth, UK'),
        _buildShippingRow(Icons.verified_user, 'Secure payment processing'),
      ],
    );
  }

  Widget _buildShippingRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                '${_product!.rating}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < _product!.rating.floor()
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  );
                }),
              ),
              Text(
                '${_product!.reviewCount} reviews',
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

      const SizedBox(height: 20),

      ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Write a review feature coming soon!'),
            ),
          );
        },
        child: const Text('Write a Review'),
      ),
    ],
  );
}

Widget _buildRatingBar(String label, double percentage) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 10),
        const Icon(Icons.star, size: 14, color: Colors.amber),
        const SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${(percentage * 100).toInt()}%',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}

Widget _buildRelatedProducts() {
  final relatedProducts = _dataService
      .getProductsByCollection(_product!.collectionId)
      .where((p) => p.id != _product!.id)
      .take(4)
      .toList();

  if (relatedProducts.isEmpty) {
    return const SizedBox.shrink();
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You May Also Like',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/product',
                        arguments: product.id,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              product.images.first,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade300,
                                  child: const Icon(
                                    Icons.shopping_bag,
                                    size: 40,
                                  ),
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
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '£${product.price.toStringAsFixed(2)}',
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
