import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/footer.dart';
import '../services/data_service.dart';
import '../models/product.dart';

class SearchPage extends StatefulWidget {
  final String? initialQuery;

  const SearchPage({
    super.key,
    this.initialQuery,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final DataService _dataService = DataService();
  final TextEditingController _searchController = TextEditingController();
  
  List<Product> _searchResults = [];
  bool _isSearching = false;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    // If initial query provided, perform search
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _searchController.text = widget.initialQuery!;
      _performSearch(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Perform search using DataService
  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _hasSearched = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // Simulate slight delay for better UX
    Future.delayed(const Duration(milliseconds: 300), () {
      final results = _dataService.searchProducts(query.trim());
      
      setState(() {
        _searchResults = results;
        _isSearching = false;
        _hasSearched = true;
      });
    });
  }

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
            _buildSearchHeader(),
            _buildBreadcrumb(),
            _buildSearchBar(),
            _buildSearchResults(),
            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
      ),
    );
  }

  /// Build search header
  Widget _buildSearchHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade700, Colors.orange.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.search,
            color: Colors.white,
            size: 50,
          ),
          const SizedBox(height: 15),
          const Text(
            'SEARCH PRODUCTS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Find your perfect university merchandise',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// Build breadcrumb navigation
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
          const Text(
            'Search',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  /// Build search bar
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for products, collections, or categories...',
            prefixIcon: const Icon(Icons.search, size: 28),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchResults = [];
                        _hasSearched = false;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
          onChanged: (value) {
            setState(() {}); // Update to show/hide clear button
          },
          onSubmitted: (value) {
            _performSearch(value);
          },
        ),
      ),
    );
  }

  /// Build search results section
  Widget _buildSearchResults() {
    // Show loading indicator
    if (_isSearching) {
      return const Padding(
        padding: EdgeInsets.all(60),
        child: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Searching...'),
            ],
          ),
        ),
      );
    }

    // Show empty state if no search performed
    if (!_hasSearched) {
      return _buildEmptyState();
    }

    // Show no results message
    if (_searchResults.isEmpty) {
      return _buildNoResults();
    }

    // Show search results
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Results count
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Found ${_searchResults.length} ${_searchResults.length == 1 ? 'result' : 'results'} for "${_searchController.text}"',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),

          // Product grid
          LayoutBuilder(
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
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final product = _searchResults[index];
                  return _buildProductCard(product);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// Build empty state (no search performed yet)
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(60),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 100,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Text(
            'Start Searching',
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Enter a search term to find products',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 30),
          
          // Popular searches
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _buildPopularSearchChip('Hoodie'),
              _buildPopularSearchChip('T-Shirt'),
              _buildPopularSearchChip('Mug'),
              _buildPopularSearchChip('Bag'),
              _buildPopularSearchChip('Notebook'),
            ],
          ),
        ],
      ),
    );
  }

  /// Build popular search chip
  Widget _buildPopularSearchChip(String term) {
    return ActionChip(
      label: Text(term),
      onPressed: () {
        _searchController.text = term;
        _performSearch(term);
      },
      backgroundColor: Colors.orange.shade50,
      side: BorderSide(color: Colors.orange.shade200),
    );
  }

  /// Build no results state
  Widget _buildNoResults() {
    return Container(
      padding: const EdgeInsets.all(60),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 100,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Text(
            'No Results Found',
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'We couldn\'t find any products matching "${_searchController.text}"',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _searchController.clear();
                _searchResults = [];
                _hasSearched = false;
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Another Search'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/collections'),
            child: const Text('Browse All Collections'),
          ),
        ],
      ),
    );
  }

  /// Build product card
  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Navigate to product page
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
                              fontSize: 14,
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
                        Text(
                          product.category,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
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
