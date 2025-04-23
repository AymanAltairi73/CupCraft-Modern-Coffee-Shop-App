import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildNotificationList(),
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
        'Notification',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildNotificationList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildSectionHeader('Today'),
        _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1h',
        ),
        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '2h',
        ),
        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '23h',
        ),
         _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1h',
        ),
        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '2h',
        ),
        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '23h',
        ),
         _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1h',
        ),
        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '2h',
        ),
        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '23h',
        ),
         _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1h',
        ),
        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '2h',
        ),
        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '23h',
        ),
         _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1h',
        ),
        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '2h',
        ),
        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '23h',
        ),
        const SizedBox(height: 20),
        _buildSectionHeader('Yesterday'),
        _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
         _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ), _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
         _buildNotificationItem(
          icon: Icons.delivery_dining,
          title: 'Order Delivered',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _buildNotificationItem(
          icon: Icons.percent,
          title: '20% discount Alert',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
        _buildNotificationItem(
          icon: Icons.favorite_border,
          title: 'New Product launch',
          description: 'Lorem ipsum dolor sit amet consectetur.\nScelerisque',
          time: '1d',
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String description,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFCE9760),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}