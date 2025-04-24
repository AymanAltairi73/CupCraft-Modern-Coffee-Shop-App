class Coffee {
  final String name;
  final double price;
  final String image;
  final String description;
  bool isSelected;
  int quantity;
  bool isFavorite;

  Coffee({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    this.isSelected = false,
    this.quantity = 1,
    this.isFavorite = false,
  });
}

// تعريف قائمة القهوة كمتغير عام
// List<Coffee> coffeeList = [
//   Coffee(
//     name: 'Arabica',
//     price: 18,
//     image: 'assets/images/arabica.png',
//     description: 'Lorem ipsum dolor sit amet cons',
//   ),
//   Coffee(
//     name: 'Robusta',
//     price: 20,
//     image: 'assets/images/robusta.png',
//     description: 'Lorem ipsum dolor sit amet cons',
//   ),
//   Coffee(
//     name: 'Excelsa',
//     price: 15,
//     image: 'assets/images/excelsa.png',
//     description: 'Lorem ipsum dolor sit amet cons',
//   ),
//   Coffee(
//     name: 'Liberica',
//     price: 12,
//     image: 'assets/images/liberica.png',
//     description: 'Lorem ipsum dolor sit amet cons',
//   ),
// ];

// // تعريف قائمة التصنيفات كمتغير عام
// final List<String> categories = [
//   'Hot Coffees',
//   'Ice Teas',
//   'Hot Teas',
//   'Drinks',
//   'Bakery',
// ];