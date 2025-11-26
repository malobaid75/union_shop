import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 768) {
            return _buildMobileFooter(context);
          } else {
            return _buildDesktopFooter(context);
          }
        },
      ),
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFooterSection(context, 'SHOP', [
          {'title': 'All Collections', 'route': '/collections'},
          {'title': 'Clothing', 'route': '/collection', 'args': 'Clothing'},
          {'title': 'Accessories', 'route': '/collection', 'args': 'Accessories'},
          {'title': 'Sale Items', 'route': '/sale'},
        ]),
        const SizedBox(height: 30),
        _buildFooterSection(context, 'INFORMATION', [
          {'title': 'About Us', 'route': '/about'},
          {'title': 'Contact Us', 'route': '/contact'},
          {'title': 'Privacy Policy', 'route': '/privacy'},
          {'title': 'Terms & Conditions', 'route': '/terms'},
        ]),
        const SizedBox(height: 30),
        _buildFooterSection(context, 'CUSTOMER SERVICE', [
          {'title': 'Help Center', 'route': '/help'},
          {'title': 'Track Order', 'route': '/track-order'},
          {'title': 'Returns', 'route': '/returns'},
          {'title': 'Shipping Info', 'route': '/shipping'},
        ]),
        const SizedBox(height: 30),
        _buildContactSection(),
        const SizedBox(height: 30),
        _buildSearchBar(context),
        const SizedBox(height: 30),
        _buildSocialMedia(),
        const SizedBox(height: 20),
        const Divider(color: Colors.grey),
        const SizedBox(height: 20),
        _buildCopyright(),
      ],
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildFooterSection(context, 'SHOP', [
                {'title': 'All Collections', 'route': '/collections'},
                {'title': 'Clothing', 'route': '/collection', 'args': 'Clothing'},
                {'title': 'Accessories', 'route': '/collection', 'args': 'Accessories'},
                {'title': 'Sale Items', 'route': '/sale'},
              ]),
            ),
            Expanded(
              child: _buildFooterSection(context, 'INFORMATION', [
                {'title': 'About Us', 'route': '/about'},
                {'title': 'Contact Us', 'route': '/contact'},
                {'title': 'Privacy Policy', 'route': '/privacy'},
                {'title': 'Terms & Conditions', 'route': '/terms'},
              ]),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactSection(),
                  const SizedBox(height: 20),
                  _buildSearchBar(context),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        _buildSocialMedia(),
        const SizedBox(height: 20),
        const Divider(color: Colors.grey),
        const SizedBox(height: 20),
        _buildCopyright(),
      ],
    );
  }

  Widget _buildFooterSection(BuildContext context, String title, List<Map<String, dynamic>> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  if (link['args'] != null) {
                    Navigator.pushNamed(
                      context,
                      link['route'],
                      arguments: link['args'],
                    );
                  } else {
                    Navigator.pushNamed(context, link['route']);
                  }
                },
                child: Text(
                  link['title'],
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CONTACT US',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        _buildContactItem(Icons.email, 'shop@upsu.net'),
        const SizedBox(height: 8),
        _buildContactItem(Icons.phone, '+44 23 9284 3000'),
        const SizedBox(height: 8),
        _buildContactItem(Icons.location_on, 'University of Portsmouth\nStudents\' Union'),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.grey.shade400,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
  final searchController = TextEditingController();
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'SEARCH',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 15),
      Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    Navigator.pushNamed(
                      context,
                      '/search',
                      arguments: value,
                    );
                  }
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                if (searchController.text.isNotEmpty) {
                  Navigator.pushNamed(
                    context,
                    '/search',
                    arguments: searchController.text,
                  );
                } else {
                  Navigator.pushNamed(context, '/search');
                }
              },
            ),
          ],
        ),
      ),
    ],
  );
}

  Widget _buildSocialMedia() {
    return Column(
      children: [
        const Text(
          'FOLLOW US',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(Icons.facebook, 'Facebook'),
            const SizedBox(width: 15),
            _buildSocialIcon(Icons.camera_alt, 'Instagram'),
            const SizedBox(width: 15),
            _buildSocialIcon(Icons.close, 'X (Twitter)'),
            const SizedBox(width: 15),
            _buildSocialIcon(Icons.video_library, 'YouTube'),
            const SizedBox(width: 15),
            _buildSocialIcon(Icons.link, 'LinkedIn'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildCopyright() {
    return Column(
      children: [
        Text(
          '© 2025 University of Portsmouth Students\' Union. All rights reserved.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFooterLink('Privacy Policy'),
            const Text(' | ', style: TextStyle(color: Colors.grey)),
            _buildFooterLink('Terms of Service'),
            const Text(' | ', style: TextStyle(color: Colors.grey)),
            _buildFooterLink('Cookie Policy'),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 12,
        ),
      ),
    );
  }
}
