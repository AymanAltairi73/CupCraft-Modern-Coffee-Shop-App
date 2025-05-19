import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                      color: Colors.black.withAlpha(128), // 0.5 * 255 = 128
                    ),
                  ),
                  // Title and Description
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 300.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            pages[index]['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 45.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            pages[index]['description']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFCE9760),
                              fontSize: 18.sp,
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
            top: 50.h,
            left: 24.w,
            right: 24.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Page Indicator
                SmoothPageIndicator(
                  controller: _controller,
                  count: pages.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.white30,
                    activeDotColor: const Color(0xFFCE9760),
                    dotHeight: 8.r,
                    dotWidth: 8.r,
                    spacing: 8.r,
                    expansionFactor: 3,
                  ),
                ),

                // Skip Button - Only shown when not on last page
                if (!onLastPage)
                  TextButton(
                    onPressed: () => _controller.jumpToPage(pages.length - 1),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha(51), // 0.2 * 255 = 51
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      minimumSize: Size(80.w, 36.h),
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
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
              bottom: 50.h,
              left: 24.w,
              right: 24.w,
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
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        minimumSize: Size(double.infinity, 50.h),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF543A20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(
                            color: const Color(0xFFCE9760),
                            width: 2.r,
                          ),
                        ),
                        minimumSize: Size(double.infinity, 50.h),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFCE9760),
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
