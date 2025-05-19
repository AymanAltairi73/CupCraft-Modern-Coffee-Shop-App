import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../data/model/CartItem.dart';
import '../../data/model/Coffee.dart';
import '../../core/provider/cart_provider.dart';

class CoffeeDetailsScreen extends StatefulWidget {
  final Coffee coffee;
  final Function(Coffee) onFavoriteChanged;
  final Function(Coffee, {bool? isSelected, int? quantity}) onCartChanged;

  const CoffeeDetailsScreen({
    super.key,
    required this.coffee,
    required this.onFavoriteChanged,
    required this.onCartChanged,
  });

  @override
  State<CoffeeDetailsScreen> createState() => _CoffeeDetailsScreenState();
}

class _CoffeeDetailsScreenState extends State<CoffeeDetailsScreen> {
  int _quantity = 1;
  String _selectedSize = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Stack(
        children: [
          // Background Image
          _buildBackgroundImage(),
          // Content
          _buildContent(),
          // App Bar
          _buildCustomAppBar(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      height: 0.5.sh, // 50% of screen height using ScreenUtil
      width: 1.sw, // 100% of screen width using ScreenUtil
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.coffee.image),
          fit: BoxFit.none,
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.r),
              onPressed: () => Navigator.pop(context),
              iconSize: 24.r,
              padding: EdgeInsets.all(8.r),
              constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
            ),
            Text(
              widget.coffee.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(
                widget.coffee.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: widget.coffee.isFavorite ? Colors.red : Colors.white,
                size: 24.r,
              ),
              onPressed: () {
                setState(() {
                  widget.coffee.isFavorite = !widget.coffee.isFavorite;
                  widget.onFavoriteChanged(widget.coffee);
                });
              },
              iconSize: 24.r,
              padding: EdgeInsets.all(8.r),
              constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF543A20),
            borderRadius: BorderRadius.vertical(
              top: Radius.elliptical(1.sw, 70.h),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIngredients(),
                  SizedBox(height: 30.h),
                  _buildCoffeeSize(),
                  SizedBox(height: 30.h),
                  _buildQuantitySelector(),
                  SizedBox(height: 30.h),
                  _buildAddToCartButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Ingredients',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Image.asset(
          'assets/images/arrow2.png',
          width: 0.5.sw, // 50% of screen width
          fit: BoxFit.fitWidth,
        ),
        Center(
          child: Text(
            'Milk',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCoffeeSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Coffee Size',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Small', 'Medium', 'Large'].map((size) {
            final isSelected = _selectedSize == size;
            return GestureDetector(
              onTap: () => setState(() => _selectedSize = size),
              child: Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFCE9760),
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: const Color(0xFFCE9760),
                    width: 5.r,
                  ),
                ),
                child: Image.asset(
                  size == 'Small'
                      ? 'assets/images/small.png'
                      : size == 'Medium'
                          ? 'assets/images/meduim.png'
                          : 'assets/images/large.png',
                  color: isSelected ? Colors.white : const Color(0xFF543A20),
                  height: size == 'Small'
                      ? 30.h
                      : size == 'Medium'
                          ? 50.h
                          : 70.h,
                ),
              ),
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Small', 'Medium', 'Large'].map((size) {
            final isSelected = _selectedSize == size;
            return GestureDetector(
              onTap: () => setState(() => _selectedSize = size),
              child: Container(
                padding: EdgeInsets.all(20.r),
                decoration: const BoxDecoration(),
                child: Text(
                  size == 'Small'
                      ? 'Small'
                      : size == 'Medium'
                          ? 'Medium'
                          : 'Large',
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFFCE9760),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildQuantityButton(Icons.remove, () {
          if (_quantity > 1) setState(() => _quantity--);
        }),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            _quantity.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildQuantityButton(Icons.add, () {
          setState(() => _quantity++);
        }),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: const Color(0xFFCE9760),
          borderRadius: BorderRadius.circular(8.r),
        ),
        constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
        child: Icon(icon, color: const Color(0xFF543A20), size: 24.r),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Text(
              '\$${(widget.coffee.price * _quantity).toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          flex: 4,
          child: ElevatedButton(
            onPressed: () {
              final cartItem = CartItem(
                coffee: widget.coffee,
                quantity: _quantity,
                additionalNote: _selectedSize,
              );
              Provider.of<CartProvider>(
                context,
                listen: false,
              ).addToCart(cartItem);
              // Add to cart logic here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                    child: Text(
                      'Added to cart successfully!',
                      style: TextStyle(
                        color: const Color(0xFF543A20),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  backgroundColor: const Color(0xFFCE9760),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCE9760),
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              minimumSize: Size(double.infinity, 50.h),
            ),
            child: Text(
              'Add to cart',
              style: TextStyle(
                color: const Color(0xFF543A20),
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
