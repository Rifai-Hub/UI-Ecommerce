import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ui_ecommerce/pages/account_page.dart';
import 'package:ui_ecommerce/pages/cart_page.dart';
import 'package:ui_ecommerce/widgets/home/home_app_bar.dart';
import 'package:ui_ecommerce/widgets/home/categories.dart';
import 'package:ui_ecommerce/widgets/home/items_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // _HomepageState createState() => _HomepageState();
  State<HomePage> createState() => _HomepageState();
}

// Class State untuk HomePage
class _HomepageState extends State<HomePage> {
  // Variabel untuk melacak indeks halaman saat ini
  int _currentIndex = 0;
  // PageController untuk mengontrol perpindahan halaman di PageView
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PageView untuk menampilkan konten halaman yang dapat di-swipe
      body: PageView(
        controller: _pageController,
        // Mengubah indeks saat halaman di-swipe
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // Daftar halaman yang akan ditampilkan di PageView
        children: const [
          // Konten utama halaman beranda
          HomePageContent(),
          // Halaman keranjang belanja
          CartPage(),
          // Halaman akun
          AccountPage(),
        ],
      ),
      // Bottom Navigation Bar melengkung
      bottomNavigationBar: CurvedNavigationBar(
        // Mengatur latar belakang menjadi transparan
        backgroundColor: Colors.transparent,
        // Mengatur tinggi navigation bar
        height: 70,
        // Mengatur warna navigation bar
        color: const Color(0XFF4C53A5),
        // Daftar ikon yang akan ditampilkan
        items: [
          // 🔥 Changed: Tambahkan highlight pada ikon aktif dengan warna kuning
          Icon(
            Icons.home,
            size: 30,
            color: _currentIndex == 0 ? Colors.yellow : Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
            color: _currentIndex == 1 ? Colors.yellow : Colors.white,
          ),
          Icon(
            Icons.account_circle_sharp,
            size: 30,
            color: _currentIndex == 2 ? Colors.yellow : Colors.white,
          ),
        ],
        // Mengatur indeks ikon yang aktif
        index: _currentIndex,
        // Fungsi yang dipanggil saat ikon diklik
        onTap: (index) {
          setState(() {
            // Memindahkan halaman ke indeks yang dipilih
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}

// Class HomePageContent sebagai StatelessWidget untuk konten beranda
// Kode ini sekarang berada di dalam file home_page.dart, sesuai permintaan
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Widget untuk App Bar kustom di beranda
        const HomeAppBar(),
        Container(
          // Mengatur padding di bagian atas
          padding: const EdgeInsets.only(top: 15),
          // Mengatur dekorasi container
          decoration: const BoxDecoration(
            color: Color(0XFFEDFDF2),
            // Mengatur sudut membulat di bagian atas
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Column(
            children: [
              // Enhanced search bar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      size: 24,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search products...',
                          hintStyle: TextStyle(
                            color: AppTheme.textLight,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.tune,
                        size: 20,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Categories section header
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const CategoriesWidget(),
              // Best selling section header
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Best Selling',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_list,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
                      label: const Text(
                        'Filter',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const ItemsWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
