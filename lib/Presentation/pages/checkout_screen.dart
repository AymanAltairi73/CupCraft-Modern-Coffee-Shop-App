import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/model/Coffee.dart';
import '../../core/provider/cart_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
    required this.coffeeList,
    required this.onCartChanged,
  });
  final List<Coffee> coffeeList;
  final Function(Coffee coffee, {bool? isSelected, int? quantity})
  onCartChanged;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF543A20),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.r),
              onPressed: () => Navigator.pop(context),
              iconSize: 24.r,
              padding: EdgeInsets.all(8.r),
              constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
            ),
            title: Text(
              'Checkout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deliver Address',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                _buildAddressCard(),
                SizedBox(height: 10.h),
                Text(
                  'Add Payment Method',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                _buildPaymentCard(context),
                SizedBox(height: 10.h),
                _buildStripePaymentCard(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product List',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${cartProvider.items.length} items',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Expanded(child: _buildProductList(cartProvider)),
                _buildOrderSummary(cartProvider),
                _buildContinueButton(context, cartProvider),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildAddressCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF543A20),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFCE9760),
              radius: 24.r,
              child: Icon(
                Icons.location_on_outlined,
                color: const Color(0xFF543A20),
                size: 30.r,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '1910, Wien stodt, At',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFCE9760),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
              minimumSize: Size(80.w, 30.h),
            ),
            child: Text(
              'Change',
              style: TextStyle(
                color: const Color(0xFF543A20),
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF543A20),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFCE9760),
              radius: 24.r,
              child: Icon(Icons.add, color: const Color(0xFF543A20), size: 30.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Master Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Credit or debit',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
               Navigator.pushNamed(context, '/add_payment_card');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCE9760),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
              minimumSize: Size(60.w, 30.h),
            ),
            child: Text(
              'Add',
              style: TextStyle(
                color: const Color(0xFF543A20),
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildStripePaymentCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF543A20),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFCE9760),
              radius: 24.r,
              child: Icon(Icons.add, color: const Color(0xFF543A20), size: 30.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Paypal Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Credit or debit',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
               //Navigator.pushNamed(context, '/add_payment_card');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCE9760),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
              minimumSize: Size(60.w, 30.h),
            ),
            child: Text(
              'Add',
              style: TextStyle(
                color: const Color(0xFF543A20),
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildProductList(CartProvider cartProvider) {
    if (cartProvider.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 64.r,
              color: Colors.white.withAlpha(128), // 0.5 * 255 = 128
            ),
            SizedBox(height: 16.h),
            Text(
              'No items in cart',
              style: TextStyle(
                color: Colors.white.withAlpha(128), // 0.5 * 255 = 128
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: cartProvider.items.length,
      separatorBuilder:
          (context, index) =>
              Divider(color: const Color(0xFFCE9760), height: 2.h),
      itemBuilder: (context, index) {
        final item = cartProvider.items[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: const Color(0xFFCE9760).withAlpha(77), // 0.3 * 255 = 77
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  color: const Color(0xFFCE9760),
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: AssetImage(item.coffee.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.coffee.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Size: ${item.additionalNote ?? "Regular"}',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      'Quantity: ${item.quantity}',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '\$${(item.coffee.price * item.quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrderSummary(CartProvider cartProvider) {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFFCE9760).withAlpha(77), // 0.3 * 255 = 77
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            'Subtotal',
            '\$${cartProvider.subtotal.toStringAsFixed(2)}',
          ),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'Shipping',
            '\$${cartProvider.shipping.toStringAsFixed(2)}',
          ),
          Divider(color: Colors.white30, height: 20.h),
          _buildSummaryRow(
            'Total',
            '\$${cartProvider.total.toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 16.sp),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context, CartProvider cartProvider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed:
            cartProvider.items.isEmpty
                ? null
                : () {
                  // Handle payment process
                    Navigator.pushReplacementNamed(context, '/payment_done');
                },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFCE9760),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          disabledBackgroundColor: const Color(0xFFCE9760).withAlpha(77), // 0.3 * 255 = 77
          minimumSize: Size(double.infinity, 50.h),
        ),
        child: Text(
          'Continue Payment',
          style: TextStyle(
            color: const Color(0xFF543A20),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
