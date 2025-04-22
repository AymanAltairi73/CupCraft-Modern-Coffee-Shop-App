class Coffee {
  final String name;
  final String image;
  final double price;
  final String description;
  bool isFavorite;
  bool isSelected;  // للسلة
  int quantity;     // للكمية في السلة

  Coffee({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    this.isFavorite = false,
    this.isSelected = false,
    this.quantity = 1,
  });
}
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