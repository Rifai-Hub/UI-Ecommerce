import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Outfit',
      'Makanan',
      'Skincare',
      'Elektronik',
    ];

    return SizedBox(
      height: 200, // area kategori lebih tinggi
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < categories.length; i++)
              _HoverCategoryCard(
                title: categories[i],
                imagePath: 'images/categories/${i + 1}.jpg',
              ),
          ],
        ),
      ),
    );
  }
}

class _HoverCategoryCard extends StatefulWidget {
  final String title;
  final String imagePath;

  const _HoverCategoryCard({
    required this.title,
    required this.imagePath,
  });

  @override
  State<_HoverCategoryCard> createState() => _HoverCategoryCardState();
}

class _HoverCategoryCardState extends State<_HoverCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: _isHovered ? 160 : 150, // membesar saat hover
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(_isHovered ? 0.3 : 0.15),
              blurRadius: _isHovered ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: _isHovered ? 100 : 90, // gambar ikut membesar
              width: _isHovered ? 100 : 90,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF4C53A5),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
