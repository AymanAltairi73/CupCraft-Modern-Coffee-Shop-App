import 'package:flutter/material.dart';

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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF543A20),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Settings',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
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
        ),
        _buildSettingItem(
          icon: Icons.lock,
          title: 'Password Manager',
          onTap: () {
            // Handle password manager
          },
        ),
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
          color: isDestructive ? Colors.red : Colors.black,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
