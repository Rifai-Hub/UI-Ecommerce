import 'package:ui_ecommerce/widgets/cart/cart_app_bar.dart';
import 'package:ui_ecommerce/widgets/cart/cart_bottom_nav_bar.dart';
import 'package:ui_ecommerce/widgets/cart/cart_item_samples.dart';
import 'package:flutter/material.dart';
import 'package:ui_ecommerce/theme/app_theme.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  final ValueNotifier<List<int>> _quantities = ValueNotifier<List<int>>(List.filled(4, 1));
  final ValueNotifier<double> _totalPrice = ValueNotifier<double>(0.0);

  void _updateTotal() {
    double total = 0.0;
    for (int i = 0; i < 4; i++) {
      total += 55.0 * _quantities.value[i]; // Harga $55 per item
    }
    _totalPrice.value = total;
  }

  @override
  void initState() {
    super.initState();
    _updateTotal(); // Hitung total awal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: ListView(
        children: [
          const CartAppBar(),

          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 200,
            ),
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                CartItemSamples(
                  quantities: _quantities,
                  onQuantityChanged: _updateTotal,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          CartBottomNavBar(totalPrice: _totalPrice),
    );
  }
}