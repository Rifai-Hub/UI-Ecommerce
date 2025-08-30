import 'package:flutter/material.dart';

class CartItemSamples extends StatelessWidget {
  const CartItemSamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // Menampilkan 4 Item dengan Perulangan
        for (int i = 1; i <= 4; i++)
        Container(
          height: 110,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [

              // Radio Button (belum Berfungsi)
              Radio(value: '', groupValue: '', activeColor: const Color(0xFF4C53A5),
              onChanged: (index) {},
              ),

              // Gambar Produk dari Asset Lokal
              Container(
                height: 70,
                width: 70,
                margin: const EdgeInsets.only(right: 15),
                child: Image.asset('images/carts/$i.jpg'),
              ),

              // Informasi Produk (Nama & Harga)
              const Padding(padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Title',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                  Text(
                    '\$55',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  )
                ],
              ),
              ),

              // Spacer dan Tombol Aksi (Hapus & Jumlah)
              const Spacer(),
              Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.delete, color: Colors.red,),
                  Row(
                    children: [
                      // Tombol Tambah Item
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                            color: Colors.grey.withAlpha((255 * 0.5).round()),
                            spreadRadius: 1,
                            blurRadius: 10,
                            ),
                          ],               
                        ),
                        child: const Icon(Icons.add, size: 18,),
                      ),

                      // Jumlah item
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          '01',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4C53A5),
                          ),
                        ),
                      ),

                      // Tombol kurang item
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha((255 * 0.5).round()),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.remove, size: 18,),
                      ),
                    ],
                  ),
                ],
              ),)
            ],
          ),
        ),
      ],
    );
  }
}