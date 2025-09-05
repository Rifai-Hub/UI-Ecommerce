import 'package:ui_ecommerce/widgets/cart/cart_app_bar.dart';
import 'package:ui_ecommerce/widgets/cart/cart_bottom_nav_bar.dart';
import 'package:ui_ecommerce/widgets/cart/cart_item_samples.dart';
import 'package:flutter/material.dart';

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
      body: ListView(
        children: [
          const CartAppBar(),

          // Membuat Kontent Keranjang
          Container(
            height: 700,
            padding: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                CartItemSamples(
                  quantities: _quantities, // Kirim data kuantitas
                  onQuantityChanged: _updateTotal, // Callback untuk memperbarui total
                ),
                // CartBottomNavBar(), // Dihapus karena sudah ada di bottomNavigationBar

                // Soal 3.3.8: Menghapus placeholder Add Coupon Code karena sudah dipindahkan ke CartBottomNavBar

                // Membuat Tombol "Add Coupon Code"
                // Container(
                //   margin: const EdgeInsets.symmetric(
                //     vertical: 20,
                //     horizontal: 15,
                //   ),
                //   padding: const EdgeInsets.all(10),
                //   child: Text(
                //     'Add Coupon Code',
                //     style: TextStyle(
                //       color: Color(0xFF4C53A5),
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          CartBottomNavBar(totalPrice: _totalPrice), // Bottom NavBar Khusus Cart
    );
  }
}