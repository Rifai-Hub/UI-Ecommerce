import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ui_ecommerce/pages/account_page.dart';
import 'package:ui_ecommerce/pages/cart_page.dart';
import 'package:ui_ecommerce/pages/list_chat.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const HomePageContent(),
    const CartPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color(0xFF0095DA),
        height: 70,
        color: const Color(0xFF0095DA),
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.account_circle, size: 30, color: Colors.white),
        ],
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final Map<String, int> _itemQuantities = {};

  @override
  void initState() {
    super.initState();
    _initializeQuantities();
  }

  void _initializeQuantities() {
    final List<Map<String, String>> products = [
      {
        'imageUrl': 'assets/images/items/16.jpg',
        'title': 'iPhone 16 Pro',
        'price': 'Rp 20.000.000',
      },
      {
        'imageUrl': 'assets/images/items/huawei.png',
        'title': 'Huawei Watch GT 5',
        'price': 'Rp 3.700.000',
      },
      {
        'imageUrl': 'assets/images/items/Skintific.png',
        'title': 'Skintific 5x Ceramide',
        'price': 'Rp 140.000',
      },
      {
        'imageUrl': 'assets/images/items/16.jpg',
        'title': 'iPhone 16',
        'price': 'Rp 18.999.000',
      },
    ];

    for (var product in products) {
      _itemQuantities[product['title']!] = 1;
    }
  }

  void _incrementQuantity(String title) {
    setState(() {
      _itemQuantities[title] = (_itemQuantities[title] ?? 0) + 1;
    });
  }

  void _decrementQuantity(String title) {
    setState(() {
      if ((_itemQuantities[title] ?? 0) > 1) {
        _itemQuantities[title] = _itemQuantities[title]! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0095DA),
        elevation: 4,
        title: Text(
          'Happy Shop',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline,
                color: Colors.white, size: 26),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatListPage()));
            },
          ),
          const SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 24, color: Color(0XFF0095DA)),
                const SizedBox(width: 8),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Cari Produk...',
                    ),
                  ),
                ),
                const Icon(Icons.qr_code_scanner,
                    size: 24, color: Color(0XFF0095DA)),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: const Color(0XFFEDECF2),
        child: ListView(
          children: [
            _buildSectionTitle('Kategori'),
            _buildCategories(),
            _buildSectionTitle('Produk Terlaris'),
            _buildItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 15, top: 20, bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: const Color(0XFF0095DA),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          _buildCategoryItem(Icons.watch, 'Jam Tangan'),
          _buildCategoryItem(Icons.backpack, 'Tas'),
          _buildCategoryItem(Icons.brush, 'Kosmetik'),
          _buildCategoryItem(Icons.mobile_friendly, 'Elektronik'),
          _buildCategoryItem(Icons.sports_soccer, 'Olahraga'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String title) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, size: 30, color: const Color(0xFF0095DA)),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildItems() {
    final List<Map<String, String>> products = [
      {
        'imageUrl': 'assets/images/items/16.jpg',
        'title': 'iPhone 16 Pro',
        'price': 'Rp 20.000.000',
      },
      {
        'imageUrl': 'assets/images/items/huawei.png',
        'title': 'Huawei Watch GT 5',
        'price': 'Rp 3.700.000',
      },
      {
        'imageUrl': 'assets/images/items/Skintific.png',
        'title': 'Skintific 5x Ceramide',
        'price': 'Rp 140.000',
      },
      {
        'imageUrl': 'assets/images/items/16.jpg',
        'title': 'iPhone 16',
        'price': 'Rp 18.999.000',
      },
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 90),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildItemCard(
          imageUrl: products[index]['imageUrl']!,
          title: products[index]['title']!,
          price: products[index]['price']!,
        );
      },
    );
  }

  Widget _buildItemCard({
    required String imageUrl,
    required String title,
    required String price,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              price,
              style: GoogleFonts.poppins(
                color: const Color(0XFF0095DA),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _decrementQuantity(title);
                        },
                        child: const Icon(Icons.remove, size: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _itemQuantities[title].toString(),
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _incrementQuantity(title);
                        },
                        child: const Icon(Icons.add, size: 20),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'cartPage');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0XFF0095DA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.shopping_bag_outlined,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
