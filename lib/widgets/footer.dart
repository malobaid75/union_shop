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
            // Mobile layout
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFooterSection('SHOP', [
                  'All Products',
                  'Collections',
                  'Sale Items',
                  'New Arrivals',
                ]),
                const SizedBox(height: 30),
                _buildFooterSection('INFORMATION', [
                  'About Us',
                  'Contact Us',
                  'Privacy Policy',
                  'Terms & Conditions',
                ]),
                const SizedBox(height: 30),
                _buildFooterSection('CUSTOMER SERVICE', [
                  'Help Center',
                  'Track Order',
                  'Returns',
                  'Shipping Info',
                ]),
                const SizedBox(height: 30),
                _buildContactSection(),
                const SizedBox(height: 30),
                _buildSocialMedia(),
                const SizedBox(height: 20),
                const Divider(color: Colors.grey),
                const SizedBox(height: 20),
                _buildCopyright(),
              ],
            );
          } else {
            // Desktop layout
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildFooterSection('SHOP', [
                        'All Products',
                        'Collections',
                        'Sale Items',
                        'New Arrivals',
                      ]),
                    ),
                    Expanded(
                      child: _buildFooterSection('INFORMATION', [
                        'About Us',
                        'Contact Us',
                        'Privacy Policy',
                        'Terms & Conditions',
                      ]),
                    ),
                    Expanded(
                      child: _buildFooterSection('CUSTOMER SERVICE', [
                        'Help Center',
                        'Track Order',
                        'Returns',
                        'Shipping Info',
                      ]),
                    ),
                    Expanded(
                      child: _buildContactSection(),
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
        },
      ),
    );
  }

  Widget _buildFooterSection(String title, List<String> links) {
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
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () {},
                child: Text(
                  link,
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
        Text(
          'Email: shop@upsu.net',
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Phone: +44 23 9284 3000',
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'University of Portsmouth\nStudent Union',
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMedia() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(Icons.facebook),
        const SizedBox(width: 15),
        _buildSocialIcon(Icons.camera_alt), // Instagram
        const SizedBox(width: 15),
        _buildSocialIcon(Icons.chat), // Twitter/X
        const SizedBox(width: 15),
        _buildSocialIcon(Icons.video_library), // YouTube
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return InkWell(
      onTap: () {},
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
    );
  }

  Widget _buildCopyright() {
    return Center(
      child: Text(
        '© 2025 University of Portsmouth Students\' Union. All rights reserved.',
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}