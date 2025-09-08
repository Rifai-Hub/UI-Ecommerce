import 'package:flutter/material.dart';
import 'package:ui_ecommerce/theme/app_theme.dart';

class CartItemSamples extends StatefulWidget {
  final ValueNotifier<List<int>> quantities;
  final VoidCallback onQuantityChanged;

  const CartItemSamples({
    super.key,
    required this.quantities,
    required this.onQuantityChanged,
  });

  @override
  CartItemSamplesState createState() => CartItemSamplesState();
}

class CartItemSamplesState extends State<CartItemSamples> {
  List<bool> _isVisible = List.generate(4, (_) => true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 4; i++)
          if (_isVisible[i])
            _CartItemCard(
              index: i,
              quantities: widget.quantities,
              onQuantityChanged: widget.onQuantityChanged,
              onRemove: () {
                setState(() {
                  _isVisible[i] = false;
                });
                widget.onQuantityChanged();
              },
            ),
      ],
    );
  }
}

class _CartItemCard extends StatefulWidget {
  final int index;
  final ValueNotifier<List<int>> quantities;
  final VoidCallback onQuantityChanged;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.index,
    required this.quantities,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  State<_CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<_CartItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(_slideAnimation),
      child: FadeTransition(
        opacity: _slideAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppTheme.cardRadius,
            boxShadow: AppTheme.cardShadow,
          ),
          child: Row(
            children: [
              // Product image
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage('images/carts/${widget.index + 1}.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Premium Product ${widget.index + 1}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'High quality item',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$55.00',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Quantity controls and delete button
              Column(
                children: [
                  // Delete button
                  GestureDetector(
                    onTap: widget.onRemove,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppTheme.errorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: AppTheme.errorColor,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Quantity controls
                  Row(
                    children: [
                      _QuantityButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (widget.quantities.value[widget.index] > 1) {
                            final newList = List<int>.from(widget.quantities.value);
                            newList[widget.index]--;
                            widget.quantities.value = newList;
                            widget.onQuantityChanged();
                          }
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          widget.quantities.value[widget.index].toString().padLeft(2, '0'),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      _QuantityButton(
                        icon: Icons.add,
                        onTap: () {
                          final newList = List<int>.from(widget.quantities.value);
                          newList[widget.index]++;
                          widget.quantities.value = newList;
                          widget.onQuantityChanged();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}
