import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/account_page.dart';
import 'pages/change_password.dart';
import 'pages/cart_page.dart';
// import 'package:ui_ecommerce/wigets/CartAppBar.dart';
// import 'package:ui_ecommerce/wigets/CartBottomNavBar.dart';
// import 'package:ui_ecommerce/widgets/CartItemSamples.dart';

void main () {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'loginPage',
      routes: {
        'loginPage': (context) => const LoginPage(),
        'registerPage': (context) => const RegisterPage(),
        'accountPage': (context) => const AccountPage(),
        'changePasswordPage': (context) => const ChangePasswordPage(),
        'cartPage': (context) => const CartPage(),
        },

    );
  }

}