import 'package:flutter/material.dart';
import 'package:ui_ecommerce/pages/login_page.dart';
import 'package:ui_ecommerce/pages/register_page.dart';
import 'package:ui_ecommerce/pages/account_page.dart';
import 'package:ui_ecommerce/pages/change_password.dart';
import 'package:ui_ecommerce/pages/home_page.dart';
import 'package:ui_ecommerce/pages/cart_page.dart';

void main() {
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
        'loginPage': (context) => LoginPage(),
        'registerPage': (context) => RegisterPage(),
        'accountPage': (context) => AccountPage(),
        'cartPage': (context) => CartPage(),
        'changePassword': (context) => ChangePasswordPage(),
        'homePage': (context) => HomePage(),
        
      },
    );
  }
}