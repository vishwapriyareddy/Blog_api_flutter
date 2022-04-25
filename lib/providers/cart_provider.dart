import 'package:blog_api/model/product.dart';
import 'package:blog_api/services/cart_service.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  late CartService _cartService;
  late int _itemQuantity = 0;
  int get getCartQuantity => _itemQuantity;
  set setCartQuantity(int quantity) {
    _itemQuantity = quantity;
    notifyListeners();
  }

  addToCart(Product product) async {
    _cartService = CartService();
    var result = await _cartService.addToCart(product);
    notifyListeners();
    return result;
  }

  cartItems() async {
    _cartService = CartService();
    var _cartItems = await _cartService.getCartItems();
    setCartQuantity = _cartItems.length;
    notifyListeners();
    return _cartItems;
  }
}
