import 'package:flutter/material.dart';

class CoffeePageTransitions {
  // تأثير التلاشي المتدرج مع حركة ناعمة
  static PageRouteBuilder fadeSlideTransition({
    required Widget page,
    Alignment alignment = Alignment.bottomCenter,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Stack(
          children: [
            // تأثير التلاشي للخلفية
            FadeTransition(
              opacity: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            // حركة ظهور المحتوى
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.1),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ),
              ),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }

  // تأثير التدرج البطيء
  static PageRouteBuilder smoothFadeTransition({
    required Widget page,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 800),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Stack(
          children: [
            // تأثير الخلفية
            FadeTransition(
              opacity: Tween<double>(
                begin: 0.0,
                end: 0.5,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.brown.withOpacity(0.1),
                      Colors.brown.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
            // ظهور المحتوى
            FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
              ),
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 0.95,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }

  // تأثير الظهور التدريجي مع حركة جانبية ناعمة
  static PageRouteBuilder gentleSlideTransition({
    required Widget page,
    bool rightToLeft = true,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 700),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Stack(
          children: [
            // تأثير الخلفية
            FadeTransition(
              opacity: animation,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.05),
                ),
              ),
            ),
            // حركة المحتوى
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(rightToLeft ? 0.2 : -0.2, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutQuart,
                ),
              ),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}

enum TransitionType {
  fade,
  smooth,
  gentle,
}