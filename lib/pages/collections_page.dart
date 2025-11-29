import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/footer.dart';
import '../services/data_service.dart';
import '../models/collection.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  final DataService _dataService = DataService();
  
  String _sortBy = 'Name: A-Z';
  String _filterBy = 'All';
  int _currentPage = 1;
  final int _itemsPerPage = 6;
  
  List<Collection> _collections = [];
  List<Collection> _filteredCollections = [];

  @override
  void initState() {
    super.initState();
    _loadCollections();
  }

  void _loadCollections() {
    _collections = _dataService.getCollections();
    _applyFiltersAndSort();
  }

  void _applyFiltersAndSort() {
    // Apply filter
    if (_filterBy == 'All') {
      _filteredCollections = List.from(_collections);
    } else {
      _filteredCollections = _collections.where((c) {
        final productCount = _dataService.getProductsByCollection(c.id).length;
        switch (_filterBy) {
          case 'Small (1-5 items)':
            return productCount >= 1 && productCount <= 5;
          case 'Medium (6-10 items)':
            return productCount >= 6 && productCount <= 10;
          case 'Large (10+ items)':
            return productCount > 10;
          default:
            return true;
        }
      }).toList();
    }

    // Apply sort
    switch (_sortBy) {
      case 'Name: A-Z':
        _filteredCollections.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Name: Z-A':
        _filteredCollections.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'Most Products':
        _filteredCollections.sort((a, b) {
          final aCount = _dataService.getProductsByCollection(a.id).length;
          final bCount = _dataService.getProductsByCollection(b.id).length;
          return bCount.compareTo(aCount);
        });
        break;
      case 'Least Products':
        _filteredCollections.sort((a, b) {
          final aCount = _dataService.getProductsByCollection(a.id).length;
          final bCount = _dataService.getProductsByCollection(b.id).length;
          return aCount.compareTo(bCount);
        });
        break;
    }

    // Reset to first page when filters change
    _currentPage = 1;
    setState(() {});
  }

  List<Collection> get _paginatedCollections {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    
    if (startIndex >= _filteredCollections.length) {
      return [];
    }
    
    return _filteredCollections.sublist(
      startIndex,
      endIndex > _filteredCollections.length ? _filteredCollections.length : endIndex,
    );
  }

  int get _totalPages {
    return (_filteredCollections.length / _itemsPerPage).ceil();
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
            _buildPageHeader(),
            _buildBreadcrumb(),
            _buildFiltersSection(),
            _buildResultsInfo(),
            _buildCollectionsGrid(),
            if (_totalPages > 1) _buildPagination(),
            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
      ),
    );
  }

 Widget _buildPageHeader() {
  return Stack(
    children: [
      // Background banner image
      Positioned.fill(
        child: Image.network(
          'https://picsum.photos/seed/shop-collections/1600/500',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(color: Colors.purple.shade400);
          },
        ),
      ),

      // Dark overlay for readability
      Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.3),
        ),
      ),

      // Foreground title/content
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
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
              'Browse our ${_collections.length} curated product collections',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ],
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
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 14,
              ),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          const Text(
            'Collections',
            style: TextStyle(
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
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                Expanded(child: _buildSortDropdown()),
                const SizedBox(width: 15),
                Expanded(child: _buildFilterDropdown()),
                const SizedBox(width: 15),
                _buildResetButton(),
              ],
            );
          } else {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildSortDropdown()),
                    const SizedBox(width: 10),
                    Expanded(child: _buildFilterDropdown()),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: _buildResetButton(),
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
          hint: const Text('Sort by'),
          items: [
            'Name: A-Z',
            'Name: Z-A',
            'Most Products',
            'Least Products',
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

  Widget _buildFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _filterBy,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          hint: const Text('Filter by'),
          items: [
            'All',
            'Small (1-5 items)',
            'Medium (6-10 items)',
            'Large (10+ items)',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              _filterBy = newValue;
              _applyFiltersAndSort();
            }
          },
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return OutlinedButton.icon(
      onPressed: () {
        setState(() {
          _sortBy = 'Name: A-Z';
          _filterBy = 'All';
          _currentPage = 1;
          _applyFiltersAndSort();
        });
      },
      icon: const Icon(Icons.refresh, size: 18),
      label: const Text('Reset'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  Widget _buildResultsInfo() {
    final startItem = (_currentPage - 1) * _itemsPerPage + 1;
    final endItem = _currentPage * _itemsPerPage > _filteredCollections.length
        ? _filteredCollections.length
        : _currentPage * _itemsPerPage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _filteredCollections.isEmpty
                ? 'No collections found'
                : 'Showing $startItem-$endItem of ${_filteredCollections.length} collections',
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

  Widget _buildCollectionsGrid() {
    if (_filteredCollections.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            Icon(
              Icons.collections_bookmark_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              'No collections found',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Try adjusting your filters',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _sortBy = 'Name: A-Z';
                  _filterBy = 'All';
                  _applyFiltersAndSort();
                });
              },
              child: const Text('Reset Filters'),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
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
              childAspectRatio: 1.1,
            ),
            itemCount: _paginatedCollections.length,
            itemBuilder: (context, index) {
              final collection = _paginatedCollections[index];
              return _buildCollectionCard(collection);
            },
          );
        },
      ),
    );
  }

  Widget _buildCollectionCard(Collection collection) {
    final productCount = _dataService.getProductsByCollection(collection.id).length;
    final accentColor = _hexToColor(collection.colorHex);

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
            arguments: collection.name,
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
                    collection.image,
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
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$productCount items',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Text(
                      collection.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
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
                      collection.description,
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
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/collection',
                              arguments: collection.name,
                            );
                          },
                          icon: const Icon(Icons.arrow_forward, size: 18),
                          label: const Text('View Collection'),
                          style: TextButton.styleFrom(
                            foregroundColor: accentColor,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: accentColor,
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
          // Previous Button
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentPage > 1
                ? () {
                    setState(() {
                      _currentPage--;
                    });
                  }
                : null,
            color: _currentPage > 1 ? Colors.blue.shade700 : Colors.grey,
          ),
          
          // Page Numbers
          ..._buildPageNumbers(),
          
          // Next Button
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentPage < _totalPages
                ? () {
                    setState(() {
                      _currentPage++;
                    });
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
      if (i == 1 || i == _totalPages || (i >= _currentPage - 1 && i <= _currentPage + 1)) {
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