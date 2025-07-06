import 'package:flutter/material.dart';
import 'package:pottery/moduels/cart_screen/cart_screen.dart';
import 'package:pottery/moduels/favoirte_screen/favorite_screen.dart';
import 'package:pottery/moduels/home/home_screen.dart';

import '../../models/product_model/product_model.dart';
import '../moduels/contact_us/contact_us.dart';

class MainLayout extends StatefulWidget {
  final List<Product> cart;
  final List<Product> favorite;
  final Function(List<Product>) onCartUpdated;
  final Function(List<Product>) onFavoriteUpdated;
  final VoidCallback onToggleTheme;
  const MainLayout({
    super.key,
    required this.cart,
    required this.favorite,
    required this.onCartUpdated,
    required this.onFavoriteUpdated,
    required this.onToggleTheme,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  late List<Product> cart;
  late List<Product> favorite;

  @override
  void initState() {
    super.initState();
    cart = widget.cart;
    favorite = widget.favorite;
  }

  void updateCart(Product product, bool add) {
    setState(() {
      if (add) {
        if (!cart.contains(product)) {
          cart.add(product);
        }
      } else {
        cart.removeWhere((p) => p == product);
      }
    });
    widget.onCartUpdated(cart);
  }

  void updateFavorite(Product product, bool add) {
    setState(() {
      if (add) {
        if (!favorite.contains(product)) {
          favorite.add(product);
        }
      } else {
        favorite.removeWhere((p) => p == product);
      }
    });
    widget.onFavoriteUpdated(favorite);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        cart: cart,
        favorite: favorite,
        onCartUpdate: updateCart,
        onFavoriteUpdate: updateFavorite,
      ),
      CartScreen(cartItems: cart),
      FavoriteScreen(favoriteItems: favorite),
      ContactScreen(),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: pages[currentIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onToggleTheme,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[800]
            : Colors.brown,
        child: const Icon(Icons.brightness_6),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'السلة',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'تواصل معنا'),
        ],
      ),
    );
  }
}
