import 'package:flutter/material.dart';
import 'package:ui_ecommerce/pages/change_password.dart'; // Pastikan path ini benar

// Widget utama untuk halaman akun.
// Diubah menjadi StatefulWidget untuk bisa menggunakan animasi.
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  // ​‌‌‍⁡⁣⁣⁢𝗪𝗶𝗱𝗴𝗲𝘁 𝗕𝘂𝗶𝗹𝗱 𝗶𝘁𝘂 𝗳𝘂𝗻𝗴𝘀𝗶 𝘂𝗻𝘁𝘂𝗸 𝗺𝗲𝗻𝗮𝗺𝗽𝗶𝗹𝗸𝗮𝗻 𝗵𝗮𝗹𝗮𝗺𝗮𝗻 𝗔𝗰𝗰𝗼𝘂𝗻𝘁 𝗣𝗮𝗴𝗲⁡​

  @override
  State<AccountPage> createState() => _AccountPageState();
}

// Kelas State yang mengelola data dan UI dari AccountPage.
// Ditambahkan SingleTickerProviderStateMixin untuk AnimationController.
class _AccountPageState extends State<AccountPage> with SingleTickerProviderStateMixin {
  // Controller untuk mengelola animasi.
  late AnimationController _animationController;
  // Animasi untuk efek slide (pergerakan).
  late Animation<Offset> _slideAnimation;
  // Animasi untuk efek fade (muncul/hilang secara perlahan).
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Inisialisasi AnimationController.
    _animationController = AnimationController(
      vsync: this, // Menghubungkan controller dengan TickerProvider.
      duration: const Duration(milliseconds: 800), // Durasi animasi 0.8 detik.
    );

    // Mendefinisikan animasi slide: mulai dari sedikit di bawah, berakhir di posisi normal.
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Mulai 20% di bawah posisi akhir.
      end: Offset.zero, // Berakhir di posisi normal (0,0).
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut, // Kurva animasi yang halus (mulai cepat, melambat di akhir).
    ));

    // Mendefinisikan animasi fade: mulai dari transparan penuh, berakhir buram penuh.
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn, // Kurva animasi fade (mulai perlahan, semakin jelas).
      ),
    );

    // Memulai animasi saat halaman dimuat.
    _animationController.forward();
  }

  @override
  void dispose() {
    // Penting: Membuang AnimationController saat widget tidak lagi digunakan
    // untuk mencegah kebocoran memori.
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Account',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.transparent, // Biar transparan
        elevation: 0, // Hilangkan bayangan AppBar
        flexibleSpace: Container( // Buat gradient background ke AppBar
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4C53A5), Color(0xFF6B7cda)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), // Sudut melengkung dibawah AppBar
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Warna ikon (ex: back button)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Agar elemen merentang horizontal
            children: [
              // Menggunakan FadeTransition dan SlideTransition untuk animasi pada Profile Section.
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildProfileSection(),
                ),
              ),
              const SizedBox(height: 30),
              // Menggunakan FadeTransition dan SlideTransition untuk animasi pada Settings Section.
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildSettingsSection(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4C53A5), Color(0xFF6B7cda)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow( // Menambahkan bayangan
            // PERBAIKAN DI SINI: Menggunakan withAlpha() sebagai pengganti withOpacity()
            // 0.5 opasitas berarti 50% transparan.
            // Nilai alpha berkisar dari 0 (transparan penuh) hingga 255 (buram penuh).
            // Jadi, 0.5 * 255 = 127.5, dibulatkan menjadi 128.
            color: Colors.grey.withAlpha((255 * 0.5).round()),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // Pergeseran bayangan
          )
        ]
      ),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/profil_rifai.png', // Pastikan path gambar sudah benar
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Rifai Gusnian',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'rifai@example.com',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ⁡⁣⁣⁢​‌‌‍𝗪𝗶𝗴𝗲𝘁 𝗨𝗻𝘁𝘂𝗸 𝗦𝗲𝘁𝗶𝗮𝗽 𝗣𝗲𝗻𝗴𝗮𝘁𝘂𝗿𝗮𝗻​⁡
  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF4c53a5), size: 28),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  // ⁡⁣⁣⁢​‌‌‍𝗠𝗲𝗻𝘆𝘂𝘀𝘂𝗻 𝗠𝗲𝗻𝘂 𝗦𝗲𝘁𝘁𝗶𝗻𝗴𝘀​⁡

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      children: [
        _buildSettingItem(
          context,
          icon: Icons.person_outline,
          title: 'Edit Profile', // Mengganti teks Profile menjadi Edit Profile
          onTap: () {
            // Navigasi ke halaman Edit Profile (jika ada)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Navigasi ke Edit Profile')),
            );
          },
        ),
        _buildSettingItem(
          context,
          icon: Icons.lock_open_outlined, // Ikon baru untuk Change Password
          title: 'Change Password',
          onTap: () {
            // Navigasi ke halaman ChangePasswordPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
            );
          },
        ),
        _buildSettingItem(
          context,
          icon: Icons.notifications_active_outlined, // Ikon baru untuk Notifications
          title: 'Notifications',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Navigasi ke Notifikasi')),
            );
          },
        ),
        _buildSettingItem(
          context,
          icon: Icons.info_outline, // Ikon baru untuk Help & Support
          title: 'Help & Support',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Navigasi ke Bantuan')),
            );
          },
        ),
        _buildSettingItem(
          context,
          icon: Icons.logout,
          title: 'Logout',
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  // ⁡⁣⁣⁢​‌‌‍​‌‌‍‍⁡⁣⁣⁢𝗠𝗲𝗻𝘂 𝗟𝗢𝗚𝗨𝗧, 𝗮𝗸𝗮𝗻 𝘁𝗮𝗺𝗽𝗶𝗹 𝗮𝗽𝗮𝗯𝗶𝗹𝗮 𝘁𝗼𝗺𝗯𝗼𝗹 𝗹𝗼𝗴𝗼𝘂𝘁 𝗱𝗶 𝗸𝗹𝗶𝗸⁡​

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4C53A5)),
          ),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                // Tampilkan SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logout Successful!'),
                    backgroundColor: Colors.green, // Warna SnackBar
                  ),
                );
                // Arahkan kembali ke halaman Login
                Navigator.pushNamedAndRemoveUntil(context, 'loginPage', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C53A5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}