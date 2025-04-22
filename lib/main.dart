import 'package:flutter/material.dart';
import 'pages/LoginScreen.dart';
import 'pages/RegisterScreen.dart';
import 'pages/cart_screen.dart';
import 'pages/favorite_screen.dart';
import 'pages/home_screen.dart';
import 'pages/onboarding_screen.dart';
import 'pages/profile_screen.dart';
import 'pages/splash_screen.dart';
import 'provider/cart_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const CoffeeApp(),
    ),
  );
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoffeeScript',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        // إضافة ثيم موحد للتطبيق
        primaryColor: const Color(0xFFCE9760),
        scaffoldBackgroundColor: const Color(0xFF543A20),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCE9760),
          primary: const Color(0xFFCE9760),
          secondary: const Color(0xFF543A20),
        ),
        // تحسين أنماط النصوص
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
      // تنظيم المسارات بشكل أفضل
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/onboarding':
            return MaterialPageRoute(builder: (_) => const OnboardingScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/cart':
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (_) => CartScreen(
                coffeeList: args?['coffeeList'] ?? [],
                onCartChanged: args?['onCartChanged'] ?? ((_, {isSelected, quantity}) {}),
              ),
            );
          case '/favorites':
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (_) => FavoriteScreen(
                coffeeList: args?['coffeeList'] ?? [],
                onFavoriteChanged: args?['onFavoriteChanged'] ?? ((_) {}),
              ),
            );
          case '/profile':
            return MaterialPageRoute(builder: (_) => const ProfileScreen());
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text('Route ${settings.name} not found'),
                ),
              ),
            );
        }
      },
    );
  }
}
