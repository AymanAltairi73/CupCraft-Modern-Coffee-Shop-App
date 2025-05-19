import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final favoriteCoffees =
        widget.coffeeList.where((coffee) => coffee.isFavorite).toList();
    return Scaffold(
      backgroundColor: const Color(0xFF543A20),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildSearchBar(),
            Expanded(
              child:
                  favoriteCoffees.isEmpty
                      ? _buildEmptyState()
                      : _buildFavoritesList(favoriteCoffees),
            ),
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
      padding: EdgeInsets.all(20.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 44.r,
              height: 44.r,
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.r),
            ),
          ),
          Text(
            'Favorite',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/notification');
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 44.r,
              height: 44.r,
              alignment: Alignment.center,
              child: Icon(Icons.notifications_none, color: Colors.white, size: 24.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: TextField(
          controller: _searchController,
          style: TextStyle(fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: 'Search Your Favorite Product',
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
            suffixIcon: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCE9760),
                padding: EdgeInsets.all(12.r),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),
                minimumSize: Size(50.w, 50.h),
              ),
              child: Icon(
                Icons.search_sharp,
                color: const Color(0xFF543A20),
                size: 30.r,
              ),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 13.h,
            ),
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
            size: 64.r,
            color: Colors.white.withAlpha(128), // 0.5 * 255 = 128
          ),
          SizedBox(height: 16.h),
          Text(
            'No favorites yet',
            style: TextStyle(
              color: Colors.white.withAlpha(128), // 0.5 * 255 = 128
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(List<Coffee> favorites) {
    return GridView.builder(
      padding: EdgeInsets.all(20.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
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
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(15.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(coffee.image, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      coffee.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${coffee.price}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  'Lorem ipsum dolor sit\namet cons',
                  style: TextStyle(
                    color: Colors.white.withAlpha(179), // 0.7 * 255 = 179
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10.r,
            right: 10.r,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  coffee.isFavorite = !coffee.isFavorite;
                });
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 44.r,
                height: 44.r,
                alignment: Alignment.center,
                child: Icon(Icons.favorite, color: Colors.red, size: 24.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
