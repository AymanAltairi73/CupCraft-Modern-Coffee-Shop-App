import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utility/navigation_helper.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildContent(),
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
       'Privacy & Policy',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Terms & Conditions',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Lorem ipsum dolor sit amet consectetur. Consequat tempus velit tempor eros. Orci egestas pharetra at pharetra lobortis at. Morbi sagittis dui orci quis arcu massa pellentesque libero euismod. Erat laoreet sit mi dictumst ultrices amet. Elementum in commodo scelerisque non in.\n\n'
            'Pulvinar tortor ac aliquam tortor enim. Volutpat aliquam ut purus nibh quisque amet ut morbi. Sed eget auctor quis nibh mattis feugiat tincidunt ridiculus accumsan. Nisl fermentum nulla mattis elementum condimentum leo massa. Potenti leo feugiat orci at scelerisque lacus nibh. Egestas cras sem vestibulum maecenas massa pulvinar rhoncus pharetra arcu. Turpis quam non praesent dictum et arcu ultrices sed.\n\n'
            'Pulvinar tortor ac aliquam tortor enim. Volutpat aliquam ut purus nibh quisque amet ut morbi. Sed eget auctor quis nibh mattis feugiat tincidunt ridiculus accumsan. Nisl fermentum nulla mattis elementum condimentum leo massa. Potenti leo feugiat orci at scelerisque lacus nibh. Egestas cras sem vestibulum maecenas massa pulvinar rhoncus pharetra arcu. Turpis quam non praesent dictum et arcu ultrices sed.',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}