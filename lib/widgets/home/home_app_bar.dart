import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

// Widget kustom untuk bilah aplikasi di halaman beranda
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Wadah utama untuk bilah aplikasi dengan warna latar belakang putih dan padding
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        // Menata elemen-elemen secara horizontal
        children: [
          // Ikon menu di kiri
          const Icon(Icons.sort, size: 30, color: Color(0xFF4C53A5)),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            // Teks judul aplikasi
            child: Text(
              'Rifai Store',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
          // Spacer untuk mendorong elemen-elemen ke kanan
          const Spacer(),
          // Badge untuk notifikasi pesan
          badges.Badge(
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(7),
            ),
            // Konten badge (jumlah notifikasi)
            badgeContent: const Text(
              '9',
              style: TextStyle(color: Colors.white),
            ),
            // Membuat ikon pesan dapat diklik
            child: InkWell(
              onTap: () {
                // Navigasi ke halaman 'ListChat' saat ikon diklik
                Navigator.pushNamed(context, 'ListChat');
              },
              child: const Icon(
                Icons.message_sharp,
                size: 32,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}