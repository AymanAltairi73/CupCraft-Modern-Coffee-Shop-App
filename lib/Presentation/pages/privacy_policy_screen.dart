import 'package:flutter/material.dart';

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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF543A20),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Privacy & Policy',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
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