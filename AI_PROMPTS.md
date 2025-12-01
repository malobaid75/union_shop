# AI-Driven Development Documentation
## Overview

This document demonstrates the use of AI-driven development following **Prompt-Driven Development (PDD)** principles taught in Worksheet 6. All AI interactions were structured to guide development systematically rather than relying on "vibe coding."

---

## 1. UI Development & Layout

### Home Page Design Enhancement
**Initial Prompt:**
```
I need to improve the home page design of my Flutter e-commerce app. 
Currently it's basic and needs a modern, professional look. The home page 
should include:
- A hero section with promotional banner
- Featured products section
- Categories grid
- Search functionality
Make it visually appealing and modern.
```

**Refinement Prompt:**
```
The home page looks good but needs more polish. Can you:
1. Add smooth scrolls when products load
2. Include a carousel for featured collections
3. Add skeleton loaders while products fetch from Firebase
4. Ensure the design is mobile-first responsive
5. Add hover effects on product cards for better interactivity
```

**Outcome:**
- Created visually appealing home page with modern UI components
- Added interactive elements
- Files: `lib/pages/home_page.dart`, `lib/main.dart`

---

### Product Card Responsive Issues  
**Problem:** Overflow errors in grid layout

**Prompt:**
```
fix the responsive issues
[Provided collection_page.dart code and screenshot showing "BOTTOM OVERFLOWED BY..." error]

The product cards overflow in GridView. Cards have: image, sale badge, product name 
(2 lines), rating, price, savings badge. Fix overflow and ensure consistent card 
heights in grid layout.
```

**Refinement Prompt:**
```
I have a product card widget in my Flutter e-commerce app that's showing 
overflow errors. The card has:
- Product image with aspect ratio
- Sale badge overlay
- Favorite button
- Product name (2 lines)
- Rating with star icon
- Price and savings badge

The cards are displayed in a GridView and overflow on smaller screens. 
Here's the current code: [provided code]

Please fix the responsive issues ensuring:
1. Cards maintain consistent size in grid
2. No overflow errors on any screen size
3. Text truncates properly
4. All elements remain visible and properly spaced
```

**Solution Applied:**
- Replaced `Expanded` with `AspectRatio(aspectRatio: 1.0)`
- Used `Flexible` widgets for text
- Added proper `overflow: TextOverflow.ellipsis`
- Reduced padding and font sizes proportionally

**Files Modified:** `lib/pages/collection_page.dart`

---

## 2. Navigation & Routing

### Drawer Menu Implementation
**Prompt:**
```
Add a navigation drawer to my Flutter e-commerce app with links to:
- Home
- Collections
- About Us
- Account (if logged in)
- Login/Register (if not logged in)

The drawer should close automatically after navigation and work across all screens.
```

**Outcome:**
- Created reusable drawer widget
- Implemented conditional menu items based on auth state
- Added automatic drawer close on navigation
- Files: `lib/widgets/mobile_drawer.dart`

---

### Product Page Navigation
**Prompt:**
```
When user taps a product card, navigate to a product detail page showing:
- Product images (gallery if multiple)
- Full description
- Size/color dropdowns
- Quantity selector
- Add to cart button
- Related products section

Pass product ID via route and fetch product details.
```

**Outcome:**
- Implemented named route navigation
- Created product detail page
- Added route parameter passing
- Files: `lib/pages/product_page.dart`, updated `lib/main.dart` routes

---

## 3. Firebase Integration

### Deployment Configuration
**Prompt:**
```
I am deploying my Flutter website to Firebase Hosting. Guide me through:
1. Required configuration files (.firebaserc, firebase.json, firestore.rules)
2. Exact content for each file
3. Firestore security rules for e-commerce (users, cart, orders, products)
4. Deployment commands

My project is called union_shop and uses Firestore for database.
```

**Outcome:**
- Created all Firebase config files
- Set up proper security rules
- Configured hosting with caching
- Successfully deployed to Firebase
- Files: `.firebaserc`, `firebase.json`, `firestore.rules`, `firestore.indexes.json`

---

### Firestore Security Rules
**Problem:** Permission denied errors

** Prompt:**
```
Firebase permission fixes - users getting permission denied when:
1. Adding items to cart
2. Creating orders
3. Updating profile

Current rules are too restrictive. Need rules that:
- Allow users to manage only their own cart
- Let authenticated users create orders
- Prevent order modification after creation
- Allow profile updates by owner only
- Keep products read-only for all users
```

**Solution:**
- Rewrote Firestore rules with proper auth checks
- Added `isOwner()` helper function
- Implemented timestamp validation
- Files: `firestore.rules`

---

## 4. Shopping Cart System

### Cart State Management
**Initial Prompt:**
```
Cart system implementation - need to build a shopping cart that persists 
in Firestore and updates in real-time.
```

**Comprehensive Prompt:**
```
Implement a shopping cart system for Flutter e-commerce with:

Features:
1. Add products with quantity
2. Update quantity
3. Remove items
4. Real-time total calculation
5. Persist cart in Firestore (not local storage)
6. Show cart count badge on app bar

Use Provider for state management. Cart should sync with Firestore for 
authenticated users and store locally for guests.
```

**Outcome:**
- Created Cart model and CartProvider
- Implemented Firestore sync
- Added cart badge with real-time count
- Built cart screen with CRUD operations
- Files: `lib/models/cart_item.dart`, `lib/pages/cart_page.dart`
---

### Cart Badge Not Displaying
**Problem:** Cart count not updating

**Initial Prompt:**
```
Cart not displaying the count - the badge on the cart icon should show 
the number of items but it's not appearing.
```

**Debugging Prompt:**
```

The cart badge is not showing the item count. Here's what I've checked:
1. Cart provider is initialized correctly
2. Items are being added to cart successfully
3. Firestore shows correct data
4. But the badge shows 0 or nothing

Current implementation:
[Provided cart badge widget code]
[Provided cart provider code]

What could be causing this? Is it a state management issue, a widget 
rebuild issue, or something else?
```

**Solution:**
- Fixed `Consumer` widget placement
- Ensured `notifyListeners()` called after cart operations
- Moved CartProvider higher in widget tree
- Files: `lib/widgets/cart_service.dart`, `lib/main.dart`

---

## 5. Authentication

### Firebase Auth Setup
**Prompt:**
```
Set up Firebase Authentication for my e-commerce app:
1. Email/password authentication
2. Login page with form validation
3. Registration page
4. Password reset functionality
5. Auth state persistence
6. Redirect to home after login

Show proper error messages for: invalid email, weak password, user not found.
```

**Outcome:**
- Integrated Firebase Authentication
- Created login/register pages
- Implemented form validation
- Added auth state management
- Files: `lib/pages/auth_page.dart`, `lib/services/auth_service.dart`

---

## 6.  Product Images Replacement

**Initial Prompt:**
```
Products images replacement - need to update placeholder images with 
actual product photos.
```

**Initial Prompt:**
```
Create a Product model for e-commerce with fields:
- id, name, description, price, originalPrice
- images (list), category, sizes (list)
- stock, rating, reviewCount
- isOnSale (computed), discountPercentage (computed)

Also create a ProductService that fetches products from Firestore 'products' 
collection with:
- Get all products
- Get products by category
- Get single product by ID
- Search products by name
```

**Outcome:**
- Sourced high-quality product images from Unsplash
- Optimized images using online compression tools
- Use AI for images 
---

## 7. Collections & Categories

### Collections Page
**Prompt:**
```
Create a collections page showing product categories as cards:
- Each collection card shows category image and name
- Grid layout (2 columns mobile, 3+ desktop)
- Tapping navigates to collection detail page
- Categories: Hoodies, T-Shirts, Jackets, Accessories

Make cards visually appealing with hover effects.
```

**Outcome:**
- Created collections grid page
- Implemented category navigation
- Added responsive grid layout
- Files: `lib/pages/collections_page.dart`

---

## 8. Checkout Process

### Order Placement (Mock Payment)
**Prompt:**
```
Implement checkout flow for university project (NO real payment processing):

Flow:
1. Review cart items and total
2. Select/enter shipping address
3. Mock payment form (validation only, no real processing)
4. Order confirmation screen

After "payment":
- Create order document in Firestore
- Clear cart
- Show order confirmation with order ID
- Store order in user's order history
```

**Outcome:**
- Created multi-step checkout
- Implemented mock payment form
- Added order creation logic
- Built confirmation screen
- Files: `lib/pages/cart_page.dart`, `lib/pages/order_page.dart`

---

**Outcome:**
- Formatted entire codebase
- Fixed all lint warnings
- Configured `analysis_options.yaml`

---

## 9. Documentation

### README Creation
**Prompt:**
```
Create a professional README.md for my Union Shop Flutter coursework including:
1. Project title and description
2. Features list
3. Screenshots (placeholders)
4. Tech stack
5. Installation instructions
6. Firebase setup steps
7. Running the app
8. Project structure
9. External services used (list Firebase services)
```

**Outcome:**
- Created comprehensive README
- Documented all features
- Included setup instructions
- Added Firebase configuration guide
- Files: `README.md`

---

## 10. Deployment

### Firebase Hosting Deployment
**Prompt:**
```
1. How do I handle environment-specific configurations (dev vs production)?
2. What's the best practice for managing API keys in Flutter web?
3. How do I set up custom domain with Firebase Hosting?
4. What caching strategy should I use for optimal performance?
5. How do I set up automatic deployments with GitHub Actions?
```

**Outcome:**
- Created complete deployment guide (DEPLOYMENT.md)
- Successfully deployed to Firebase Hosting
- Built production Flutter web app
- Deployed Firestore rules and indexes
- Verified deployment at production URL

---

## AI Tools Used

1. **Claude (Anthropic)** - Primary assistant for architecture and implementation
2. **GitHub Copilot** - Code completion and boilerplate generation
3. **ChatGPT** - Alternative perspective for debugging

---

## Prompt Engineering Techniques

### Effective Patterns Used:
1. **Context Building** - Providing code snippets, error messages, screenshots
2. **Iterative Refinement** - Starting broad, then adding specific requirements
3. **Error-Driven Prompts** - Sharing actual error messages for debugging
4. **Specification First** - Defining requirements before requesting code

### Example of Good vs Poor Prompting:

**Poor:** "make a cart"

**Good:** 
```
Implement a shopping cart system with:
- Add/remove items
- Quantity management
- Firestore persistence
- Real-time total calculation
- Cart badge showing count
Use Provider for state management.
```

---

## Lessons Learned

### What Worked:
- Being specific about requirements and constraints
- Providing code context and error messages
- Asking AI to explain solutions before implementing
- Testing AI-generated code thoroughly

### Challenges:
- AI sometimes suggested outdated Flutter patterns
- Needed to adapt Firebase solutions for web platform
- Had to refine responsive design multiple times
- Required manual testing despite AI-generated tests

### Best Practices Developed:
1. Always review and understand AI code before using
2. Test functionality immediately after implementation
3. Commit small changes frequently
4. Use AI for learning, not just copy-paste

---

## Development Workflow

**Typical iteration:**
1. Define feature requirements clearly
2. Ask AI for implementation approach
3. Review and understand suggested code
4. Implement in small chunks
5. Test functionality
6. Refactor if needed
7. Commit with meaningful message
8. Move to next feature

This structured approach ensured code quality and understanding rather than blind AI reliance.

---

**Total Features Implemented:** 15+    
**Commits:** 20+ (regular small commits as required)

---

*This document demonstrates structured AI usage following PDD principles from Worksheet 6, showing understanding and thoughtful application of AI assistance in software development.*