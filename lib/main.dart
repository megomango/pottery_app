import 'package:flutter/foundation.dart';
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
  final ThemeService themeService = ThemeService();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final loadedCart = await storage.loadCart();
      final loadedFav = await storage.loadFavorites();
      final loadedTheme = await themeService.loadTheme();

      if (!mounted) return;
      setState(() {
        cart = loadedCart;
        favorite = loadedFav;
        isDarkMode = loadedTheme;
      });
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Error loading data: $e');
      }
    }
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    themeService.saveTheme(isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
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
        onStart: () async {
          if (kDebugMode) {
            print('✅ الزر اشتغل');
          }
          await Future.delayed(const Duration(milliseconds: 300));
          if (!mounted) return;
          setState(() {
            started = true;
          });
        },
      ),
    );
  }
}
