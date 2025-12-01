# Requirements Document
---

## 1. Project Overview

### Purpose
Recreate the University of Portsmouth Student Union e-commerce website (shop.upsu.net) using Flutter for web, focusing on mobile-first design with desktop responsiveness.

### Scope
This is a university coursework project implementing core e-commerce functionality including product browsing, cart management, user authentication, and mock checkout process.

### Assessment Focus
- **Functionality:** 30% (features from reference website)
- **Software Development Practices:** 25% (Git usage, README, testing, external services)

---

## 2. Functional Requirements

### 2.1 Basic Features (40% of Application Marks)

#### Static Homepage (5%)
**User Story:** As a visitor, I want to see the shop homepage with products so I can browse available items.

**Acceptance Criteria:**
- Homepage layout matches mobile view of shop.upsu.net
- Product grid with hardcoded product data
- App bar with branding
- Basic navigation elements
- **Note:** Data can be hardcoded; focus on layout

**Reference:** [shop.upsu.net](https://shop.upsu.net)

---

#### About Us Page (5%)
**User Story:** As a visitor, I want to learn about the shop so I understand the business.

**Acceptance Criteria:**
- Separate page from homepage
- Company/organization information
- Navigation to/from homepage
- Static content acceptable

**Reference:** [shop.upsu.net/pages/about-us](https://shop.upsu.net/pages/about-us)

---

#### Footer (4%)
**User Story:** As a user, I want footer links to access additional pages and information.

**Acceptance Criteria:**
- Footer present on at least one page
- Contains links (dummy links acceptable)
- Displays shop information
- Responsive layout

**Reference:** Any page on shop.upsu.net

---

#### Dummy Collections Page (5%)
**User Story:** As a shopper, I want to see product collections so I can browse by category.

**Acceptance Criteria:**
- Page showing various collections
- Hardcoded data acceptable
- Grid/list layout of collections
- Visual representation of each collection

**Reference:** [shop.upsu.net/collections](https://shop.upsu.net/collections)

---

#### Dummy Collection Detail Page (5%)
**User Story:** As a shopper, I want to see products in a collection with filters and sorting options.

**Acceptance Criteria:**
- Shows products within one collection
- Includes filter dropdowns (non-functional acceptable)
- Includes sort dropdowns (non-functional acceptable)
- Hardcoded product data acceptable
- Product grid layout

**Reference:** [shop.upsu.net/collections/mens-hoodies](https://shop.upsu.net/collections/mens-hoodies)

---

#### Dummy Product Page (4%)
**User Story:** As a shopper, I want to see detailed product information.

**Acceptance Criteria:**
- Product detail page with:
  - Product images
  - Name and description
  - Price
  - Size/color dropdowns (non-functional acceptable)
  - Add to cart button (non-functional acceptable)
  - Quantity selector (non-functional acceptable)
- Hardcoded data acceptable

**Reference:** [Product Example](https://shop.upsu.net/products/university-of-portsmouth-hoodie)

---

#### Sale Collection (4%)
**User Story:** As a shopper, I want to see sale items with discounted prices.

**Acceptance Criteria:**
- Page showing sale products
- Original and sale prices visible
- Promotional messaging
- Sale badges on products
- Widgets non-functional acceptable

**Reference:** [shop.upsu.net/collections/sale](https://shop.upsu.net/collections/sale)

---

#### Authentication UI (3%)
**User Story:** As a visitor, I want to access login/signup forms.

**Acceptance Criteria:**
- Login page with email/password fields
- Signup page with registration form
- Forms displayed correctly
- Widgets non-functional acceptable at this level

**Reference:** [shop.upsu.net/account/login](https://shop.upsu.net/account/login)

---

#### Static Navbar (5%)
**User Story:** As a user, I want top navigation to access different sections.

**Acceptance Criteria:**
- Navigation bar on desktop view
- Contains shop branding and main links
- Collapses to menu button on mobile
- Links non-functional acceptable

**Reference:** Homepage navbar

---

### 2.2 Intermediate Features (35% of Application Marks)

#### Dynamic Collections Page (6%)
**User Story:** As a shopper, I want to browse collections populated from data with working filters.

**Acceptance Criteria:**
- Collections loaded from data models/services
- Sorting functionality works
- Filtering functionality works
- Pagination works
- Data from Firestore or similar service

**Reference:** [shop.upsu.net/collections](https://shop.upsu.net/collections)

---

#### Dynamic Collection Detail (6%)
**User Story:** As a shopper, I want to browse products with working sort/filter controls.

**Acceptance Criteria:**
- Products loaded from data models/services
- Sorting by price, name, etc. functions
- Filtering by size, color, etc. functions
- Pagination functions
- Real data display

**Reference:** [Collection Example](https://shop.upsu.net/collections/mens-hoodies)

---

#### Functional Product Pages (6%)
**User Story:** As a shopper, I want to interact with product options to configure my purchase.

**Acceptance Criteria:**
- Products loaded from data service
- Size/color dropdowns function correctly
- Quantity counter functions
- Add to cart button present (may not be fully functional yet)
- Dynamic price updates

**Reference:** [Product Example](https://shop.upsu.net/products/university-of-portsmouth-hoodie)

---

#### Shopping Cart (6%)
**User Story:** As a shopper, I want to add items to cart and view/manage my cart.

**Acceptance Criteria:**
- Add items to cart functionality
- View cart page showing added items
- Basic cart display (item, quantity, price)
- Checkout button places order without real payment
- Cart persists during session

**Reference:** [shop.upsu.net/cart](https://shop.upsu.net/cart)

---

#### Print Shack Personalization (3%)
**User Story:** As a customer, I want to personalize text on products.

**Acceptance Criteria:**
- Text personalization form page
- Associated about page for Print Shack
- Form dynamically updates based on selected fields
- Preview of personalized text

**Reference:** [shop.upsu.net/pages/print-shack](https://shop.upsu.net/pages/print-shack)

---

#### Full Navigation (3%)
**User Story:** As a user, I want to navigate smoothly across all pages.

**Acceptance Criteria:**
- All pages accessible via buttons
- Navbar links functional
- URL routing works correctly
- Back button functions
- No dead-end pages

**Reference:** All pages

---

#### Responsiveness (5%)
**User Story:** As a user on any device, I want the app to work correctly.

**Acceptance Criteria:**
- Mobile view (primary focus) works correctly
- Desktop view functions properly
- Layouts adapt to screen size
- No horizontal scrolling
- Touch targets appropriately sized
- **Note:** No real device testing required

**Reference:** Test on all pages

---

### 2.3 Advanced Features (25% of Application Marks)

#### Full Authentication System (8%)
**User Story:** As a user, I want to create an account and manage my profile.

**Acceptance Criteria:**
- User registration with email/password
- User login functionality
- Account dashboard with user info
- Profile editing
- Password reset
- Logout functionality
- Auth state persistence
- Can use Google/Facebook auth instead of Shop.app

**Reference:** [shop.upsu.net/account](https://shop.upsu.net/account)

---

#### Cart Management (6%)
**User Story:** As a shopper, I want full control over my cart contents.

**Acceptance Criteria:**
- Edit quantities in cart
- Remove items from cart
- Automatic price calculations
- Cart persistence across sessions
- Clear cart functionality
- Stock validation
- Empty cart state

**Reference:** [shop.upsu.net/cart](https://shop.upsu.net/cart)

---

#### Search System (4%)
**User Story:** As a shopper, I want to search for products by name.

**Acceptance Criteria:**
- Search button functional in navbar
- Search button functional in footer
- Search input field
- Search results display
- Results relevant to query
- No results state

**Reference:** Search feature on shop.upsu.net

---

## 3. Non-Functional Requirements

### 3.1 Performance
- Initial load < 5 seconds
- Smooth scrolling (60fps target)
- Image loading optimized
- No blocking operations on UI thread

### 3.2 Security
- Firebase Authentication for user management
- Firestore Security Rules implemented
- No sensitive data in client code
- HTTPS enforced (via Firebase Hosting)

### 3.3 Usability
- Mobile-first design
- Intuitive navigation
- Clear error messages
- Loading indicators for async operations
- Consistent design patterns

### 3.4 Browser Compatibility
**Primary:** Google Chrome (tested in DevTools mobile view)
**Secondary:** Firefox, Safari, Edge (basic functionality)

### 3.5 Responsiveness Breakpoints
- **Mobile:** < 600px width (primary focus)
- **Tablet:** 600-900px width
- **Desktop:** > 900px width

---

## 4. Technical Requirements

### 4.1 Technology Stack

**Frontend:**
- Flutter (Web)
- Dart language

**Backend/Services:**
- Firebase Authentication (required for external services marks)
- Cloud Firestore (required for external services marks)
- Firebase Hosting (optional, for deployment)

**State Management:**
- Provider (recommended) or Riverpod

**Additional Packages:**
- Standard Flutter packages as needed

---

### 4.2 Data Models

#### Product
```dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final List<String> images;
  final List<String> sizes;
  final List<String> colors;
  final String category;
  final String collectionId;
  final bool isOnSale;
  final bool inStock;
  final String sku;
  final List<String> features;
  final double rating;
  final int reviewCount;
  }
```

#### Cart Item
```dart
class CartItem {
  final Product product;
  final String selectedSize;
  final String selectedColor;
  int quantity;
}
```

#### Order (Mock)
```dart
class Collection {
  final String id;
  final String name;
  final String description;
  final String image;
  final int itemCount;
  final String colorHex;
}
```

---

### 4.3 Firebase Collections

**Required Collections:**
1. `products` - Product catalog
2. `users` - User profiles
3. `carts` - User shopping carts
4. `orders` - Order records (mock payment)

**Optional:**
5. `categories` - Product categories
6. `reviews` - Product reviews

---

## 5. Software Development Practices (25% of Marks)

### 5.1 Git Usage (8%)

**Requirements:**
- Regular commits throughout development
- Small, meaningful commits (not bulk changes)
- Clear commit messages describing changes
- Commit history shows incremental development

**Example Good Messages:**
- "Add product card widget"
- "Implement cart provider"
- "Fix responsive layout on product grid"

**Example Poor Messages:**
- "update"
- "fix"
- "changes"

---

### 5.2 README (5%)

**Required Sections:**
- Project title and description
- Features implemented
- Screenshots (at least 3)
- Technology stack
- Installation instructions
- Firebase setup guide
- How to run the app
- Project structure overview
- External services used (Firebase Auth + Firestore minimum)
- Author and course information

**Reference:** Worksheet 4 for README guidance

---

### 5.3 Testing (6%)

**Requirements:**
- Tests covering all or almost all application
- All tests must pass
- **Target:** High coverage (instructor checking coverage command)

---

### 5.4 External Services (6%)

**Requirements:**
- Integrate at least 2 separate external services
- Must document integration in README
- Must explain how services are used

**Examples:**
- Firebase Authentication (user login/signup)
- Cloud Firestore (product database, cart storage, orders)
- Firebase Hosting (live deployment with URL)
- Firebase Storage (product images, optional)

**To Get Full Marks:**
- Document each service in README
- Provide live link if hosted
- Explain purpose of each service

---
