import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_ecommerce/pages/login_page.dart';
import 'package:ui_ecommerce/pages/register_page.dart';
import 'package:ui_ecommerce/pages/account_page.dart';
import 'package:ui_ecommerce/pages/change_password.dart';
import 'package:ui_ecommerce/pages/home_page.dart';
import 'package:ui_ecommerce/pages/cart_page.dart';
import 'package:ui_ecommerce/pages/list_chat.dart';
import 'package:ui_ecommerce/chat/detail_chat.dart';
import 'package:ui_ecommerce/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rifai Store',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: 'loginPage',
      routes: {
        'loginPage': (context) => LoginPage(),
        'registerPage': (context) => RegisterPage(),
        'accountPage': (context) => AccountPage(),
        'cartPage': (context) => CartPage(),
        'changePassword': (context) => ChangePasswordPage(),
        'homePage': (context) => HomePage(),
        'listChat': (context) => ChatListPage(),
         "ChatDetail": (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return ChatScreen(
            contactName: args['contactName'],
            avatarAsset: args['avatarAsset'],
          );
        },
        
      }
    );
  }
}