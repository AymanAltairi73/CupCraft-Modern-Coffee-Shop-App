import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/utility/navigation_helper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  //final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) {
          NavigationHelper.navigateToPage(context, 0);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF543A20),
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.r),
        onPressed: () => NavigationHelper.goBack(context),
      ),
      title: Text(
        'Profile',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: Colors.white, size: 28.r),
          onPressed: () => Navigator.pushNamed(context, '/notifications'),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //SizedBox(height: 20.h),
          _buildProfileHeader(),
          SizedBox(height: 20.h),
          _buildMenuItems(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundImage: const AssetImage('assets/images/profile.png'),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(
                    color: Color(0xFFCE9760),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20.r,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Text(
            user?.displayName ?? 'Guest',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }


  Widget _buildMenuItems(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.person_outline,
            title: 'Your Profile',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.shopping_bag_outlined,
            title: 'My Orders',
            onTap: () => Navigator.pushNamed(context, '/my-orders'),
          ),

          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: 'Setting',
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          _buildMenuItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy policy',
            onTap: () => Navigator.pushNamed(context, '/privacy-policy'),
          ),
          _buildMenuItem(
            icon: Icons.person_add_outlined,
            title: 'Invite Friend',
            onTap: () => _showInviteFriendDialog(context),
          ),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => _showLogoutDialog(context),
            //textColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Container(
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(
          color: const Color(0xFFCE9760),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(icon, color: Colors.white, size: 20.r),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      trailing: Icon(
        Icons.arrow_forward_ios,
        color: const Color(0xFFCE9760),
        size: 16.r,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFFCE9760),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            title: Center(
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
            ),
            content: Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                color: const Color(0xFF543A20),
                fontSize: 15.sp,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF543A20), width: 2.r),
                      borderRadius: BorderRadius.circular(8.r),
                      color: const Color(0xFF543A20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/login');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 10.h,
                        ),
                      ),
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF543A20),
                        width: 2.r,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 10.h,
                        ),
                      ),
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: const Color(0xFF543A20),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  void _showInviteFriendDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFFCE9760),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            title: Text(
              'Share App',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Share this app with your friends',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildShareButton(
                      icon: FontAwesomeIcons.whatsapp,
                      onTap: () => Navigator.pop(context),
                    ),
                    _buildShareButton(
                      icon: Icons.facebook,
                      onTap: () => Navigator.pop(context),
                    ),
                    _buildShareButton(
                      icon: Icons.copy,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildShareButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF543A20),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white, width: 1.r),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 22.r),
        padding: EdgeInsets.all(12.r),
        onPressed: onTap,
      ),
    );
  }
}
