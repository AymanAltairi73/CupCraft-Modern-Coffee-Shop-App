import 'package:flutter/material.dart';

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
      toolbarHeight: 100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFCE9760)),
          onPressed: () => NavigationHelper.goBack(context),
        ),
      ),
      title: const Text(
       'Privacy & Policy',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      centerTitle: true,
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Terms & Conditions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Lorem ipsum dolor sit amet consectetur. Consequat tempus velit tempor eros. Orci egestas pharetra at pharetra lobortis at. Morbi sagittis dui orci quis arcu massa pellentesque libero euismod. Erat laoreet sit mi dictumst ultrices amet. Elementum in commodo scelerisque non in.\n\n'
            'Pulvinar tortor ac aliquam tortor enim. Volutpat aliquam ut purus nibh quisque amet ut morbi. Sed eget auctor quis nibh mattis feugiat tincidunt ridiculus accumsan. Nisl fermentum nulla mattis elementum condimentum leo massa. Potenti leo feugiat orci at scelerisque lacus nibh. Egestas cras sem vestibulum maecenas massa pulvinar rhoncus pharetra arcu. Turpis quam non praesent dictum et arcu ultrices sed.\n\n'
            'Pulvinar tortor ac aliquam tortor enim. Volutpat aliquam ut purus nibh quisque amet ut morbi. Sed eget auctor quis nibh mattis feugiat tincidunt ridiculus accumsan. Nisl fermentum nulla mattis elementum condimentum leo massa. Potenti leo feugiat orci at scelerisque lacus nibh. Egestas cras sem vestibulum maecenas massa pulvinar rhoncus pharetra arcu. Turpis quam non praesent dictum et arcu ultrices sed.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}