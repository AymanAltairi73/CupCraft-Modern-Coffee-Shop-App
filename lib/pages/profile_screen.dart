import 'package:flutter/material.dart';
import '../utility/navigation_helper.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF543A20),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    _buildProfileOptions(),
                  ],
                ),
              ),
            ),
            // CustomBottomNavBar(
            //   selectedIndex: _selectedIndex,
            //   onItemSelected: (index) {
            //     if (index != _selectedIndex) {
            //       setState(() {});
            //     }
            //   },
            // ),
          ],
        ),
      ),
       bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          NavigationHelper.navigateToPage(
            context,
            index,
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Shahzaib',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'shahzaib@example.com',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptions() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildOptionItem(Icons.person_outline, 'Edit Profile'),
          _buildOptionItem(Icons.location_on_outlined, 'Delivery Address'),
          _buildOptionItem(Icons.payment_outlined, 'Payment Methods'),
          _buildOptionItem(Icons.notifications_outlined, 'Notifications'),
          _buildOptionItem(Icons.security_outlined, 'Security'),
          _buildOptionItem(Icons.help_outline, 'Help Center'),
          _buildOptionItem(Icons.logout, 'Logout', isLogout: true),
        ],
      ),
    );
  }
Widget _buildOptionItem(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : const Color(0xFFCE9760),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: isLogout
          ? null
          : const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFCE9760),
              size: 16,
            ),
      onTap: () {
        if (isLogout) {
          _showLogoutDialog(context);
        } else {
          _handleOptionTap(context, title);
        }
      },
    );
  }

  void _handleOptionTap(BuildContext context, String title) {
    switch (title) {
      case 'Edit Profile':
        Navigator.pushNamed(context, '/edit-profile');
        break;
      case 'Delivery Address':
        Navigator.pushNamed(context, '/delivery-address');
        break;
      case 'Payment Methods':
        Navigator.pushNamed(context, '/payment-methods');
        break;
      case 'Notifications':
        Navigator.pushNamed(context, '/notifications');
        break;
      case 'Security':
        Navigator.pushNamed(context, '/settings');
        break;
      case 'Help Center':
        Navigator.pushNamed(context, '/help-center');
        break;
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFCE9760),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Center(
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF543A20),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Yes, Logout',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}