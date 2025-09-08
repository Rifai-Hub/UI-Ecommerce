import 'package:flutter/material.dart';
import 'package:ui_ecommerce/theme/app_theme.dart';
import 'package:ui_ecommerce/widgets/common/custom_button.dart';
import 'package:ui_ecommerce/widgets/common/custom_text_field.dart';

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
      color: Colors.white,
      elevation: 0,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Coupon section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: AppTheme.cardRadius,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _couponController,
                        hintText: 'Enter coupon code',
                        prefixIcon: Icons.local_offer_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    CustomButton(
                      text: 'Apply',
                      onPressed: _applyCoupon,
                      width: 80,
                      height: 48,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Price summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      ValueListenableBuilder<double>(
                        valueListenable: widget.totalPrice,
                        builder: (context, value, child) {
                          return Text(
                            '\$${value.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  CustomButton(
                    text: 'Checkout',
                    icon: Icons.shopping_bag_outlined,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Proceeding to checkout..."),
                          backgroundColor: AppTheme.successColor,
                        ),
                      );
                    },
                    width: 140,
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
