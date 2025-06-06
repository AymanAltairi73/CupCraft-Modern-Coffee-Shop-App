import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'Presentation/Authentication/LoginScreen.dart';
import 'Presentation/Authentication/RegisterScreen.dart';
import 'Presentation/intro/onboarding_screen.dart';
import 'Presentation/intro/splash_screen.dart';
import 'Presentation/pages/add_paymentCard_screen.dart';
import 'Presentation/pages/cart_screen.dart';
import 'Presentation/pages/checkout_screen.dart';
import 'Presentation/pages/favorite_screen.dart';
import 'Presentation/pages/home_screen.dart';
import 'Presentation/pages/my_orders_screen.dart';
import 'Presentation/pages/notification_screen.dart';
import 'Presentation/pages/payment_done_screen.dart';
import 'Presentation/pages/privacy_policy_screen.dart';
import 'Presentation/pages/profile_screen.dart';
import 'Presentation/pages/settings_screen.dart';
import 'Presentation/pages/track_order_screen.dart';
import 'core/provider/cart_provider.dart';
import 'data/model/Coffee.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
    // Initialize ScreenUtil with design size based on iPhone X dimensions
    return ScreenUtilInit(
      designSize: const Size(375.0, 812.0),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CoffeeScript',
          theme: ThemeData(
            fontFamily: 'Montserrat',

            primaryColor: const Color(0xFFCE9760),
            scaffoldBackgroundColor: const Color(0xFF543A20),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFCE9760),
              primary: const Color(0xFFCE9760),
              secondary: const Color(0xFF543A20),
            ),

            // Use responsive font sizes with ScreenUtil
            textTheme: TextTheme(
              headlineLarge: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              bodyLarge: TextStyle(color: Colors.white, fontSize: 16.sp),
              bodyMedium: TextStyle(color: Colors.white70, fontSize: 14.sp),
            ),
          ),

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
            return MaterialPageRoute(
              builder: (_) => const PrivacyPolicyScreen(),
            );
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
      },
    );
  }
}
