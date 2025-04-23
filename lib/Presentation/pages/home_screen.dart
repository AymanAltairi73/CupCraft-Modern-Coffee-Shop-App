import 'package:flutter/material.dart';

import 'coffee_details_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../../core/utility/navigation_helper.dart';
import '../../data/model/Coffee.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;
  List<Coffee> coffeeList = [
    Coffee(
      name: 'Arabica',
      price: 18,
      image: 'assets/images/arabica.png',
      description: 'Lorem ipsum dolor sit amet cons',
    ),
    Coffee(
      name: 'Robusta',
      price: 20,
      image: 'assets/images/robusta.png',
      description: 'Lorem ipsum dolor sit amet cons',
    ),
    Coffee(
      name: 'Excelsa',
      price: 15,
      image: 'assets/images/excelsa.png',
      description: 'Lorem ipsum dolor sit amet cons',
    ),
    Coffee(
      name: 'Liberica',
      price: 12,
      image: 'assets/images/liberica.png',
      description: 'Lorem ipsum dolor sit amet cons',
    ),
  ];
  final List<String> _categories = [
    'Hot Coffees',
    'Ice Teas',
    'Hot Teas',
    'Drinks',
    'Bakery',
  ];

  int _selectedCategory = 0;

  void updateFavoriteStatus(Coffee coffee) {
    setState(() {
      coffee.isFavorite = !coffee.isFavorite;
    });
  }

  void updateCartStatus(Coffee coffee, {bool? isSelected, int? quantity}) {
    setState(() {
      if (isSelected != null) coffee.isSelected = isSelected;
      if (quantity != null) coffee.quantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF543A20),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildPromoBanner(),
            _buildCategories(),

            Expanded(child: _buildCoffeeGrid()),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          NavigationHelper.navigateToPage(
            context,
            index,
            coffeeList: coffeeList,
            onFavoriteChanged: updateFavoriteStatus,
            onCartChanged: updateCartStatus,
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Ayman Altairi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Good Morning!',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 165, 111, 79),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Get 20% Discount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'On your First Order!',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 5),
                Text(
                  'Lorem ipsum dolor sit amet consectetur.\nVestibulum eget blandit mattis',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Image.asset('assets/images/coffee_promo.png', width: 100),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = index),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color:
                    _selectedCategory == index
                        ? const Color(0xFFCE9760)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFCE9760), width: 1),
              ),
              child: Text(
                _categories[index],
                style: TextStyle(
                  color:
                      _selectedCategory == index
                          ? Colors.white
                          : const Color(0xFFCE9760),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoffeeGrid() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: coffeeList.length,
        itemBuilder: (context, index) {
          final coffee = coffeeList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => CoffeeDetailsScreen(
                        coffee: coffee,
                        onFavoriteChanged: (updatedCoffee) {
                          setState(() {
                            final index = coffeeList.indexWhere(
                              (c) => c.name == updatedCoffee.name,
                            );
                            if (index != -1) {
                              coffeeList[index].isFavorite =
                                  updatedCoffee.isFavorite;
                            }
                          });
                        },
                        onCartChanged: updateCartStatus,
                      ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFCE9760),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            coffee.image,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        //const SizedBox(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              coffee.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${coffee.price}',
                              style: const TextStyle(
                                color: Color(0xFF543A20),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          coffee.description,
                          style: TextStyle(
                            color: Color(0xFF543A20),
                            fontSize: 13,
                          ),
                        ),

                        //const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          coffee.isFavorite = !coffee.isFavorite;
                        });
                      },
                      child: Icon(
                        coffee.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
