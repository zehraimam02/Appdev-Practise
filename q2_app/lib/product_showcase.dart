import 'package:flutter/material.dart';

class ProductShowcase extends StatelessWidget {
  const ProductShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with See All
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recommended for\nyour devices',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Product Card - Extended to edges
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1C1C1E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  // Bookmark icon
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Icon(
                      Icons.bookmark_border,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                  // Main content
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Product Images Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/headphones.png',
                              height: 180,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        // Product Info
                        const Text(
                          'Free Engraving',
                          style: TextStyle(
                            color: Color(0xFFFFB74D),
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'AirPods Max - Silver',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'A\$899.00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        
                        // Color Options
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildColorOption(const Color(0xFF8D6E63)), // Space Gray
                            const SizedBox(width: 8),
                            _buildColorOption(const Color(0xFFFFB74D)), // Gold
                            const SizedBox(width: 8),
                            _buildColorOption(const Color(0xFFE0E0E0)), // Silver
                            const SizedBox(width: 8),
                            _buildColorOption(const Color(0xFF90A4AE)), // Blue
                            const SizedBox(width: 4),
                            const Text(
                              '+1 more',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
    );
  }
}