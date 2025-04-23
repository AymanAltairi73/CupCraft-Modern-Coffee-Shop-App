import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/CartItem.dart';
import '../model/Coffee.dart';
import '../provider/cart_provider.dart';

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
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.coffee.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              widget.coffee.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(
                widget.coffee.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  widget.coffee.isFavorite = !widget.coffee.isFavorite;
                  widget.onFavoriteChanged(widget.coffee);
                });
              },
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
          decoration: const BoxDecoration(
            color: Color(0xFF543A20),
            borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIngredients(),
                  const SizedBox(height: 30),
                  _buildCoffeeSize(),
                  const SizedBox(height: 30),
                  _buildQuantitySelector(),
                  const SizedBox(height: 30),
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
          child: const Text(
            'Ingredients',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/arrow2.png',
          // width: 10,
          // height: 19,
          //color: const Color(0xFFCE9760),
        ),
        Center(
          child: const Text(
            'Milk',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Center(
        //   child: Container(
        //    /// padding: const EdgeInsets.all(15),
        //     decoration: BoxDecoration(
        //       color: const Color(0xFFCE9760),
        //       //borderRadius: BorderRadius.circular(50),
        //     ),
        //     //child:
        //   ),
        // ),
      ],
    );
  }

  Widget _buildCoffeeSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: const Text(
            'Coffee Size',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              ['Small', 'Medium', 'Large'].map((size) {
                final isSelected = _selectedSize == size;
                return GestureDetector(
                  onTap: () => setState(() => _selectedSize = size),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? const Color(0xFFCE9760)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFFCE9760),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.coffee,
                      color:
                          isSelected ? Colors.white : const Color(0xFFCE9760),
                      size:
                          size == 'Small'
                              ? 30
                              : size == 'Medium'
                              ? 50
                              : 70,
                    ),
                  ),
                );
              }).toList(),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              ['Small', 'Medium', 'Large'].map((size) {
                final isSelected = _selectedSize == size;
                return GestureDetector(
                  onTap: () => setState(() => _selectedSize = size),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      //color: isSelected ?  Colors.white : Colors.transparent,
                      //borderRadius: BorderRadius.circular(15),
                      // border: Border.all(
                      //   color: const Color(0xFFCE9760),
                      //   width: 2,
                      // ),
                    ),
                    child: Text(
                      size == 'Small'
                          ? 'Small'
                          : size == 'Medium'
                          ? 'Medium'
                          : 'Large',
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : const Color(0xFFCE9760),
                        fontSize: 16,
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            _quantity.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
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
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFCE9760),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

   Widget _buildAddToCartButton() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
            final cartItem = CartItem(
                coffee: widget.coffee,
                quantity: _quantity,
                additionalNote: _selectedSize,
              );
                Provider.of<CartProvider>(context, listen: false).addToCart(cartItem);
              // Add to cart logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to cart successfully!'),
                  backgroundColor: Color(0xFFCE9760),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCE9760),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'Add to cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: const Color(0xFFCE9760),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              '\$${(widget.coffee.price * _quantity).toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFCE9760),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

}


