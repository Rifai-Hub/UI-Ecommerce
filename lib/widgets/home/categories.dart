import 'package:flutter/material.dart';
import 'package:ui_ecommerce/theme/app_theme.dart';

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
      height: 120,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            for (int i = 0; i < categories.length; i++)
              _HoverCategoryCard(
                title: categories[i],
                imagePath: 'images/categories/${i + 1}.jpg',
                isFirst: i == 0,
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
  final bool isFirst;

  const _HoverCategoryCard({
    required this.title,
    required this.imagePath,
    this.isFirst = false,
  });

  @override
  State<_HoverCategoryCard> createState() => _HoverCategoryCardState();
}

class _HoverCategoryCardState extends State<_HoverCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      child: Container(
        width: 100,
        margin: EdgeInsets.only(
          left: widget.isFirst ? 0 : 12,
          right: 12,
        ),
        decoration: BoxDecoration(
          gradient: _isHovered ? AppTheme.primaryGradient : null,
          color: _isHovered ? null : Colors.white,
          borderRadius: AppTheme.cardRadius,
          boxShadow: _isHovered ? AppTheme.elevatedShadow : AppTheme.cardShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 48,
              width: 48,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isHovered ? Colors.white.withOpacity(0.2) : AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                  colorFilter: _isHovered 
                      ? const ColorFilter.mode(Colors.white, BlendMode.modulate)
                      : ColorFilter.mode(AppTheme.primaryColor, BlendMode.modulate),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: _isHovered ? Colors.white : AppTheme.textPrimary,
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
