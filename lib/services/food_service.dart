import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/food_item.dart';

class FoodService {
  static List<FoodItem> _foodItems = [];
  static bool _isLoaded = false;

  static Future<List<FoodItem>> loadFoodItems() async {
    if (_isLoaded) {
      return _foodItems;
    }

    try {
      final String response =
          await rootBundle.loadString('assets/data/foods.json');
      final Map<String, dynamic> data = json.decode(response);
      final List<dynamic> foodsJson = data['foods'];

      _foodItems = foodsJson.map((json) => FoodItem.fromJson(json)).toList();
      _isLoaded = true;

      return _foodItems;
    } catch (e) {
      throw Exception('Failed to load food items: $e');
    }
  }

  static List<FoodItem> getAllFoodItems() {
    return _foodItems;
  }

  static List<FoodItem> getFoodItemsByCategory(String category) {
    return _foodItems
        .where((item) => item.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  static List<FoodItem> getPopularItems() {
    return _foodItems.where((item) => item.isPopular).toList();
  }

  static FoodItem? getBestSellerItem() {
    try {
      return _foodItems.firstWhere((item) => item.isBestSeller);
    } catch (e) {
      return null;
    }
  }

  static FoodItem? getFoodItemById(String id) {
    try {
      return _foodItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<String> getCategories() {
    final categories = _foodItems.map((item) => item.category).toSet().toList();
    categories.sort();
    return categories;
  }
}
