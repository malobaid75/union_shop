import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/footer.dart';
import '../services/auth_service.dart';

class AccountDashboardPage extends StatefulWidget {
  const AccountDashboardPage({super.key});

  @override
  State<AccountDashboardPage> createState() => _AccountDashboardPageState();
}

class _AccountDashboardPageState extends State<AccountDashboardPage> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// Load user data from Firestore
  Future<void> _loadUserData() async {
    final data = await _authService.getUserData();
    setState(() {
      _userData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Redirect if not logged in
    if (!_authService.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/auth');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
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
            _isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(60),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _buildDashboardContent(),
            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
      ),
    );
  }

  /// Build page header
  Widget _buildPageHeader() {
    final user = _authService.currentUser;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade700, Colors.indigo.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Text(
              user?.displayName?[0].toUpperCase() ?? 'U',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            user?.displayName ?? 'User',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            user?.email ?? '',
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
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      color: Colors.grey.shade100,
      child: Row(
        children:[
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
            child: Text(
              'Home',
              style: TextStyle(
                color: Colors.indigo.shade700,
                fontSize:14,              ),
            ),
          ),
          const Text(
            '/',
            style: TextStyle(
              color: Colors.grey)),
          const Text(
            'My Account',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14),
          ),
        ],
      ),
    );
  }

  /// Build dashboard content
Widget _buildDashboardContent() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        // Quick stats
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 768) {
              return Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Orders', '0', Icons.shopping_bag),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildStatCard('Wishlist', '0', Icons.favorite),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildStatCard('Points', '0', Icons.star),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildStatCard('Orders', '0', Icons.shopping_bag),
                  const SizedBox(height: 15),
                  _buildStatCard('Wishlist', '0', Icons.favorite),
                  const SizedBox(height: 15),
                  _buildStatCard('Points', '0', Icons.star),
                ],
              );
            }
          },
        ),

        const SizedBox(height: 30),

        // Quick actions
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),

        _buildActionButton(
          'View Orders',
          Icons.receipt_long,
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Orders page coming soon!'),
              ),
            );
          },
        ),
        const SizedBox(height: 10),

        _buildActionButton(
          'Edit Profile',
          Icons.edit,
          () => _showEditProfileDialog(),
        ),
        const SizedBox(height: 10),

        _buildActionButton(
          'Change Password',
          Icons.lock,
          () => _showChangePasswordDialog(),
        ),
        const SizedBox(height: 10),

        _buildActionButton(
          'Sign Out',
          Icons.logout,
          () => _handleSignOut(),
          color: Colors.red,
        ),
      ],
    ),
  );
}

/// Build stat card
Widget _buildStatCard(String title, String value, IconData icon) {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.indigo.shade700),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Build action button
Widget _buildActionButton(
  String title,
  IconData icon,
  VoidCallback onPressed, {
  Color? color,
}) {
  return Card(
    child: ListTile(
      leading: Icon(
        icon,
        color: color ?? Colors.indigo.shade700,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onPressed,
    ),
  );
}

/// Show edit profile dialog
void _showEditProfileDialog() {
  final nameController = TextEditingController(
    text: _authService.currentUser?.displayName,
  );

  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Edit Profile'),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context);

              final success = await _authService.updateUserProfile(
                displayName: nameController.text.trim(),
              );

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    success
                        ? 'Profile updated successfully!'
                        : 'Failed to update profile',
                  ),
                  backgroundColor: success ? Colors.green : Colors.red,
                ),
              );

              if (success) {
                _loadUserData();
              }
            }
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

/// Show change password dialog
void _showChangePasswordDialog() {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'Password reset email will be sent to your email',
      ),
      duration: Duration(seconds: 2),
    ),
  );

  // Send reset email
  _authService.sendPasswordResetEmail(
    _authService.currentUser!.email!,
  );
}

/// Handle sign out
Future _handleSignOut() async {
  final confirm = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Sign Out'),
      content: const Text(
        'Are you sure you want to sign out?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Sign Out'),
        ),
      ],
    ),
  );

  if (confirm == true) {
    await _authService.signOut();
    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/');
  }
  }
}


