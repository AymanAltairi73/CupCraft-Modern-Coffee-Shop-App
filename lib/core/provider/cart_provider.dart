import 'package:flutter/foundation.dart';
import '../../data/model/CartItem.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get subtotal {
    return _items.fold(0, (sum, item) => sum + (item.coffee.price * item.quantity));
  }

  double get shipping => 6.0;

  double get total => subtotal + shipping;

  void addToCart(CartItem item) {
    // Check if the coffee is already in cart
    final existingIndex = _items.indexWhere(
      (cartItem) => cartItem.coffee.name == item.coffee.name && 
                    cartItem.additionalNote == item.additionalNote
    );

    if (existingIndex != -1) {
      // Update quantity if item exists
      _items[existingIndex].quantity += item.quantity;
    } else {
      // Add new item if it doesn't exist
      _items.add(item);
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateQuantity(CartItem item, int quantity) {
    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}