import 'package:beauty_by_tima/Models/produit.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addToCart(Product product) {
    final existingIndex = _items.indexWhere((item) => item.id == product.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    product.quantity += 1;
    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    if (product.quantity > 1) {
      product.quantity -= 1;
    } else {
      removeFromCart(product);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
