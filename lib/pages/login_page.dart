import 'package:flutter/material.dart';
import 'package:ui_ecommerce/widgets/common/custom_button.dart';
import 'package:ui_ecommerce/widgets/common/custom_text_field.dart';
import 'package:ui_ecommerce/theme/app_theme.dart';

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
      backgroundColor: AppTheme.backgroundColor,
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
    return Column(
      children: [
        const Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Login to Continue',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
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
      labelText: 'Password',
      hintText: 'Enter your password',
      prefixIcon: Icons.lock_outline,
      suffixIcon: _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
      onSuffixIconPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
        if (_formKey.currentState!.validate()) {
          // Jika validasi berhasil, navigasi ke halaman AccountPage.
          return 'Password is required';
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
          return 'Password must be at least 6 characters';
        'Login',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        text: 'Login',
        icon: Icons.login,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.pushReplacementNamed(context, 'homePage');
          }
        },
      ),
    );
  }

    return ElevatedButton(
        // Navigasi ke halaman RegisterPage.
        Navigator.pushNamed(context, 'registerPage');
      },
      child: const Text(
        backgroundColor: const Color(0xFF4C53A5),
        style: TextStyle(
          color: Color(0xFF4C53A5),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}


Widget _buildEcommerceLogo() {
    children: [
      Image.asset(
      child: Text(
        height: 100,
        width: 100,  
      ),
      const SizedBox(height: 10), // Memberi jarak antara logo dan teks
      Text(
        'Rifai Shop',
        style: TextStyle(
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
        ),
      ),
    ],
  );
}


      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: AppTheme.elevatedShadow,
        ),
        child: Image.asset(
          'assets/images/Rifai_jumbo.png',
          height: 80,
          width: 80,
          color: Colors.white,
        ),