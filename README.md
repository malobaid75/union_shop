# Union Shop - Flutter E-Commerce Application

A full-featured e-commerce application for the University of Portsmouth Students' Union, built with Flutter and Firebase. This application allows students to browse and purchase university merchandise with features including authentication, shopping cart, product personalization, and order management.

## Documentation
- **[Requirements](REQUIREMENTS.md)** - Complete project requirements based on coursework specification
- **[AI Usage](AI_PROMPTS.md)** - AI-driven development documentation
- **[Deployment Guide](DEPLOYMENT.md)** - Firebase deployment instructions

## Live Demo

*Deployed Application*: [https://union-shop-18031.web.app/](https://union-shop-18031.web.app/)

## Features

### Basic Features
- *Static Navbar* - Responsive navigation with mobile drawer
- *Footer* - Comprehensive footer with links and search
- *Static Homepage* - Hero banner, featured collections, popular products
- *About Us Page* - Company information, mission, vision, values
- *Dummy Collections Page* - Display of product collections
- *Dummy Collection Page* - Products within a collection
- *Dummy Product Page* - Detailed product information
- *Sale Collection* - Sale products with discounts
- *Authentication UI* - Login and registration forms

### Intermediate Features
- *Dynamic Collections Page* - Collections from data models with sorting, filtering, pagination
- *Dynamic Collection Page* - Products with working filters (size, color, price), sorting, pagination
- *Functional Product Pages* - Working dropdowns, counters, size/color selectors
- *Shopping Cart* - Add/remove items, quantity management, checkout
- *Print Shack* - Text personalization with dynamic preview
- *Full Navigation* - Complete navigation across all pages
- *Responsiveness* - Adaptive layouts for mobile and desktop

### Advanced Features 
- *Authentication System* - Firebase Authentication with email/password
- *Cart Management* - Firestore persistence, order placement, order history
- *Search System* - Product search with navbar and footer search bars
- *External Services* - Firebase Auth, Firestore Database, Firebase Hosting

## Architecture

### Technology Stack

*Frontend*
- *Flutter* 3.x - Cross-platform UI framework
- *Dart* 3.x - Programming language

*Backend & Services*
- *Firebase Authentication* - User authentication and account management
- *Cloud Firestore* - NoSQL database for cart and order persistence
- *Firebase Hosting* - Web application hosting

*State Management*
- Provider pattern with ChangeNotifier
- Service-based architecture

### Project Structure

```text
lib/
├── main.dart                  # Application entry point
├── models/                    # Data models
│   ├── product.dart          # Product model
│   ├── collection.dart       # Collection model
│   └── cart_item.dart        # Cart item model
├── services/                  # Business logic services
│   ├── auth_service.dart     # Authentication service
│   ├── cart_service.dart     # Shopping cart service
│   └── data_service.dart     # Product data service
├── pages/                     # Application screens
│   ├── home_page.dart        # Homepage
│   ├── auth_page.dart        # Login/Signup
│   ├── collections_page.dart # Collections listing
│   ├── collection_page.dart  # Single collection view
│   ├── product_page.dart     # Product details
│   ├── cart_page.dart        # Shopping cart
│   ├── sale_page.dart        # Sale products
│   ├── search_page.dart      # Search results
│   ├── print_shack_page.dart # Product personalization
│   ├── account_dashboard_page.dart # User dashboard
│   ├── orders_page.dart      # Order history
│   └── about_page.dart       # About us
└── widgets/                   # Reusable widgets
    ├── navbar.dart           # Navigation bar
    ├── mobile_drawer.dart    # Mobile menu
    └── footer.dart           # Footer component
```


## External Services Integration

### 1. Firebase Authentication

*Purpose*: User authentication and account management

*Implementation*:
- Email/password authentication
- User profile storage
- Password reset functionality
- Protected routes for authenticated users

*Configuration* (lib/services/auth_service.dart):
dart
final FirebaseAuth _auth = FirebaseAuth.instance;


*Features*:
- User registration with email validation
- Secure login with error handling
- Account dashboard with profile management
- Sign out functionality
- Password reset via email

*Firestore Integration*:
- User profiles stored in users collection
- Fields: uid, email, fullName, createdAt, orders, wishlist

---

### 2. Cloud Firestore Database

*Purpose*: Real-time data persistence for cart and orders

*Collections Structure*:

#### Users Collection (users)

```json
{
  "uid": "user_id",
  "email": "user@gmail.com",
  "fullName": "John Doe",
  "createdAt": "Timestamp",
  "orders": ["order_id_1", "order_id_2"],
  "wishlist": []
}
```

#### Carts Collection (carts)
```json
{
  "userId": "user_id",
  "items": [
    {
      "productId": "prod_001",
      "productName": "University Hoodie",
      "productPrice": 35.00,
      "productImage": "url",
      "selectedSize": "M",
      "selectedColor": "Navy",
      "quantity": 2
    }
  ],
  "subtotal": 70.00,
  "total": 88.99,
  "itemCount": 2,
  "lastUpdated": "Timestamp"
}
```

#### Orders Collection (orders)
```json
{
  "orderId": "ORD-1234567890",
  "userId": "user_id",
  "userEmail": "user@gamil.com",
  "userName": "John Doe",
  "items": [...],
  "subtotal": 70.00,
  "shipping": 5.99,
  "tax": 14.00,
  "total": 89.99,
  "totalSavings": 10.00,
  "itemCount": 2,
  "status": "pending",
  "createdAt": "Timestamp"
}
```

*Implementation* (lib/services/cart_service.dart):

*Features*:
- Real-time cart synchronization
- Persistent cart across sessions
- Order history tracking
- User-specific data isolation
---

### 3. Firebase Hosting

*Purpose*: Deploy and host the web application

*Deployment Process*:
1. Build Flutter web app: flutter build web
2. Deploy to Firebase: firebase deploy --only hosting
3. Access at: https://your-app-name.web.app

---

*Firebase Authentication Settings*:
- Email/Password provider enabled
- Email verification optional (can be enabled)
- Password reset enabled

---

## Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Firebase account
- Git
- Code editor (VS Code)

### Installation

1. *Clone the repository*
bash
   git clone https://github.com/malobaid75/union_shop.git
   cd union_shop


2. *Install dependencies*
bash
   flutter pub get


3. *Set up Firebase*
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication (Email/Password)
   - Create a Firestore Database
   - Register your web app and copy the configuration
   - Update lib/main.dart with your Firebase configuration

4. *Run the application*

   ## For web (Chrome)
   flutter run -d chrome
  
### Firebase Setup

#### 1. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: "union-shop"
4. Disable Google Analytics (optional)
5. Click "Create project"

#### 2. Enable Authentication
1. In Firebase Console, go to "Authentication"
2. Click "Get started"
3. Enable "Email/Password" provider
4. Click "Save"

#### 3. Create Firestore Database
1. In Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. Start in "test mode" (for development)
4. Choose location: europe-west2 (London)
5. Click "Enable"

#### 4. Register Web App
1. In Firebase Console, click the web icon (</>)
2. Register app name: "Union Shop Web"
3. Copy the firebaseConfig values
4. Update lib/main.dart with these values

#### 5. Deploy Firestore Rules
1. In Firebase Console, go to "Firestore Database" > "Rules"
2. Copy the rules from the Security Rules section above
3. Click "Publish"


## Testing
The test suite provides coverage of Union Shop Application.

### Test Structure

```text
test/
├── models/                 # Model unit tests
│   ├── product_test.dart
│   └── cart_item_test.dart
├── services/               # Service unit tests
│   └── data_service_test.dart
└── test_all.dart          # Test runner
```

### Running all Tests
```bash
flutter test
```

### Run specific test file
```bash
flutter test test/models/product_test.dart
```
Test files are located in the test/ directory.


## Build & Deployment

### Build for Web
```bash
flutter build web --release
```
The built files will be in build/web/

### Deploy to Firebase Hosting

1. *Install Firebase CLI*
```bash
   npm install -g firebase-tools
```

2. *Login to Firebase*
```bash
   firebase login
```

3. *Initialize Firebase Hosting*
```bash
   firebase init hosting
```

   - Select your Firebase project
   - Set public directory: build/web
   - Configure as single-page app: Yes
   - Don't overwrite index.html

4. *Deploy*
```bash
   flutter build web --release
   firebase deploy --only hosting
```

5. *Access your app*

   https://your-project-id.web.app


## Data Models

### Product Model
```text
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


### Cart Item Model
```bash
class CartItem {
  final Product product;
  final String selectedSize;
  final String selectedColor;
  int quantity;
  
  double get totalPrice => product.price * quantity;
}
```

## Security Considerations

- Firebase Authentication for secure user management
- Firestore security rules to protect user data
- HTTPS by default with Firebase Hosting
- Input validation on forms
- No sensitive data stored in client-side code
- User-specific data isolation


## Known Issues & Limitations

- Search is basic text matching (no fuzzy search or advanced filters)
- Payment integration not implemented (checkout is simulated)
- Email verification not enforced (can be enabled in Firebase)

## Future Enhancements

- Payment gateway integration (Stripe/PayPal)
- Real-time inventory management
- Product reviews and ratings
- Wishlist with persistence
- Email notifications for orders
- Admin dashboard for order management
- Multiple payment methods
- Shipping tracking


## Acknowledgments

- University of Portsmouth Students' Union for project inspiration
- Flutter documentation and community
- Firebase documentation




