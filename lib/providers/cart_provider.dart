import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';
import '../models/food_item.dart';
import '../services/firebase_auth_service.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];
  final FirebaseAuthService _authService = FirebaseAuthService();
  static const String _cartKeyPrefix = 'cart_items_';

  List<CartItem> get cartItems => _cartItems;

  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  // Get user-specific cart key
  String get _cartKey {
    final userId = _authService.userId;
    if (userId == null) {
      // If no user is logged in, use a guest key
      return '${_cartKeyPrefix}guest';
    }
    return '$_cartKeyPrefix$userId';
  }

  bool isInCart(String foodId) {
    return _cartItems.any((item) => item.foodItem.id == foodId);
  }

  int getQuantity(String foodId) {
    try {
      final cartItem =
          _cartItems.firstWhere((item) => item.foodItem.id == foodId);
      return cartItem.quantity;
    } catch (e) {
      return 0;
    }
  }

  // Load cart for the current user
  Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString(_cartKey);

      if (cartData != null) {
        final List<dynamic> cartJson = json.decode(cartData);
        _cartItems = cartJson.map((item) => CartItem.fromJson(item)).toList();
        notifyListeners();
      } else {
        // If no cart data exists for this user, start with empty cart
        _cartItems = [];
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading cart for user ${_authService.userId}: $e');
      _cartItems = [];
      notifyListeners();
    }
  }

  // Save cart for the current user
  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData =
          json.encode(_cartItems.map((item) => item.toJson()).toList());
      await prefs.setString(_cartKey, cartData);
    } catch (e) {
      debugPrint('Error saving cart for user ${_authService.userId}: $e');
    }
  }

  // Clear cart data for the current user (used when logging out)
  Future<void> clearUserCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cartKey);
      _cartItems = [];
      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing cart for user ${_authService.userId}: $e');
    }
  }

  // Switch user context (called when user logs in/out)
  Future<void> switchUser() async {
    // Save current cart before switching
    if (_cartItems.isNotEmpty) {
      await _saveCart();
    }

    // Load cart for the new user (or empty cart if logging out)
    await loadCart();
  }

  Future<void> addToCart(FoodItem foodItem) async {
    final existingIndex =
        _cartItems.indexWhere((item) => item.foodItem.id == foodItem.id);

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(foodItem: foodItem));
    }

    await _saveCart();
    notifyListeners();
  }

  Future<void> removeFromCart(String foodId) async {
    _cartItems.removeWhere((item) => item.foodItem.id == foodId);
    await _saveCart();
    notifyListeners();
  }

  Future<void> updateQuantity(String foodId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(foodId);
      return;
    }

    final existingIndex =
        _cartItems.indexWhere((item) => item.foodItem.id == foodId);

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity = quantity;
      await _saveCart();
      notifyListeners();
    }
  }

  Future<void> incrementQuantity(String foodId) async {
    final existingIndex =
        _cartItems.indexWhere((item) => item.foodItem.id == foodId);

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
      await _saveCart();
      notifyListeners();
    }
  }

  Future<void> decrementQuantity(String foodId) async {
    final existingIndex =
        _cartItems.indexWhere((item) => item.foodItem.id == foodId);

    if (existingIndex >= 0) {
      if (_cartItems[existingIndex].quantity > 1) {
        _cartItems[existingIndex].quantity--;
        await _saveCart();
        notifyListeners();
      } else {
        await removeFromCart(foodId);
      }
    }
  }

  Future<void> clearCart() async {
    _cartItems.clear();
    await _saveCart();
    notifyListeners();
  }

  // Debug method to see current user and cart key
  void debugCartInfo() {
    debugPrint('Current User ID: ${_authService.userId}');
    debugPrint('Cart Key: $_cartKey');
    debugPrint('Cart Items Count: ${_cartItems.length}');
  }
}
