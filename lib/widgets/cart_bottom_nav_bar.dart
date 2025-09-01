import 'package:flutter/material.dart';

class CartBottomNavBar extends StatefulWidget {
  final ValueNotifier<double> totalPrice;

  const CartBottomNavBar({super.key, required this.totalPrice});

  @override
  State<CartBottomNavBar> createState() => _CartBottomNavBarState();
}

class _CartBottomNavBarState extends State<CartBottomNavBar> {
  final TextEditingController _couponController = TextEditingController();

  // daftar kupon + diskon %
  final Map<String, double> coupons = {
    "RIFAIGANTENG": 100, // diskon 100%
    "RIFAI": 50,        // diskon 50%
    "IDN": 25,          // diskon 25%
    "RIFAIIDN": 10,     // diskon 10%
  };

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  // Fungsi cek & terapkan kupon
  void _applyCoupon() {
    final code = _couponController.text.trim().toUpperCase();

    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kode voucher kosong, tidak valid")),
      );
      return;
    }

    if (coupons.containsKey(code)) {
      final discountPercent = coupons[code]!;
      final originalPrice = widget.totalPrice.value;

      // Hitung harga setelah diskon
      final discountedPrice =
          originalPrice - (originalPrice * discountPercent / 100);

      widget.totalPrice.value = discountedPrice;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Diskon $discountPercent% berhasil diterapkan 🎉")),
      );
      _couponController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kupon '$code' tidak valid ❌")),
      );
      _couponController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 200,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Input kupon + tombol apply
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _couponController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Kode Kupon',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF4C53A5)),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _applyCoupon,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C53A5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Total harga
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
                ValueListenableBuilder<double>(
                  valueListenable: widget.totalPrice,
                  builder: (context, value, child) {
                    return Text(
                      '\$${value.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xFF4C53A5),
                      ),
                    );
                  },
                ),
              ],
            ),

            // Tombol checkout
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Menuju Checkout...")),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF4C53A5),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  'Check Out',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
