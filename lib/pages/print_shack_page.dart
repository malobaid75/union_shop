import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/footer.dart';
import '../services/cart_service.dart';
import '../services/data_service.dart';

class PrintShackPage extends StatefulWidget {
  const PrintShackPage({super.key});

  @override
  State<PrintShackPage> createState() => _PrintShackPageState();
}

class _PrintShackPageState extends State<PrintShackPage> {
  final DataService _dataService = DataService();
  final CartService _cartService = CartService();

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _customTextController = TextEditingController();

  // Selected options
  String _selectedProduct = 'T-Shirt';
  String _selectedSize = 'M';
  String _selectedColor = 'White';
  String _selectedPrintPosition = 'Front';
  String _selectedFontStyle = 'Arial';
  int _fontSize = 24;
  int _quantity = 1;

  // Available options
  final List<String> _products = ['T-Shirt', 'Hoodie', 'Jersey', 'Polo Shirt'];
  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  final List<String> _colors = ['White', 'Black', 'Navy', 'Grey', 'Red'];
  final List<String> _printPositions = ['Front', 'Back', 'Front & Back'];
  final List<String> _fontStyles = ['Arial', 'Times New Roman', 'Impact', 'Comic Sans'];

  // Pricing - dynamically calculated based on selections
  double get _basePrice {
    switch (_selectedProduct) {
      case 'Hoodie':
        return 35.00;
      case 'Jersey':
        return 28.00;
      case 'Polo Shirt':
        return 24.00;
      default: // T-Shirt
        return 18.00;
    }
  }

  double get _printPrice {
    double price = 5.00; // Base print price
    if (_selectedPrintPosition == 'Front & Back') price += 5.00;
    if (_fontSize > 30) price += 2.00; // Large text surcharge
    return price;
  }

  double get _totalPrice => (_basePrice + _printPrice) * _quantity;

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _customTextController.dispose();
    super.dispose();
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
            _buildMainContent(),
            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
      ),
    );
  }

  // Build page header with gradient background
  Widget _buildPageHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
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
            Icons.print,
            color: Colors.white,
            size: 50,
          ),
          const SizedBox(height: 15),
          const Text(
            'PRINT SHACK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Customize your merchandise with personalized text',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Build breadcrumb navigation
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
            'Print Shack',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Build main content with form and preview
  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            // Desktop layout: side by side
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildCustomizationForm()),
                const SizedBox(width: 30),
                Expanded(flex: 1, child: _buildPreviewSection()),
              ],
            );
          } else {
            // Mobile layout: stacked
            return Column(
              children: [
                _buildCustomizationForm(),
                const SizedBox(height: 30),
                _buildPreviewSection(),
              ],
            );
          }
        },
      ),
    );
  }

  // Build customization form with all input fields
  Widget _buildCustomizationForm() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customize Your Product',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Product selection dropdown
            _buildDropdown(
              'Product Type',
              _selectedProduct,
              _products,
              (value) {
                setState(() {
                  _selectedProduct = value!;
                });
              },
            ),
            const SizedBox(height: 15),

            // Size and color dropdowns in a row
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    'Size',
                    _selectedSize,
                    _sizes,
                    (value) {
                      setState(() {
                        _selectedSize = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildDropdown(
                    'Color',
                    _selectedColor,
                    _colors,
                    (value) {
                      setState(() {
                        _selectedColor = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            // Personalization section header
            const Text(
              'Personalization',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            // Name input field
            _buildTextField(
              'Name',
              'Enter name (e.g., SMITH)',
              _nameController,
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 15),

            // Number input field (for jersey numbers, etc.)
            _buildTextField(
              'Number (Optional)',
              'Enter number (e.g., 10)',
              _numberController,
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 15),

            // Custom text input field
            _buildTextField(
              'Custom Text (Optional)',
              'Enter custom text',
              _customTextController,
              maxLines: 2,
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 15),

            // Print position dropdown
            _buildDropdown(
              'Print Position',
              _selectedPrintPosition,
              _printPositions,
              (value) {
                setState(() {
                  _selectedPrintPosition = value!;
                });
              },
            ),
            const SizedBox(height: 15),

            // Font style dropdown - only show if text is entered
            if (_nameController.text.isNotEmpty || _customTextController.text.isNotEmpty)
              _buildDropdown(
                'Font Style',
                _selectedFontStyle,
                _fontStyles,
                (value) {
                  setState(() {
                    _selectedFontStyle = value!;
                  });
                },
              ),
            const SizedBox(height: 15),

            // Font size slider - only show if text is entered
            if (_nameController.text.isNotEmpty || _customTextController.text.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Font Size: $_fontSize',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Slider(
                    value: _fontSize.toDouble(),
                    min: 12,
                    max: 48,
                    divisions: 36,
                    label: '$_fontSize',
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value.toInt();
                      });
                    },
                  ),
                ],
              ),
            const SizedBox(height: 15),

            // Quantity selector
            _buildQuantitySelector(),
            const SizedBox(height: 20),

            // Price display
            _buildPriceDisplay(),
            const SizedBox(height: 20),

            // Add to cart button
            _buildAddToCartButton(),
          ],
        ),
      ),
    );
  }

  // Build dropdown widget - reusable component
  Widget _buildDropdown(
    String label,
    String value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  // Build text field widget - reusable component
  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType? keyboardType,
    int maxLines = 1,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  // Build quantity selector with increment/decrement buttons
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
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Decrement button
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _quantity > 1
                    ? () {
                        setState(() {
                          _quantity--;
                        });
                      }
                    : null,
              ),
              // Quantity display
              Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Increment button
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _quantity < 10
                    ? () {
                        setState(() {
                          _quantity++;
                        });
                      }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Build price display with breakdown
  Widget _buildPriceDisplay() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          _buildPriceRow('Base Price', '£${_basePrice.toStringAsFixed(2)}'),
          const SizedBox(height: 5),
          _buildPriceRow('Print Cost', '£${_printPrice.toStringAsFixed(2)}'),
          const SizedBox(height: 5),
          _buildPriceRow('Quantity', 'x$_quantity'),
          const Divider(),
          _buildPriceRow(
            'Total',
            '£${_totalPrice.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  // Build price row helper
  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? Colors.blue.shade700 : null,
          ),
        ),
      ],
    );
  }

  // Build add to cart button
  // Build add to cart button
Widget _buildAddToCartButton() {
  // Check if at least name is provided
  final bool canAddToCart = _nameController.text.isNotEmpty;

  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: canAddToCart
          ? () {
              // Get a product from the catalog to use as base
              final baseProduct = _dataService.getProducts().firstWhere(
                (p) => p.name.toLowerCase().contains(_selectedProduct.toLowerCase()),
                orElse: () => _dataService.getProducts().first,
              );

              // Create customization details string
              final customization = 'Custom: ${_nameController.text.toUpperCase()}'
                  '${_numberController.text.isNotEmpty ? ' #${_numberController.text}' : ''}'
                  '${_customTextController.text.isNotEmpty ? ' - ${_customTextController.text}' : ''}';

              // Add to cart with customization details
              _cartService.addItem(
                baseProduct,
                _selectedSize,
                '$_selectedColor - $customization',
                quantity: _quantity,
              );

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added custom $_selectedProduct to cart!',
                  ),
                  action: SnackBarAction(
                    label: 'VIEW CART',
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 3),
                ),
              );

              setState(() {
                _nameController.clear();
                _numberController.clear();
                _customTextController.clear();
                _quantity = 1;
              });
            }
          : null,
      icon: const Icon(Icons.shopping_cart),
      label: Text(
        canAddToCart ? 'ADD TO CART' : 'ENTER NAME TO CONTINUE',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: canAddToCart ? Colors.purple.shade700 : Colors.grey,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
  }

  // Build preview section showing how the product will look
  Widget _buildPreviewSection() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Product preview container
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: _getColorValue(_selectedColor),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Stack(
                children: [
                  // Product type indicator
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _selectedProduct,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Print position indicator
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade700,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _selectedPrintPosition,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Preview text in center
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Display name if entered
                        if (_nameController.text.isNotEmpty)
                          Text(
                            _nameController.text.toUpperCase(),
                            style: TextStyle(
                              fontSize: _fontSize.toDouble(),
                              fontWeight: FontWeight.bold,
                              color: _getTextColor(_selectedColor),
                              fontFamily: _selectedFontStyle,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        
                        // Display number if entered
                        if (_numberController.text.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Text(
                            _numberController.text,
                            style: TextStyle(
                              fontSize: (_fontSize + 20).toDouble(),
                              fontWeight: FontWeight.bold,
                              color: _getTextColor(_selectedColor),
                            ),
                          ),
                        ],

                        // Display custom text if entered
                        if (_customTextController.text.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Text(
                            _customTextController.text,
                            style: TextStyle(
                              fontSize: (_fontSize - 4).toDouble(),
                              color: _getTextColor(_selectedColor),
                              fontFamily: _selectedFontStyle,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],

                        // Placeholder text if nothing entered
                        if (_nameController.text.isEmpty &&
                            _numberController.text.isEmpty &&
                            _customTextController.text.isEmpty)
                          Text(
                            'Your design will\nappear here',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade400,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Info section
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 10),
                      const Text(
                        'Product Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow('Product', _selectedProduct),
                  _buildInfoRow('Size', _selectedSize),
                  _buildInfoRow('Color', _selectedColor),
                  _buildInfoRow('Print Position', _selectedPrintPosition),
                  if (_nameController.text.isNotEmpty || 
                      _customTextController.text.isNotEmpty)
                    _buildInfoRow('Font', _selectedFontStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build info row helper
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Helper method to get color value from string
  Color _getColorValue(String colorName) {
    switch (colorName) {
      case 'Black':
        return Colors.black;
      case 'Navy':
        return Colors.blue.shade900;
      case 'Grey':
        return Colors.grey.shade600;
      case 'Red':
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  // Helper method to get appropriate text color based on background
  Color _getTextColor(String backgroundColor) {
    return backgroundColor == 'White' || backgroundColor == 'Grey'
        ? Colors.black
        : Colors.white;
  }
}