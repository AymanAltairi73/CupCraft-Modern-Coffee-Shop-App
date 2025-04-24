import 'package:flutter/material.dart';

import '../../core/utility/navigation_helper.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildOrdersList(),
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
        'My Orders',
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

  Widget _buildOrdersList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildOrderItem(
          image: 'assets/images/robusta.png',
          name: 'Robusta',
          quantity: 2,
          price: 40,
          status: 'In progress',
          isInProgress: true,
        ),_divider(),
        _buildOrderItem(
          image: 'assets/images/liberica.png',
          name: 'Liberica',
          quantity: 2,
          price: 24,
          status: 'In progress',
          isInProgress: true,
        ),_divider(),
        _buildOrderItem(
          image: 'assets/images/traice.png',
          name: 'Cirtus',
          quantity: 2,
          price: 24,
          status: 'delivered',
          isInProgress: false,
        ),_divider(),
        _buildOrderItem(
          image: 'assets/images/liberica.png',
          name: 'Liberica',
          quantity: 2,
          price: 24,
          status: 'delivered',
          isInProgress: false,
        ),_divider(),
        _buildOrderItem(
          image: 'assets/images/robusta.png',
          name: 'Robusta',
          quantity: 2,
          price: 24,
          status: 'delivered',
          isInProgress: false,
        ),_divider(),
        _buildOrderItem(
          image: 'assets/images/traice.png',
          name: 'Cirtus',
          quantity: 2,
          price: 24,
          status: 'delivered',
          isInProgress: false,
        ),
      ],
    );
  }

  Widget _buildOrderItem({
    required String image,
    required String name,
    required int quantity,
    required double price,
    required String status,
    required bool isInProgress,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFCE9760),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Qty: $quantity',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '\$$price',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF543A20),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    color: isInProgress ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // Track/Complete Button
          TextButton(
            onPressed: () {
              if (isInProgress) {
                // Navigate to track order screen
                //Navigator.pushNamed(context, '/track_order');
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: isInProgress 
                  ? const Color(0xFFCE9760)
                  : Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isInProgress 
                      ? Colors.transparent
                      : const Color(0xFFCE9760),
                ),
              ),
            ),
            child: Text(
              isInProgress ? 'Track' : 'Complete',
              style: TextStyle(
                color: isInProgress 
                    ? Colors.white
                    : const Color(0xFFCE9760),
              ),
            ),
          ),
        ],
      ),
    );
  }
}