import 'package:flutter/material.dart';
import '../../data/model/Coffee.dart';
import '../../core/utility/navigation_helper.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class FavoriteScreen extends StatefulWidget {
   final List<Coffee> coffeeList;
  final Function(Coffee) onFavoriteChanged;

  const FavoriteScreen({
    super.key,
    required this.coffeeList,
    required this.onFavoriteChanged,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final int _selectedIndex = 2;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
 final favoriteCoffees = widget.coffeeList.where((coffee) => coffee.isFavorite).toList();
    return Scaffold(
      backgroundColor: const Color(0xFF543A20),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildSearchBar(),
            Expanded(
              child: favoriteCoffees.isEmpty
                  ? _buildEmptyState()
                  : _buildFavoritesList(favoriteCoffees),
            ),
            // CustomBottomNavBar(
            //   selectedIndex: _selectedIndex,
            //   onItemSelected: (index) {
            //     if (index != _selectedIndex) {
            //       setState(() {});
            //     }
            //   },
            // ),
          ],
        ),
      ),
        bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          NavigationHelper.navigateToPage(
            context,
            index,
            coffeeList: widget.coffeeList,
            onFavoriteChanged: widget.onFavoriteChanged,
          );
        },
      ),
      
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          const Text(
            'Favorite',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/notification');
            },
            child: const Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Your Favorite Product',
            hintStyle: TextStyle(color: Colors.grey[600]),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF543A20)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: Colors.white.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No favorites yet',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(List<Coffee> favorites) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final coffee = favorites[index];
        return _buildFavoriteItem(coffee);
      },
    );
  }

  Widget _buildFavoriteItem(Coffee coffee) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFCE9760),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      coffee.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'Lorem ipsum dolor sit\namet cons',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
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
              child: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}