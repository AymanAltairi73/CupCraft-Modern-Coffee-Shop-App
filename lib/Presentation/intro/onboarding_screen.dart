import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/on-1.png',
      'title': 'Fresh Coffee',
      'description': 'The best grain, the finest roast, the powerful flavor.',
    },
    {
      'image': 'assets/images/on-2.png',
      'title': 'Easy to Order',
      'description': 'Order coffee and pick-up at your nearest branch.',
    },
    {
      'image': 'assets/images/on-3.png',
      'title': 'Best Quality',
      'description': 'Enjoy the great taste of our special coffee.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for images and text
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => onLastPage = index == pages.length - 1);
            },
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Background Image
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(pages[index]['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Black Overlay
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  // Title and Description
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 300,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            pages[index]['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            pages[index]['description']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFCE9760),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Top Bar with Skip button and Page Indicator
          Positioned(
            top: 50,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Page Indicator
                SmoothPageIndicator(
                  controller: _controller,
                  count: pages.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.white30,
                    activeDotColor: Color(0xFFCE9760),
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 8,
                    expansionFactor: 3,
                  ),
                ),

                // Skip Button - Only shown when not on last page
                if (!onLastPage)
                  TextButton(
                    onPressed: () => _controller.jumpToPage(pages.length - 1),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Bottom Buttons
          if (onLastPage)
            Positioned(
              bottom: 50,
              left: 24,
              right: 24,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCE9760),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF543A20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                            color: Color(0xFFCE9760),
                            width: 2,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCE9760),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
