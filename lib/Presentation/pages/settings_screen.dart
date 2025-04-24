import 'package:flutter/material.dart';

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
        'Settings',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      centerTitle: true,
    );
  }
    Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Divider(
        color: const Color(0xFFCE9760).withOpacity(0.3),
        thickness: 1,
        //height: 10,
      ),
    );
  }

  Widget _buildSettingsList() {
    return ListView(
      children: [
        const SizedBox(height: 20),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      leading: CircleAvatar(
        radius: 50,
        backgroundColor: const Color(0xFFCE9760),
        child: Icon(icon, color: Color.fromRGBO(84, 58, 32, 1), size: 40)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          //color: isDestructive ? Colors.red : Colors.black,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
        color: Color(0xFFCE9760),
      ),
      onTap: onTap,
    );
  }
}
