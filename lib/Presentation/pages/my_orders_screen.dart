import 'package:flutter/material.dart';

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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF543A20),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'My Orders',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
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
        ),
        _buildOrderItem(
          image: 'assets/images/liberica.png',
          name: 'Liberica',
          quantity: 2,
          price: 24,
          status: 'In progress',
          isInProgress: true,
        ),
        _buildOrderItem(
          image: 'assets/images/traice.png',
          name: 'Cirtus',
          quantity: 2,
          price: 24,
          status: 'delivered',
          isInProgress: false,
        ),
        _buildOrderItem(
          image: 'assets/images/liberica.png',
          name: 'Liberica',
          quantity: 2,
          price: 24,
          status: 'delivered',
          isInProgress: false,
        ),
        _buildOrderItem(
          image: 'assets/images/robusta.png',
          name: 'Robusta',
          quantity: 2,
          price: 24,
          status: 'delivered',
          isInProgress: false,
        ),
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
      margin: const EdgeInsets.only(bottom: 15),
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