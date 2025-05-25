import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF543A20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.r),
          onPressed: () => Navigator.pop(context),
          iconSize: 24.r,
          padding: EdgeInsets.all(8.r),
          constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
        ),
        title: Text(
          'Track Order',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Delivery Image
          SizedBox(
            height: 250.h,
            child: Image.asset('assets/images/delivery_tracking.png'),
          ),

          // Estimated Delivery Time
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 10.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: const BoxDecoration(
                    color: Color(0xFFCE9760),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: 50.r,
                  ),
                ),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estimated Delivery time',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '45 - 55 min',
                      style: TextStyle(
                        color: const Color(0xFFCE9760),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Order Timeline
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 100.w, top: 10.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTimelineItem(
                      'Order placed',
                      '23 march, 2024, 04:35 PM',
                      isCompleted: true,
                    ),
                    _buildTimelineItem(
                      'In Progress',
                      '23 march, 2024, 04:40 PM',
                      isCompleted: true,
                    ),
                    _buildTimelineItem(
                      'On Your way',
                      '23 march, 2024, 05:10 PM',
                      isCompleted: false,
                    ),
                    _buildTimelineItem(
                      'Deliverd',
                      '23 march, 2024, 05:20 PM',
                      isCompleted: false,
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Chat Button
          Padding(
            padding: EdgeInsets.all(20.r),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle chat with rider
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
                  'Chat with Rider',
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
    );
  }

  Widget _buildTimelineItem(String title, String time,
      {bool isCompleted = false, bool isLast = false}) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 35.r,
              height: 35.r,
              decoration: BoxDecoration(
                color: isCompleted ? const Color(0xFFCE9760) : const Color(0xFF543A20),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? const Color(0xFFCE9760) : const Color(0xFFCE9760),
                  width: 2.r,
                )
              ),
              child: Icon(
                Icons.check,
                color: isCompleted ? const Color(0xFF543A20) : const Color(0xFFCE9760),
                size: 20.r,
              ),
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 40.h,
                color: isCompleted ? const Color(0xFFCE9760) : Colors.grey,
              ),
          ],
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.sp,
                ),
              ),
              if (!isLast) SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }
}