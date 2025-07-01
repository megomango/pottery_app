import 'package:flutter/material.dart';
import 'layout/main_layout.dart';
import 'moduels/welcome_screen/welcome_screen.dart';
import 'models/product_model/product_model.dart';
import 'shared/storage.dart';
import 'shared/theme_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  bool started = false;
  List<Product> cart = [];
  List<Product> favorite = [];

  final StorageService storage = StorageService();
  final ThemeService themeService = ThemeService(); // ⬅️ هنا

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final loadedCart = await storage.loadCart();
    final loadedFav = await storage.loadFavorites();
    final loadedTheme = await themeService.loadTheme(); // ⬅️ حمل حالة الثيم

    setState(() {
      cart = loadedCart;
      favorite = loadedFav;
      isDarkMode = loadedTheme; // ⬅️ حط القيمة
    });
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    themeService.saveTheme(isDarkMode); // ⬅️ خزّن الحالة
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: started
          ? MainLayout(
        cart: cart,
        favorite: favorite,
        onCartUpdated: (updatedCart) {
          cart = updatedCart;
          storage.saveCart(updatedCart);
        },
        onFavoriteUpdated: (updatedFavorites) {
          favorite = updatedFavorites;
          storage.saveFavorites(updatedFavorites);
        },
        onToggleTheme: toggleTheme,
      )
          : WelcomeScreen(
        onStart: () {
          setState(() {
            started = true;
          });
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
