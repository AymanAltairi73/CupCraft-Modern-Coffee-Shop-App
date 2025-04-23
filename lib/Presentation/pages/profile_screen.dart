import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  //final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
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
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/notifications'),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildProfileHeader(),
          const SizedBox(height: 30),
          _buildMenuItems(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFCE9760),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 20),
              ),
            ),
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
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.person_outline,
          title: 'Your Profile',
          onTap: () => Navigator.pushNamed(context, '/edit-profile'),
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
          onTap: () => Navigator.pushNamed(context, '/invite-friend'),
        ),
        _buildMenuItem(
          icon: Icons.logout,
          title: 'Logout',
          onTap: () {
            // Handle logout logic
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFCE9760),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 16,
      ),
      onTap: onTap,
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