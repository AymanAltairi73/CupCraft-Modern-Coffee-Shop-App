import 'Coffee.dart';

class CartItem {
  final Coffee coffee;
  int quantity;
  String? additionalNote;

  CartItem({
    required this.coffee,
    this.quantity = 1,
    this.additionalNote,
  });

  double get total => coffee.price * quantity;
}