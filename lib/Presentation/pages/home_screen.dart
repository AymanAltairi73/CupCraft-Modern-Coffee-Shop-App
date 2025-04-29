import 'package:flutter/material.dart';
import 'dart:math'; // Import dart:math for min function

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
  // This is your master list of all available coffees
  final List<Coffee> _allCoffees = [
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
     // Add more coffee items if needed for testing different counts
    Coffee(
      name: 'Espresso',
      price: 10,
      image: 'assets/images/arabica.png', // Replace with actual image if available
      description: 'Strong and concentrated',
    ),
  ];

  // This list will hold the coffees currently displayed based on the category
  List<Coffee> _displayedCoffeeList = [];

  final List<String> _categories = [
    'Hot Coffees', // Index 0
    'Ice Teas',    // Index 1
    'Hot Teas',    // Index 2
    'Drinks',      // Index 3
    'Bakery',      // Index 4
  ];

  int _selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the displayed list when the screen loads
    _updateDisplayedCoffees();
  }

  // Function to update the displayed coffee list based on the selected category
  void _updateDisplayedCoffees() {
    setState(() {
      switch (_selectedCategory) {
        case 0: // Hot Coffees - Show all
          _displayedCoffeeList = List.from(_allCoffees); // Create a copy
          break;
        case 1: // Ice Teas - Show first 3 (or fewer if not enough)
          _displayedCoffeeList = _allCoffees.take(min(3, _allCoffees.length)).toList();
          break;
        case 2: // Hot Teas - Show first 2 (or fewer if not enough)
          _displayedCoffeeList = _allCoffees.take(min(2, _allCoffees.length)).toList();
          break;
        case 3: // Drinks - Show first 1 (or fewer if not enough)
          _displayedCoffeeList = _allCoffees.take(min(1, _allCoffees.length)).toList();
          break;
        case 4: // Bakery - Show none from this list (or implement specific bakery logic later)
          _displayedCoffeeList = [];
          break;
        default: // Default case, show all
          _displayedCoffeeList = List.from(_allCoffees);
      }
    });
  }


  // This function updates the original _allCoffees list
  void updateFavoriteStatus(Coffee coffee) {
     final index = _allCoffees.indexWhere((c) => c.name == coffee.name);
     if (index != -1) {
       setState(() {
         _allCoffees[index].isFavorite = !_allCoffees[index].isFavorite;
         // No need to call _updateDisplayedCoffees here unless the filtering logic
         // depends on the favorite status itself. The GridView item will rebuild.
       });
     }
  }

  // This function updates the original _allCoffees list
  void updateCartStatus(Coffee coffee, {bool? isSelected, int? quantity}) {
    final index = _allCoffees.indexWhere((c) => c.name == coffee.name);
    if (index != -1) {
      setState(() {
        if (isSelected != null) _allCoffees[index].isSelected = isSelected;
        if (quantity != null) _allCoffees[index].quantity = quantity;
         // No need to call _updateDisplayedCoffees here.
      });
    }
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
            // Use the _displayedCoffeeList here
            Expanded(child: _buildCoffeeGrid(_displayedCoffeeList)),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          // Pass the original list for potential modifications in other screens
          NavigationHelper.navigateToPage(
            context,
            index,
            coffeeList: _allCoffees,
            onFavoriteChanged: updateFavoriteStatus,
            onCartChanged: updateCartStatus,
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    // ... (Keep your existing _buildHeader code)
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
         GestureDetector(
            onTap: () => NavigationHelper.navigateToPage(context, 3, replace: false),
            child: const CircleAvatar(
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
            icon: const Icon(Icons.search, color: Colors.white, size: 25),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Center(child: Text('Search coming soon!'))),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white, size: 25),
            onPressed: () => NavigationHelper.goToNotifications(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    // ... (Keep your existing _buildPromoBanner code)
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
            onTap: () {
              // Update the selected category AND update the displayed list
              setState(() => _selectedCategory = index);
              _updateDisplayedCoffees(); // Call the update function
            },
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

  // Modified to accept the list to display
  Widget _buildCoffeeGrid(List<Coffee> coffeesToDisplay) {
    // Handle empty list case
    if (coffeesToDisplay.isEmpty) {
      return const Center(
        child: Text(
          'No items available in this category.',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }
    // Removed the Expanded widget from here, it's now wrapping the call in build()
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), // Added bottom padding
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8, // Adjust as needed
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      // Use the length of the passed list
      itemCount: coffeesToDisplay.length,
      itemBuilder: (context, index) {
        // Get coffee from the passed list
        final coffee = coffeesToDisplay[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CoffeeDetailsScreen(
                  coffee: coffee, // Pass the specific coffee
                  onFavoriteChanged: (updatedCoffee) {
                    // Find the coffee in the *original* list and update it
                    final originalIndex = _allCoffees.indexWhere(
                      (c) => c.name == updatedCoffee.name,
                    );
                    if (originalIndex != -1) {
                      setState(() {
                        _allCoffees[originalIndex].isFavorite =
                            updatedCoffee.isFavorite;
                        // Optional: If the displayed list should immediately reflect
                        // this change (e.g., if filtering by favorites), call:
                        // _updateDisplayedCoffees();
                      });
                    }
                  },
                  // Pass the updateCartStatus function which modifies the original list
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
                      Expanded( // Use Expanded to allow image to take available space
                        child: Center(
                          child: Image.asset(
                            coffee.image,
                            // height: 100, // Let Expanded handle height
                            // width: 100, // Let Expanded handle width
                            fit: BoxFit.contain, // Use contain to avoid distortion
                          ),
                        ),
                      ),
                      const SizedBox(height: 5), // Add some space
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible( // Wrap text to prevent overflow
                            child: Text(
                              coffee.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis, // Handle long names
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
                         maxLines: 1, // Limit description lines
                         overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      // Call the state management function to update the original list
                      updateFavoriteStatus(coffee);
                    },
                    child: Icon(
                      coffee.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: coffee.isFavorite ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';

// import 'coffee_details_screen.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
// import '../../core/utility/navigation_helper.dart';
// import '../../data/model/Coffee.dart';


// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final int _selectedIndex = 0;
//   List<Coffee> coffeeList = [
//     Coffee(
//       name: 'Arabica',
//       price: 18,
//       image: 'assets/images/arabica.png',
//       description: 'Lorem ipsum dolor sit amet cons',
//     ),
//     Coffee(
//       name: 'Robusta',
//       price: 20,
//       image: 'assets/images/robusta.png',
//       description: 'Lorem ipsum dolor sit amet cons',
//     ),
//     Coffee(
//       name: 'Excelsa',
//       price: 15,
//       image: 'assets/images/excelsa.png',
//       description: 'Lorem ipsum dolor sit amet cons',
//     ),
//     Coffee(
//       name: 'Liberica',
//       price: 12,
//       image: 'assets/images/liberica.png',
//       description: 'Lorem ipsum dolor sit amet cons',
//     ),
//   ];
//   final List<String> _categories = [
//     'Hot Coffees',
//     'Ice Teas',
//     'Hot Teas',
//     'Drinks',
//     'Bakery',
//   ];

//   int _selectedCategory = 0;
//   void updateFavoriteStatus(Coffee coffee) {
//     setState(() {
//       coffee.isFavorite = !coffee.isFavorite;
//     });
//   }

//   void updateCartStatus(Coffee coffee, {bool? isSelected, int? quantity}) {
//     setState(() {
//       if (isSelected != null) coffee.isSelected = isSelected;
//       if (quantity != null) coffee.quantity = quantity;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF543A20),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             _buildPromoBanner(),
//             _buildCategories(),

//             Expanded(child: _buildCoffeeGrid()),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemSelected: (index) {
//           NavigationHelper.navigateToPage(
//             context,
//             index,
//             coffeeList: coffeeList,
//             onFavoriteChanged: updateFavoriteStatus,
//             onCartChanged: updateCartStatus,
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         children: [
//          GestureDetector(
//             onTap: () => NavigationHelper.navigateToPage(context, 3, replace: false),
//             child: const CircleAvatar(
//               radius: 25,
//               backgroundImage: AssetImage('assets/images/profile.png'),
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   'Ayman Altairi',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Good Morning!',
//                   style: TextStyle(color: Colors.white70, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.white, size: 25),
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Center(child: Text('Search coming soon!'))),
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications_none, color: Colors.white, size: 25),
//             onPressed: () => NavigationHelper.goToNotifications(context),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPromoBanner() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 165, 111, 79),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   'Get 20% Discount',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'On your First Order!',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'Lorem ipsum dolor sit amet consectetur.\nVestibulum eget blandit mattis',
//                   style: TextStyle(color: Colors.white70, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//           Image.asset('assets/images/coffee_promo.png', width: 100),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategories() {
//     return Container(
//       height: 50,
//       margin: const EdgeInsets.symmetric(vertical: 20),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: _categories.length,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () => setState(() => _selectedCategory = index),
//             child: Container(
//               alignment: Alignment.center,
//               margin: const EdgeInsets.only(right: 15),
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color:
//                     _selectedCategory == index
//                         ? const Color(0xFFCE9760)
//                         : Colors.transparent,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: const Color(0xFFCE9760), width: 1),
//               ),
//               child: Text(
//                 _categories[index],
//                 style: TextStyle(
//                   color:
//                       _selectedCategory == index
//                           ? Colors.white
//                           : const Color(0xFFCE9760),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCoffeeGrid() {
//     return Expanded(
//       child: GridView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.8,
//           crossAxisSpacing: 15,
//           mainAxisSpacing: 15,
//         ),
//         itemCount: coffeeList.length,
//         itemBuilder: (context, index) {
//           final coffee = coffeeList[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (context) => CoffeeDetailsScreen(
//                         coffee: coffee,
//                         onFavoriteChanged: (updatedCoffee) {
//                           setState(() {
//                             final index = coffeeList.indexWhere(
//                               (c) => c.name == updatedCoffee.name,
//                             );
//                             if (index != -1) {
//                               coffeeList[index].isFavorite =
//                                   updatedCoffee.isFavorite;
//                             }
//                           });
//                         },
//                         onCartChanged: updateCartStatus,
//                       ),
//                 ),
//               );
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFFCE9760),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(13),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Image.asset(
//                             coffee.image,
//                             height: 100,
//                             width: 100,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         //const SizedBox(height: 1),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               coffee.name,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               '\$${coffee.price}',
//                               style: const TextStyle(
//                                 color: Color(0xFF543A20),
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           coffee.description,
//                           style: TextStyle(
//                             color: Color(0xFF543A20),
//                             fontSize: 13,
//                           ),
//                         ),

//                         //const SizedBox(height: 10),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     right: 10,
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           coffee.isFavorite = !coffee.isFavorite;
//                         });
//                       },
//                       child: Icon(
//                         coffee.isFavorite
//                             ? Icons.favorite
//                             : Icons.favorite_border,
//                         color: coffee.isFavorite ? Colors.red : Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
