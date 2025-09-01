import 'package:flutter/material.dart';

// Mengubah nama file menjadi cart_item_samples.dart sesuai konvensi Dart
class CartItemSamples extends StatefulWidget {
  final ValueNotifier<List<int>> quantities; // Data kuantitas dari CartPage
  final VoidCallback onQuantityChanged; // Callback untuk memberi tahu perubahan

  const CartItemSamples({
    super.key,
    required this.quantities,
    required this.onQuantityChanged,
  });

  @override
  // Mengubah ke CartItemSamplesState agar tidak privat, sesuai saran analyzer
  CartItemSamplesState createState() => CartItemSamplesState();
}

class CartItemSamplesState extends State<CartItemSamples> {
  // Soal 3.3.6: List untuk mengatur visibilitas item
  List<bool> _isVisible = List.generate(4, (_) => true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 4; i++)
          if (_isVisible[i])
            Container(
              height: 110,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              // Soal 3.3.4: Efek shadow pada box item cart
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Menghapus Radio karena tidak diperlukan fungsinya dan menimbulkan warning deprecated
                  SizedBox(
                    width: 48,
                  ), // Placeholder untuk ruang yang ditempati Radio sebelumnya
                  Container(
                    height: 70,
                    width: 70,
                    margin: const EdgeInsets.only(right: 15),
                    child: Image.asset('images/carts/${i + 1}.jpg'),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
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
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Soal 3.3.6: Tombol Delete untuk menyembunyikan item
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isVisible[i] = false;
                            });
                            widget
                                .onQuantityChanged(); // Panggil callback saat item disembunyikan
                          },
                          child: Icon(Icons.delete, color: Colors.red),
                        ),
                        Row(
                          children: [
                            // Soal 3.3.5: Tombol kurang untuk mengurangi kuantitas
                            InkWell(
                              onTap: () {
                                if (widget.quantities.value[i] > 1) {
                                  setState(() {
                                    widget.quantities.value[i]--;
                                  });
                                  // widget.quantities.notifyListeners();
                                  widget
                                      .onQuantityChanged(); // Panggil callback saat kuantitas berubah
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.remove, size: 18),
                              ),
                            ),
                            // Soal 3.3.5: Menampilkan kuantitas item
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                widget.quantities.value[i].toString().padLeft(
                                  2,
                                  '0',
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4C53A5),
                                ),
                              ),
                            ),
                            // Soal 3.3.5: Tombol tambah untuk menambah kuantitas
                            InkWell(
                              onTap: () {
                                final newList = List<int>.from(
                                  widget.quantities.value,
                                );
                                newList[i]++; // tambah kuantitas
                                widget.quantities.value =
                                    newList; // otomatis trigger notifyListeners()
                                widget
                                    .onQuantityChanged(); // callback ke parent
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.add, size: 18),
                              ),
                            ),
                          ],
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
