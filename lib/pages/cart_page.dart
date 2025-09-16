import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  // Data dummy untuk item keranjang
  final List<Map<String, String>> _cartItems = [
    {
      'imageUrl': 'assets/images/items/Skintific.png',
      'title': 'Skintific 5x Ceramide Moisturizer',
      'price': '140.000',
    },
    {
      'imageUrl': 'assets/images/items/16.jpg',
      'title': 'iPhone 16 Pro',
      'price': '20.000.000',
    },
    {
      'imageUrl': 'assets/images/items/huawei.png',
      'title': 'Huawei Watch GT 5',
      'price': '3.700.000',
    },
  ];

  final ValueNotifier<List<int>> _quantities = ValueNotifier<List<int>>(List.filled(4, 1));
  final ValueNotifier<double> _totalPrice = ValueNotifier<double>(0.0);

  void _updateTotal() {
    double total = 0.0;
    for (int i = 0; i < _cartItems.length; i++) {
      double price = double.parse(_cartItems[i]['price']!.replaceAll('.', ''));
      total += price * _quantities.value[i];
    }
    _totalPrice.value = total;
  }

  @override
  void initState() {
    super.initState();
    _updateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildCartAppBar(),
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
            child: CartItemSamples(
              cartItems: _cartItems,
              quantities: _quantities,
              onQuantityChanged: _updateTotal,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CartBottomNavBar(totalPrice: _totalPrice),
    );
  }

  Widget _buildCartAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0095DA), Color(0xFF5EBEF3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Keranjang Belanja',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 50),
        ],
      ),
    );
  }
}

class CartItemSamples extends StatelessWidget {
  final List<Map<String, String>> cartItems;
  final ValueNotifier<List<int>> quantities;
  final VoidCallback onQuantityChanged;

  const CartItemSamples({
    super.key,
    required this.cartItems,
    required this.quantities,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<int>>(
      valueListenable: quantities,
      builder: (context, currentQuantities, child) {
        return Column(
          children: cartItems.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, String> item = entry.value;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      item['imageUrl']!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Rp ${item['price']!}',
                          style: GoogleFonts.poppins(
                            color: const Color(0XFF0095DA),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          // Logika hapus item
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0XFF0095DA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (currentQuantities[index] > 1) {
                                  List<int> newQuantities = List.from(currentQuantities);
                                  newQuantities[index]--;
                                  quantities.value = newQuantities;
                                  onQuantityChanged();
                                }
                              },
                              child: const Icon(Icons.remove, color: Colors.white, size: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                currentQuantities[index].toString(),
                                style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                List<int> newQuantities = List.from(currentQuantities);
                                newQuantities[index]++;
                                quantities.value = newQuantities;
                                onQuantityChanged();
                              },
                              child: const Icon(Icons.add, color: Colors.white, size: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class CartBottomNavBar extends StatelessWidget {
  final ValueNotifier<double> totalPrice;

  const CartBottomNavBar({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: totalPrice,
      builder: (context, total, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_offer, color: Color(0XFF0095DA)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tambah Kupon',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    'Rp ${total.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0XFF0095DA),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Logika checkout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0095DA),
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 5,
                  shadowColor: const Color(0xFF0095DA).withAlpha((255 * 0.4).round()),
                ),
                child: Text(
                  'Checkout',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}