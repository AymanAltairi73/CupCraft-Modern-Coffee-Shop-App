import 'package:flutter/material.dart';

import '../../core/utility/navigation_helper.dart';

class PaymentDoneScreen extends StatelessWidget {
  const PaymentDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return WillPopScope(
      onWillPop: () async {
        NavigationHelper.navigateToPage(context, 0);
        return false;
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF543A20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () => NavigationHelper.navigateToPage(context, 0),
          ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFCE9760),
                    child: Icon(
                      Icons.check,
                      size: 60,
                      color: Color(0xFF543A20),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Payment Successful',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Thank you for your purchase',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle track order
                    Navigator.pushNamed(context, '/track_order');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCE9760),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Track Order',
                  style: TextStyle(
                    color: Color(0xFF543A20),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      ));
  }
}