import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              Column(  // تغيير من Center إلى Column
                children: [
                  Expanded(  // إضافة Expanded للمحتوى الرئيسي
                    child: Center(
                      child: Image.asset(
                        'assets/images/splash.png',
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                  Padding(  // إضافة Padding للزر في الأسفل
                    padding: const EdgeInsets.only(
                      bottom: 60,  // مسافة من أسفل الشاشة
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