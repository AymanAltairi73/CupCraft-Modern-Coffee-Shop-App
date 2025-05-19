import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../data/model/Coffee.dart';
import '../../core/provider/cart_provider.dart';
import '../../core/utility/navigation_helper.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class CartScreen extends StatefulWidget {
  final List<Coffee> coffeeList;
  final Function(Coffee, {bool? isSelected, int? quantity}) onCartChanged;

  const CartScreen({
    super.key,
    required this.coffeeList,
    required this.onCartChanged,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final int _selectedIndex = 1;
  List<Coffee> get cartItems =>
      widget.coffeeList.where((coffee) => coffee.isSelected).toList();

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF543A20),
          appBar: _buildAppBar(context),
          body: Column(
            children: [
              _buildHeader(cartProvider.items.length),
              Expanded(child: _buildCartItems(context, cartProvider)),
              _buildCouponCode(),
              // _buildOrderSummary(cartProvider),
              _buildFinalizeButton(context),
              //   CustomBottomNavBar(
              //   selectedIndex: _selectedIndex,
              //   onItemSelected: (index) {
              //     setState(() => _selectedIndex = index);
              //   },
              // ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              NavigationHelper.navigateToPage(
                context,
                index,
                coffeeList: widget.coffeeList,
                onCartChanged: widget.onCartChanged,
              );
            },
          ),
          // bottomNavigationBar: _buildBottomNavBar(),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.r),
        onPressed: () => NavigationHelper.goBack(context),
        iconSize: 24.r,
        padding: EdgeInsets.all(8.r),
        constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
      ),
      title: Text(
        'Cart',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: Colors.white, size: 24.r),
          onPressed: () => NavigationHelper.goToNotifications(context),
          iconSize: 24.r,
          padding: EdgeInsets.all(8.r),
          constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
        ),
      ],
    );
  }

  Widget _buildHeader(int itemCount) {
    return Padding(
      padding: EdgeInsets.only(right: 130.w, bottom: 20.h, top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Order',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white70, fontSize: 16.sp),
              children: [
                TextSpan(text: 'You have $itemCount '),
                TextSpan(
                  text: 'items',
                  style: TextStyle(
                    color: const Color(0xFFCE9760),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                TextSpan(
                  text: ' in your cart',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(BuildContext context, CartProvider cartProvider) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: cartProvider.items.length,
      itemBuilder: (context, index) {
        final item = cartProvider.items[index];
        return Dismissible(
          key: Key(item.coffee.name),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20.w),
            color: const Color(0xFF543A20),
            child: Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 25.r,
            ),
          ),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: const Color(0xFFCE9760),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Remove from Cart?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. Vestibulum eget blandit mattis',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF543A20),
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF543A20),
                                minimumSize: Size(120.w, 45.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: const Color(0xFF543A20),
                                  width: 2.r,
                                ),
                                minimumSize: Size(120.w, 45.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color: const Color(0xFF543A20),
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          onDismissed: (direction) {
            cartProvider.removeFromCart(item);
          },

          child: Container(
            margin: EdgeInsets.only(bottom: 15.h),
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              color: const Color(0xFFCE9760),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              children: [
                Image.asset(item.coffee.image, width: 60.r, height: 60.r),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.coffee.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'With ${item.additionalNote ?? "Milk"}',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        '\$${item.coffee.price}',
                        style: TextStyle(
                          color: const Color(0xFF543A20),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _buildQuantityButton(Icons.remove, () {
                      if (item.quantity > 1) {
                        cartProvider.updateQuantity(item, item.quantity - 1);
                      }
                    }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        '${item.quantity}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildQuantityButton(
                      Icons.add,
                      () =>
                          cartProvider.updateQuantity(item, item.quantity + 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: const Color(0xFF543A20),
          borderRadius: BorderRadius.circular(8.r),
        ),
        constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
        child: Icon(icon, color: Colors.white, size: 16.r),
      ),
    );
  }

  Widget _buildCouponCode() {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
              color: const Color(0xFFCE9760),
            ),
            child: Padding(
              padding: EdgeInsets.all(13.r),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Coupon Code here',
                  hintStyle: TextStyle(
                    color: const Color(0xFF543A20),
                    fontSize: 14.sp,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFCE9760).withAlpha(77), // 0.3 * 255 = 77
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  suffixIcon: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF543A20),
                      padding: EdgeInsets.symmetric(
                        vertical: 17.h,
                        horizontal: 30.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.r),
                          bottomRight: Radius.circular(10.r),
                        ),
                      ),
                    ),
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 15.h,
                  ),
                ),
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          ),
          _buildOrderSummary(Provider.of<CartProvider>(context)),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(CartProvider cartProvider) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFCE9760),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Sub-total', '\$${cartProvider.subtotal}'),
          _buildSummaryRow('Shipping', '\$${cartProvider.shipping}'),
          _buildSummaryRow('Total', '\$${cartProvider.total}'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(15.r),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF543A20),
              fontSize: 16.sp,
            ),
          ),
          Expanded(
            child: CustomPaint(
              painter: DottedLinePainter(color: const Color(0xFF543A20)),
              child: SizedBox(height: 2.h),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFF543A20),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalizeButton(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Padding(
          padding: EdgeInsets.all(20.r),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  cartProvider.items.isEmpty
                      ? null
                      : () => NavigationHelper.goToCheckout(
                        context,
                        coffeeList: widget.coffeeList,
                        onCartChanged: widget.onCartChanged,
                      ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF543A20),
                padding: EdgeInsets.symmetric(vertical: 17.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  side: BorderSide(color: const Color(0xFFCE9760), width: 1.r),
                ),
                disabledBackgroundColor: const Color(0xFFCE9760).withAlpha(77), // 0.3 * 255 = 77
                minimumSize: Size(double.infinity, 50.h),
              ),
              child: Text(
                'Finalize Order',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round;

    const double dashWidth = 3;
    const double dashSpace = 3;
    const double padding = 10;
    double startX = padding;
    final double endX = size.width - padding;

    while (startX < endX) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
