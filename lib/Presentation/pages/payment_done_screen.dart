import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utility/navigation_helper.dart';

class PaymentDoneScreen extends StatelessWidget {
  const PaymentDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return WillPopScope(
      onWillPop: () async {
        NavigationHelper.navigateToPage(context, 0);
        return false;
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF543A20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white, size: 24.r),
          onPressed: () => NavigationHelper.navigateToPage(context, 0),
          iconSize: 24.r,
          padding: EdgeInsets.all(8.r),
          constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: const Color(0xFFCE9760),
                    child: Icon(
                      Icons.check,
                      size: 60.r,
                      color: const Color(0xFF543A20),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Payment Successful',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Thank you for your purchase',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle track order
                    Navigator.pushNamed(context, '/track_order');
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
                  'Track Order',
                  style: TextStyle(
                    color: const Color(0xFF543A20),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      ));
  }
}