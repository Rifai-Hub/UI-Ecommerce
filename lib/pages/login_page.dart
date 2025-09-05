import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Form Login
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

    // Tambahkan deklarasi variabel _isPasswordVisible di sini
  bool _isPasswordVisible = false; // Baris ini yang hilang

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEcommerceLogo(),
                _buildHeader(),
                const SizedBox(height: 40),
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
                const SizedBox(height: 30),
                _buildLoginButton(context),
                const SizedBox(height: 20),
                _buildSignUpLink(context),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0XFF4c53a5),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Login to Continue',
          style: TextStyle(fontSize: 10, color: Color(0XFF4c53a5)),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress, // Tipe keyboard untuk email.
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Masukkan email Anda',
        prefixIcon: const Icon(Icons.email, color: Color(0xFF4C53A5)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), // Sudut border lebih melengkung.
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4C53A5), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4C53A5), width: 2.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Format email tidak valid';
        }
        return null;
      },
    );
  }

 Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible, // Kontrol visibilitas password.
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Masukkan password Anda',
        prefixIcon: const Icon(Icons.lock, color: Color(0xFF4C53A5)),
        suffixIcon: IconButton( // Tombol untuk show/hide password.
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF4C53A5),
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible; // Ubah state visibilitas.
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4C53A5), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4C53A5), width: 2.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        if (value.length < 6) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Validasi form saat tombol ditekan.
        if (_formKey.currentState!.validate()) {
          // Jika validasi berhasil, navigasi ke halaman AccountPage.
          Navigator.pushReplacementNamed(context, 'homePage');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4C53A5), // Warna latar belakang tombol.
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        // Shadow
        elevation: 5,
        shadowColor: const Color(0xFF4C53A5).withAlpha((255 * 0.4).round()),
      ),
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigasi ke halaman RegisterPage.
        Navigator.pushNamed(context, 'registerPage');
      },
      child: const Text(
        'Don\'t have an account? Sign Up',
        style: TextStyle(
          color: Color(0xFF4C53A5),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}


Widget _buildEcommerceLogo() {
  return Column(
    children: [
      Image.asset(
        'assets/images/Rifai_jumbo.png',
        height: 100,
        width: 100,  
      ),
      const SizedBox(height: 10), // Memberi jarak antara logo dan teks
      const Text(
        'Rifai Shop',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4c53a5),
        ),
      ),
    ],
  );
}

