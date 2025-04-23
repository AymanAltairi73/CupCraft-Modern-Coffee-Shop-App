import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF543A20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Track Order',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Delivery Image
          SizedBox(
            height: 250,
            child: Image.asset('assets/images/delivery_tracking.png'),
          ),
          
          // Estimated Delivery Time
          Padding(
            padding: const EdgeInsets.only(left: 20,  top: 20,bottom: 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFCE9760),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estimated Delivery time',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '45 - 55 min',
                      style: TextStyle(
                        color: Color(0xFFCE9760),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Order Timeline
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 100),
              child: Column(
                children: [
                  _buildTimelineItem(
                    'Order placed',
                    '23 march, 2024, 04:35 PM',
                    isCompleted: true,
                  ),
                  _buildTimelineItem(
                    'In Progress',
                    '23 march, 2024, 04:40 PM',
                    isCompleted: true,
                  ),
                  _buildTimelineItem(
                    'On Your way',
                    '23 march, 2024, 05:10 PM',
                    isCompleted: false,
                  ),
                  _buildTimelineItem(
                    'Deliverd',
                    '23 march, 2024, 05:20 PM',
                    isCompleted: false,
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),

          // Chat Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle chat with rider
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCE9760),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Chat with Rider',
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
    );
  }

  Widget _buildTimelineItem(String title, String time,
      {bool isCompleted = false, bool isLast = false}) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: isCompleted ? const Color(0xFFCE9760) : Color(0xFF543A20),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? const Color(0xFFCE9760) : Color(0xFFCE9760),
                  width: 2,
                )
              ),
              child: Icon(
                Icons.check,
                color: isCompleted ? const Color(0xFF543A20) : Color(0xFFCE9760),
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: isCompleted ? const Color(0xFFCE9760) : Colors.grey,
              ),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              if (!isLast) const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
}