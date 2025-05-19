import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utility/navigation_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildSettingsList(),
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
        'Settings',
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

  Widget _buildSettingsList() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      children: [
        SizedBox(height: 20.h),
        _buildSettingItem(
          icon: Icons.notifications,
          title: 'Notification setting',
          onTap: () {
            //(context) => Navigator.pushNamed(context, '/notification');
          },
        ), _divider(),
        _buildSettingItem(
          icon: Icons.lock,
          title: 'Password Manager',
          onTap: () {
            // Handle password manager
          },
        ),_divider(),
        _buildSettingItem(
          icon: Icons.credit_card,
          title: 'Delete Account',
          onTap: () {
            // Handle delete account
          },
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      leading: CircleAvatar(
        radius: 30.r,
        backgroundColor: const Color(0xFFCE9760),
        child: Icon(
          icon,
          color: const Color.fromRGBO(84, 58, 32, 1),
          size: 24.r,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: isDestructive ? Colors.red : Colors.black,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 20.r,
        color: const Color(0xFFCE9760),
      ),
      onTap: onTap,
    );
  }
}
