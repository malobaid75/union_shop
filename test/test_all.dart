import 'models/product_test.dart' as product_test;
import 'models/cart_items_test.dart' as cart_item_test;
import 'services/data_service_test.dart' as data_service_test;

// Main test runner that runs all test suites
void main() {
  // Model tests
  product_test.main();
  cart_item_test.main();
  
  // Service tests
  data_service_test.main();
  
}
