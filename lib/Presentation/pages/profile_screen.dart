import 'package:flutter/material.dart';

import '../../core/utility/navigation_helper.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  //final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
      onWillPop: () async {
        NavigationHelper.navigateToPage(context, 0);
        return false;
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF543A20),
      appBar: _buildAppBar(context),
      body: _buildBody(context),
//      bottomNavigationBar: CustomBottomNavBar(
//   selectedIndex: _selectedIndex,
//   onItemSelected: (index) {
//     NavigationHelper.navigateToPage(
//       context,
//       index,
//       coffeeList: [],  // Since ProfileScreen doesn't manage coffee list
//       onCartChanged: (_, {isSelected, quantity}) {},  // Empty callback
//       onFavoriteChanged: (_) {},  // Empty callback
//     );
//   },
// ),
     ));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
     leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => NavigationHelper.goBack(context),
      ),
      title: const Text(
        'Profile',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
     actions: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: () => _navigateToEditProfile(context),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //const SizedBox(height: 20),
          _buildProfileHeader(),
          const SizedBox(height: 20),
          _buildMenuItems(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
            padding: const EdgeInsets.all(20),

      child: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              // Positioned(
              //   right: 0,
              //   bottom: 0,
              //   child: Container(
              //     padding: const EdgeInsets.all(4),
              //     decoration: const BoxDecoration(
              //       color: Color(0xFFCE9760),
              //       shape: BoxShape.circle,
              //     ),
              //     child: const Icon(Icons.edit, color: Colors.white, size: 20),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            'Ayman Altairi.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
           const SizedBox(height: 5),
          Text(
            'aymanaltairi8@gmail.com',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
  void _navigateToEditProfile(BuildContext context) {
    Navigator.pushNamed(context, '/edit-profile');
  }

  void _navigateToPaymentMethods(BuildContext context) {
    Navigator.pushNamed(context, '/payment-methods');
  }

  void _navigateToAddresses(BuildContext context) {
    Navigator.pushNamed(context, '/addresses');
  }

  void _navigateToOrderHistory(BuildContext context) {
    Navigator.pushNamed(context, '/order-history');
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.pushNamed(context, '/settings');
  }

  void _navigateToSupport(BuildContext context) {
    Navigator.pushNamed(context, '/support');
  }

 
  Widget _buildMenuItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.payment,
            title: 'Payment Methods',
            onTap: () => _navigateToPaymentMethods(context),
          ),
          _buildMenuItem(
            icon: Icons.location_on,
            title: 'Delivery Address',
            onTap: () => _navigateToAddresses(context),
          ),
          _buildMenuItem(
            icon: Icons.history,
            title: 'Order History',
            onTap: () => _navigateToOrderHistory(context),
          ),
          _buildMenuItem(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () => NavigationHelper.goToNotifications(context),
          ),
          _buildMenuItem(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () => _navigateToSettings(context),
          ),
          _buildMenuItem(
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () => _navigateToSupport(context),
          ),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => _showLogoutDialog(context),
            textColor: Colors.red,
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
        leading: Icon(icon, color: textColor ?? Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 16,
        ),
      ),
      // leading: Container(
      //   width: 40,
      //   height: 40,
      //   decoration: BoxDecoration(
      //     color: const Color(0xFFCE9760),
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      //   child: Icon(icon, color: Colors.white),
      // ),
      //  title: Text(
      //   title,
      //   style: TextStyle(
      //     color: textColor ?? Colors.white,
      //     fontSize: 16,
      //   ),
      // ),
        trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 16,
      ),
      onTap: onTap,
    );
  }
   void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
             
              Navigator.pop(context);
              NavigationHelper.navigateToPage(context, 0);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

//   Widget _buildBottomNavBar() {
//     return Container(
//       height: 70,
//       decoration: BoxDecoration(
//         color: const Color(0xFFCE9760),
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildNavItem(Icons.home_outlined, true),
//           _buildNavItem(Icons.shopping_cart_outlined, false),
//           _buildNavItem(Icons.favorite_border, false),
//           _buildNavItem(Icons.person_outline, false),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, bool isSelected) {
//     return Icon(
//       icon,
//       color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
//       size: 28,
//     );
//   }
// }
}