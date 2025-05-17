import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    try {
      // Add a delay for better user experience
      await Future.delayed(const Duration(seconds: 4));

      // Check if user is already logged in
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (mounted) {
        if (currentUser != null) {
          // User is logged in, navigate to home screen
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // User is not logged in, show the Get Started button
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      // Handle any errors during authentication check
      developer.log('Error checking authentication: $e', name: 'SplashScreen');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(77), // 0.3 * 255 = 77
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/splash.png',
                            width: 250,
                            height: 250,
                          ),
                          if (_isLoading)
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: CircularProgressIndicator(
                                color: Color(0xFFCE9760),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (!_isLoading)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 60,
                        left: 24,
                        right: 24,
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          '/onboarding',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCE9760),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF543A20),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}