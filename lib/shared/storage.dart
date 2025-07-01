import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model/product_model.dart';

class StorageService {
  static const String cartKey = 'cart_items';
  static const String favKey = 'favorite_items';

  Future<void> saveCart(List<Product> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = jsonEncode(cart.map((e) => e.toJson()).toList());
    await prefs.setString(cartKey, cartJson);
  }

  Future<void> saveFavorites(List<Product> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final favJson = jsonEncode(favorites.map((e) => e.toJson()).toList());
    await prefs.setString(favKey, favJson);
  }

  Future<List<Product>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(cartKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => Product.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Product>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(favKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => Product.fromJson(e)).toList();
    }
    return [];
  }
}
