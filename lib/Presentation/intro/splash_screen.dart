import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                            width: 250.w,
                            height: 250.h,
                          ),
                          if (_isLoading)
                            Padding(
                              padding: EdgeInsets.only(top: 30.h),
                              child: SizedBox(
                                width: 40.r,
                                height: 40.r,
                                child: const CircularProgressIndicator(
                                  color: Color(0xFFCE9760),
                                  strokeWidth: 3,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (!_isLoading)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 60.h,
                        left: 24.w,
                        right: 24.w,
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          '/onboarding',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCE9760),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.w,
                            vertical: 15.h,
                          ),
                          minimumSize: Size(200.w, 50.h),
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: const Color(0xFF543A20),
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