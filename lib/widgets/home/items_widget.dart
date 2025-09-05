import 'package:flutter/material.dart';

// Widget utama untuk menampilkan daftar item produk dalam bentuk grid
class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar nama produk yang akan ditampilkan. Anda bisa mengganti ini dengan data dari database.
    final List<String> myProductName = [
      'Outfit',
      'Makanan',
      'Skincare',
      'Electronik',
    ];

    // Menampilkan produk dalam tata letak grid
    return GridView.count(
      // Mencegah grid dari menggulir secara independen. Ini akan mengikuti guliran widget induk.
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2, // Menentukan jumlah kolom di grid (2 kolom)
      shrinkWrap: true, // Membuat grid hanya mengambil ruang yang dibutuhkan
      childAspectRatio: 0.68, // Menentukan rasio aspek (lebar/tinggi) dari setiap item grid
      children: [
        // Melakukan perulangan untuk membuat setiap item produk
        for (int i = 0; i < myProductName.length; i++)
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                // 🔥 Changed: Tambahkan shadow halus agar lebih hidup
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian atas item produk: Diskon dan ikon favorit
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Kotak diskon
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4C53A5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '-58%',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Ikon hati untuk menandai favorit
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ],
                ),

                // 🖼️ Gambar produk - diperbesar dengan Expanded
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "ItemsPage");
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'images/items/${i + 1}.jpg',
                          width: double.infinity,
                          fit: BoxFit.cover, // cover biar penuh
                        ),
                      ),
                    ),
                  ),
                ),

                // Nama produk
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    myProductName[i],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4C53A5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Deskripsi singkat produk
                const Text(
                  'Tulis deskripsi produk',
                  style: TextStyle(
                    // 🔥 Changed: Ubah jadi italic + warna abu agar lebih menarik
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),

                // Bagian bawah item produk: Harga dan ikon keranjang
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Harga produk
                      const Text(
                        '\$65',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                      // Ikon keranjang belanja
                      const Icon(
                        Icons.shopping_cart,
                        size: 20,
                        color: Color(0xFF4C53A5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
