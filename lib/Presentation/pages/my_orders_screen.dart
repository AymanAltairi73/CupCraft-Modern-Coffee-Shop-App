import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utility/navigation_helper.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildOrdersList(),
    );
  }

    AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF543A20),
      elevation: 0,
      toolbarHeight: 100.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: const Color(0xFFCE9760), size: 24.r),
          onPressed: () => NavigationHelper.goBack(context),
          iconSize: 24.r,
          padding: EdgeInsets.all(8.r),
          constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
        ),
      ),
      title: Text(
        'My Orders',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }
    Widget _divider() {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Divider(
        color: const Color(0xFFCE9760).withAlpha(77), // 0.3 * 255 = 77
        thickness: 1.h,
      ),
    );
  }

  Widget _buildOrdersList() {
    return ListView(
      padding: EdgeInsets.all(20.r),
      children: [
        _buildOrderItem(
          image: 'assets/images/robusta.png',
          name: 'Robusta',
          quantity: 2,
          price: 40,
          status: 'In progress',
          isInProgress: true,
        ),_divider(),
        _buildOrderItem(
          image: 'assets/images/liberica.png',
          name: 'Liberica',
          quantity: 2,
          price: 24,
          status: 'In progress',
          isInProgress: true,
        ),_divider(),
        _buildOrderItem(
          image: 'assets/images/traice.png',
          name: 'Cirtus',
          quantity: 2,
          price: 24,
          status: 'delivered',
          isInProgress: false,
        ),_divider(),
        _buildOrderItem(
          image: 'assets/images/liberica.png',
          name: 'Liberica',
          quantity: 2,
          price: 24,
          status: 'delivered',
          isInProgress: false,
        ),_divider(),
        _buildOrderItem(
          image: 'assets/images/robusta.png',
          name: 'Robusta',
          quantity: 2,
          price: 24,
          status: 'delivered',
          isInProgress: false,
        ),_divider(),
        _buildOrderItem(
          image: 'assets/images/traice.png',
          name: 'Cirtus',
          quantity: 2,
          price: 24,
          status: 'delivered',
          isInProgress: false,
        ),
      ],
    );
  }

  Widget _buildOrderItem({
    required String image,
    required String name,
    required int quantity,
    required double price,
    required String status,
    required bool isInProgress,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 90.r,
            height: 90.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: const Color(0xFFCE9760),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Qty: $quantity',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  '\$$price',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF543A20),
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isInProgress ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // Track/Complete Button
          TextButton(
            onPressed: () {
              if (isInProgress) {
                // Navigate to track order screen
                //Navigator.pushNamed(context, '/track_order');
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: isInProgress
                  ? const Color(0xFFCE9760)
                  : Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
                side: BorderSide(
                  color: isInProgress
                      ? Colors.transparent
                      : const Color(0xFFCE9760),
                  width: 1.r,
                ),
              ),
              minimumSize: Size(80.w, 36.h),
            ),
            child: Text(
              isInProgress ? 'Track' : 'Complete',
              style: TextStyle(
                color: isInProgress
                    ? Colors.white
                    : const Color(0xFFCE9760),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}