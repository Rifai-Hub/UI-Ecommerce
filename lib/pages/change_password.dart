import 'package:flutter/material.dart';

// Widget utama untuk halaman "Change Password".
// Ini adalah StatefulWidget karena memiliki state yang bisa berubah
// (misalnya, visibilitas password).
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  // Metode ini membuat dan mengembalikan instance dari kelas State (_ChangePasswordPageState).
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

// Kelas State yang mengelola data dan UI dari ChangePasswordPage.
class _ChangePasswordPageState extends State<ChangePasswordPage> {
  // Kunci global untuk memvalidasi form.
  final _formKey = GlobalKey<FormState>();
  // TextEditingController untuk mengambil nilai dari setiap input password.
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  // Variabel boolean untuk mengontrol visibilitas teks password di setiap field.
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmNewPasswordVisible = false;

  @override
  // Metode build ini bertanggung jawab untuk membangun UI halaman.
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar di bagian atas halaman.
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        // Warna latar belakang AppBar.
        backgroundColor: const Color(0xFF4C53A5),
        // Warna ikon dan teks di AppBar.
        foregroundColor: Colors.white,
      ),
      // Body halaman, dibungkus dengan SingleChildScrollView agar bisa discroll.
      body: SingleChildScrollView(
        // Padding di sekitar konten form.
        padding: const EdgeInsets.all(24.0),
        child: Form(
          // Menghubungkan Form dengan GlobalKey untuk validasi.
          key: _formKey,
          child: Column(
            // Merentangkan children secara horizontal.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Teks deskripsi di bagian atas form.
              const Text(
                'Update your password for better security.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              // Memberi jarak vertikal.
              const SizedBox(height: 30),
              // Field input untuk password saat ini.
              _buildPasswordField(
                controller: _currentPasswordController,
                labelText: 'Current Password',
                hintText: 'Enter your current password',
                isVisible: _isCurrentPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Current password cannot be empty';
                  }
                  // Logika validasi password saat ini bisa ditambahkan di sini
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Field input untuk password baru.
              _buildPasswordField(
                controller: _newPasswordController,
                labelText: 'New Password',
                hintText: 'Enter your new password',
                isVisible: _isNewPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isNewPasswordVisible = !_isNewPasswordVisible;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'New password cannot be empty';
                  }
                  if (value.length < 6) {
                    return 'New password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Field input untuk konfirmasi password baru.
              _buildPasswordField(
                controller: _confirmNewPasswordController,
                labelText: 'Confirm New Password',
                hintText: 'Confirm your new password',
                isVisible: _isConfirmNewPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isConfirmNewPasswordVisible = !_isConfirmNewPasswordVisible;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm new password cannot be empty';
                  }
                  // Memastikan password baru dan konfirmasi password cocok.
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              // Tombol untuk "Change Password".
              ElevatedButton(
                onPressed: () {
                  // Memvalidasi seluruh form saat tombol ditekan.
                  if (_formKey.currentState!.validate()) {
                    // Jika validasi sukses, tampilkan SnackBar dan kembali ke halaman sebelumnya.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password changed successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Kembali ke halaman sebelumnya (AccountPage).
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C53A5),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 5,
                  shadowColor: const Color(0xFF4C53A5).withAlpha((255 * 0.4).round()),
                ),
                child: const Text(
                  'Change Password',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pembantu yang reusable untuk membuat TextFormField password.
  // Ini membantu mengurangi duplikasi kode.
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      // Mengatur apakah teks password disembunyikan atau terlihat.
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        // Ikon gembok di awal field.
        prefixIcon: const Icon(Icons.lock, color: Color(0xFF4C53A5)),
        // Ikon mata di akhir field untuk show/hide password.
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF4C53A5),
          ),
          onPressed: onToggleVisibility,
        ),
        // Styling border default.
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        // Styling border saat field tidak aktif.
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4C53A5), width: 1.0),
        ),
        // Styling border saat field aktif/fokus.
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4C53A5), width: 2.0),
        ),
      ),
      // Fungsi validator untuk memeriksa input teks.
      validator: validator,
    );
  }
}
