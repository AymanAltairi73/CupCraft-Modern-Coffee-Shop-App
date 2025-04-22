import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/Coffee.dart';
import '../provider/cart_provider.dart';
import '../utility/navigation_helper.dart';
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
  int _selectedIndex = 1;
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
              Expanded(
                child: _buildCartItems(context, cartProvider),
              ),
              _buildCouponCode(),
              _buildOrderSummary(cartProvider),
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
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Cart',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildHeader(int itemCount) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Order',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You have $itemCount items in your cart',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(BuildContext context, CartProvider cartProvider) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: cartProvider.items.length,
      itemBuilder: (context, index) {
        final item = cartProvider.items[index];
        return Dismissible(
          key: Key(item.coffee.name),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            cartProvider.removeFromCart(item);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFCE9760),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Image.asset(
                  item.coffee.image,
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.coffee.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'With ${item.additionalNote ?? "Milk"}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '\$${item.coffee.price}',
                        style: const TextStyle(
                          color: Color(0xFF543A20),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _buildQuantityButton(
                      Icons.remove,
                      () {
                        if (item.quantity > 1) {
                          cartProvider.updateQuantity(item, item.quantity - 1);
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildQuantityButton(
                      Icons.add,
                      () => cartProvider.updateQuantity(item, item.quantity + 1),
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
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF543A20),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  Widget _buildCouponCode() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter Coupon Code here',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFFCE9760).withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF543A20),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(CartProvider cartProvider) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildSummaryRow('Sub-total', '\$${cartProvider.subtotal}'),
          const SizedBox(height: 10),
          _buildSummaryRow('Shipping', '\$${cartProvider.shipping}'),
          const SizedBox(height: 10),
          _buildSummaryRow('Total', '\$${cartProvider.total}'),
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
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFinalizeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFCE9760),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text(
            'Finalize Order',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildBottomNavBar() {
  //   return Container(
  //     height: 60,
  //     decoration: BoxDecoration(
  //       color: const Color(0xFFCE9760),
  //       borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         IconButton(
  //           icon: const Icon(Icons.home_outlined, color: Colors.white),
  //           onPressed: () {},
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.shopping_cart, color: Color(0xFF543A20)),
  //           onPressed: () {},
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.favorite_border, color: Colors.white),
  //           onPressed: () {},
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.person_outline, color: Colors.white),
  //           onPressed: () {},
  //         ),
  //       ],
  //     ),
  //   );
  // }
}