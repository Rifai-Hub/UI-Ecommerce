import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Soal 3.3.4: Efek shadow sudah ditambahkan pada AppBar
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            // Soal 3.3.2: Fungsi tombol kembali menggunakan Navigator.pop(context)
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Color(0xFF4C53A5),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              // Soal 3.3.1: Ikon shopping cart
              children: [
                Icon(Icons.shopping_cart, color: Color(0xFF4C53A5)),
                SizedBox(width: 5),
                Text(
                  'My Cart',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Soal 3.3.3: Popup menu pada ikon titik tiga
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 30, color: Color(0xFF4C53A5)),
            onSelected: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Menu selected: $value")),
              );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "Profile", child: Text("Profile")),
              const PopupMenuItem(value: "Settings", child: Text("Settings")),
            ],
          ),
        ],
      ),
    );
  }
}
