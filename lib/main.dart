import 'package:flutter/material.dart';
import 'model/Coffee.dart';
import 'pages/LoginScreen.dart';
import 'pages/RegisterScreen.dart';
import 'pages/add_paymentCard_screen.dart';
import 'pages/cart_screen.dart';
import 'pages/checkout_screen.dart';
import 'pages/favorite_screen.dart';
import 'pages/home_screen.dart';
import 'pages/my_orders_screen.dart';
import 'pages/notification_screen.dart';
import 'pages/onboarding_screen.dart';
import 'pages/payment_done_screen.dart';
import 'pages/privacy_policy_screen.dart';
import 'pages/profile_screen.dart';
import 'pages/settings_screen.dart';
import 'pages/splash_screen.dart';
import 'pages/track_order_screen.dart';
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
              builder:
                  (_) => CartScreen(
                    coffeeList: args?['coffeeList'] ?? [],
                    onCartChanged:
                        args?['onCartChanged'] ??
                        ((_, {isSelected, quantity}) {}),
                  ),
            );
          case '/favorites':
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder:
                  (_) => FavoriteScreen(
                    coffeeList: args?['coffeeList'] ?? [],
                    onFavoriteChanged: args?['onFavoriteChanged'] ?? ((_) {}),
                  ),
            );
          case '/profile':
            return MaterialPageRoute(builder: (_) => const ProfileScreen());
          case '/add_payment_card':
            return MaterialPageRoute(builder: (_) => const AddCardScreen());
          case '/payment_done':
            return MaterialPageRoute(builder: (_) => const PaymentDoneScreen());
          case '/checkout':
            final args = settings.arguments as Map<String, dynamic>?;
            if (args == null) {
              return MaterialPageRoute(builder: (_) => const HomeScreen());
            }

            final List<Coffee> coffeeList = args['coffeeList'] as List<Coffee>;
            final Function(Coffee, {bool? isSelected, int? quantity})
            onCartChanged =
                args['onCartChanged']
                    as Function(Coffee, {bool? isSelected, int? quantity});

            return MaterialPageRoute(
              builder:
                  (context) => CheckoutScreen(
                    coffeeList: coffeeList,
                    onCartChanged: onCartChanged,
                  ),
            );
          case 'addPaymentCard':
            return MaterialPageRoute(builder: (_) => const AddCardScreen());
          case '/track_order':
            return MaterialPageRoute(builder: (_) => const TrackOrderScreen());
          case '/notifications':
            return MaterialPageRoute(
              builder: (_) => const NotificationScreen(),
            );
          case '/my_orders':
            return MaterialPageRoute(builder: (_) => const MyOrdersScreen());
            case '/edit-profile':
  //return MaterialPageRoute(builder: (_) => const EditProfileScreen());
case '/my-orders':
  return MaterialPageRoute(builder: (_) => const MyOrdersScreen());
  case '/privacy-policy':
  return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
case '/settings':
  return MaterialPageRoute(builder: (_) => const SettingsScreen());
  
//case '/privacy-policy':
 //return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
//case '/invite-friend':
  //return MaterialPageRoute(builder: (_) => const InviteFriendScreen());
  

          default:
            return MaterialPageRoute(
              builder:
                  (_) => Scaffold(
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
