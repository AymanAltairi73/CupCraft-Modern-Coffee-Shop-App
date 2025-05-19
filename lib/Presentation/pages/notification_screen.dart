import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utility/navigation_helper.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildNotificationList(),
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
        'Notification',
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

  Widget _buildNotificationList() {
    return ListView(
      padding: EdgeInsets.all(20.r),
      children: [
        _buildSectionHeader('Today'),
        _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1h',
        ),
        _divider(),
        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '2h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '23h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '2h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '23h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '2h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '23h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '2h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '23h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '2h',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '23h',
        ),
        _divider(),

        SizedBox(height: 20.h),
        _buildSectionHeader('Yesterday'),
        _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _divider(),

        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              minimumSize: Size(44.r, 44.r),
            ),
            child: Text(
              'Mark all read',
              style: TextStyle(color: Colors.black54, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String description,
    required String time,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      child: Row(
        children: [
          Container(
            width: 50.r,
            height: 50.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFCE9760),
            ),
            child: Icon(icon, color: Colors.white, size: 24.r),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  description,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 14.sp, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
