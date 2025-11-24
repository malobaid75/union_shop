import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/footer.dart';
import '../services/data_service.dart';
import '../models/product.dart';
import '../models/collection.dart';

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
  final DataService _dataService = DataService();

  String _sortBy = 'Featured';
  String _sizeFilter = 'All Sizes';
  String _colorFilter = 'All Colors';
  String _priceFilter = 'All Prices';
  int _currentPage = 1;
  final int _itemsPerPage = 12;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  Collection? _collection;

  // Get all unique sizes from products
  List<String> _availableSizes = ['All Sizes'];
  // Get all unique colors from products
  List<String> _availableColors = ['All Colors'];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    // Get collection
    _collection = _dataService.getCollectionByName(widget.collectionName);

    if (_collection != null) {
      // Get products for this collection
      _allProducts = _dataService.getProductsByCollection(_collection!.id);

      // Extract available sizes and colors
      Set<String> sizes = {'All Sizes'};
      Set<String> colors = {'All Colors'};

      for (var product in _allProducts) {
        sizes.addAll(product.sizes);
        colors.addAll(product.colors);
      }

      _availableSizes = sizes.toList();
      _availableColors = colors.toList();

      _applyFiltersAndSort();
    }
  }

  void _applyFiltersAndSort() {
    _filteredProducts = List.from(_allProducts);

    // Apply size filter
    if (_sizeFilter != 'All Sizes') {
      _filteredProducts = _filteredProducts
          .where((p) => p.sizes.contains(_sizeFilter))
          .toList();
    }

    // Apply color filter
    if (_colorFilter != 'All Colors') {
      _filteredProducts = _filteredProducts
          .where((p) => p.colors.contains(_colorFilter))
          .toList();
    }

    // Apply price filter
    if (_priceFilter != 'All Prices') {
      _filteredProducts = _filteredProducts.where((p) {
        switch (_priceFilter) {
          case 'Under £20':
            return p.price < 20;
          case '£20 - £40':
            return p.price >= 20 && p.price <= 40;
          case '£40 - £60':
            return p.price > 40 && p.price <= 60;
          case 'Over £60':
            return p.price > 60;
          default:
            return true;
        }
      }).toList();
    }

    // Apply sorting
    _filteredProducts = _dataService.sortProducts(_filteredProducts, _sortBy);

    // Reset to first page when filters change
    _currentPage = 1;
    setState(() {});
  }

  List<Product> get _paginatedProducts {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;

    if (startIndex >= _filteredProducts.length) {
      return [];
    }

    return _filteredProducts.sublist(
      startIndex,
      endIndex > _filteredProducts.length
          ? _filteredProducts.length
          : endIndex,
    );
  }

  int get _totalPages {
    return (_filteredProducts.length / _itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    if (_collection == null) {
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
                'Collection not found',
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/collections'),
                child: const Text('View All Collections'),
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
            _buildPageHeader(),
            _buildBreadcrumb(),
            _buildFiltersSection(),
            _buildResultsInfo(),
            _buildProductsGrid(),
            if (_totalPages > 1) _buildPagination(),
            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    final accentColor = _hexToColor(_collection!.colorHex);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accentColor, accentColor.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            _collection!.name.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _collection!.description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            '${_allProducts.length} products available',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
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
          Text(
            _collection!.name,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          LayoutBuilder(
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
          const SizedBox(height: 15),
          _buildActiveFilters(),
        ],
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
          items: [
            'Featured',
            'Price: Low to High',
            'Price: High to Low',
            'Newest',
            'Best Selling'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              _sortBy = newValue;
              _applyFiltersAndSort();
            }
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
          items: _availableSizes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              _sizeFilter = newValue;
              _applyFiltersAndSort();
            }
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
          items: _availableColors.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              _colorFilter = newValue;
              _applyFiltersAndSort();
            }
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
          items: [
            'All Prices',
            'Under £20',
            '£20 - £40',
            '£40 - £60',
            'Over £60'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              _priceFilter = newValue;
              _applyFiltersAndSort();
            }
          },
        ),
      ),
    );
  }

  Widget _buildActiveFilters() {
    List<String> activeFilters = [];
    if (_sizeFilter != 'All Sizes') activeFilters.add(_sizeFilter);
    if (_colorFilter != 'All Colors') activeFilters.add(_colorFilter);
    if (_priceFilter != 'All Prices') activeFilters.add(_priceFilter);

    if (activeFilters.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Active Filters:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...activeFilters.map((filter) => Chip(
                        label: Text(
                          filter,
                          style: const TextStyle(fontSize: 12),
                        ),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          setState(() {
                            if (_availableSizes.contains(filter)) {
                              _sizeFilter = 'All Sizes';
                            } else if (_availableColors.contains(filter)) {
                              _colorFilter = 'All Colors';
                            } else {
                              _priceFilter = 'All Prices';
                            }
                            _applyFiltersAndSort();
                          });
                        },
                        backgroundColor: Colors.blue.shade50,
                        deleteIconColor: Colors.blue.shade700,
                        labelStyle: TextStyle(color: Colors.blue.shade700),
                      )),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _sizeFilter = 'All Sizes';
                        _colorFilter = 'All Colors';
                        _priceFilter = 'All Prices';
                        _sortBy = 'Featured';
                        _applyFiltersAndSort();
                      });
                    },
                    icon: const Icon(Icons.clear_all, size: 16),
                    label: const Text('Clear All', style: TextStyle(fontSize: 12)),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: const Size(0, 32),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResultsInfo() {
    final startItem = _filteredProducts.isEmpty
        ? 0
        : (_currentPage - 1) * _itemsPerPage + 1;
    final endItem = _currentPage * _itemsPerPage > _filteredProducts.length
        ? _filteredProducts.length
        : _currentPage * _itemsPerPage;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _filteredProducts.isEmpty
                ? 'No products found'
                : 'Showing $startItem-$endItem of ${_filteredProducts.length} products',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.grid_view, size: 22),
                color: Colors.blue.shade700,
                onPressed: () {},
                tooltip: 'Grid View',
              ),
              IconButton(
                icon: const Icon(Icons.view_list, size: 22),
                color: Colors.grey,
                onPressed: () {},
                tooltip: 'List View',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
    if (_filteredProducts.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              'No products match your filters',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Try adjusting your filters or clearing them',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _sizeFilter = 'All Sizes';
                  _colorFilter = 'All Colors';
                  _priceFilter = 'All Prices';
                  _sortBy = 'Featured';
                  _applyFiltersAndSort();
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Filters'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

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
            itemCount: _paginatedProducts.length,
            itemBuilder: (context, index) {
              final product = _paginatedProducts[index];
              return _buildProductCard(product);
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/product', arguments: product.id);
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
                    product.images.first,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.shopping_bag, size: 50),
                      );
                    },
                  ),
                  if (product.isOnSale)
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
                        child: Text(
                          '-${product.discountPercentage}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (!product.inStock)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: Text(
                            'OUT OF STOCK',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              '${product.rating}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              ' (${product.reviewCount})',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.originalPrice != null)
                          Text(
                            '£${product.originalPrice!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '£${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: product.isOnSale
                                    ? Colors.red
                                    : Colors.blue.shade700,
                              ),
                            ),
                            if (product.isOnSale && product.originalPrice != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Save £${product.savings.toStringAsFixed(2)}',
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

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentPage > 1
                ? () {
                    setState(() {
                      _currentPage--;
                    });
                    // Scroll to top
                    Scrollable.ensureVisible(
                      context,
                      duration: const Duration(milliseconds: 300),
                    );
                  }
                : null,
            color: _currentPage > 1 ? Colors.blue.shade700 : Colors.grey,
          ),
          ..._buildPageNumbers(),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentPage < _totalPages
                ? () {
                    setState(() {
                      _currentPage++;
                    });
                    // Scroll to top
                    Scrollable.ensureVisible(
                      context,
                      duration: const Duration(milliseconds: 300),
                    );
                  }
                : null,
            color: _currentPage < _totalPages ? Colors.blue.shade700 : Colors.grey,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> pageButtons = [];

    for (int i = 1; i <= _totalPages; i++) {
      if (i == 1 ||
          i == _totalPages ||
          (i >= _currentPage - 1 && i <= _currentPage + 1)) {
        pageButtons.add(_buildPageNumber(i, isActive: i == _currentPage));
      } else if (i == _currentPage - 2 || i == _currentPage + 2) {
        pageButtons.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text('...'),
          ),
        );
      }
    }

    return pageButtons;
  }

  Widget _buildPageNumber(int number, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          setState(() {
            _currentPage = number;
          });
          // Scroll to top
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 300),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 40,
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

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}