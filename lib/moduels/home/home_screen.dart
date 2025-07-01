import 'package:flutter/material.dart';
import 'package:pottery/moduels/cart_screen/cart_screen.dart';
import 'package:pottery/moduels/product_details/product_details.dart';

import '../../models/product_model/product_model.dart';
import '../../models/product_data/product_data.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> cart;
  final List<Product> favorite;
  final Function(Product, bool) onCartUpdate;
  final Function(Product, bool) onFavoriteUpdate;

  const HomeScreen({
    super.key,
    required this.cart,
    required this.favorite,
    required this.onCartUpdate,
    required this.onFavoriteUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('منتجات الفخار')),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.separated(
        itemCount: potteryProducts.length,
        separatorBuilder: (context, index) => const Divider(height: 10),
        itemBuilder: (context, index) {
          final product = potteryProducts[index];
          final isInFavorite = favorite.contains(product);
          cart.contains(product);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // 🏺 الصورة
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetails(
                              product: product,
                              isInCart: cart.contains(product),
                              isInFavorite: favorite.contains(product),
                              onCartUpdate: onCartUpdate,
                              onFavoriteUpdate: onFavoriteUpdate,
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        product.image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // 📛 الاسم والسعر
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'السعر: ${product.price.toStringAsFixed(2)} جنيه',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  // 🛒❤️ التحكم في السلة والمفضلة
                  Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CartScreen(cartItems: cart),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.all(10),
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(Icons.add_shopping_cart, size: 18),
                          ),
                          IconButton(
                            onPressed: () {
                              onFavoriteUpdate(product, !isInFavorite);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(isInFavorite
                                      ? '${product.name} تم حذفه من المفضلة'
                                      : '${product.name} تم إضافته للمفضلة'),
                                ),
                              );
                            },
                            icon: Icon(
                              isInFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isInFavorite ? Colors.red : null,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              onCartUpdate(product, true);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${product.name} تمت إضافته للسلة')),
                              );
                            },
                            icon: const Icon(Icons.add, size: 18),
                          ),
                          IconButton(
                            onPressed: () {
                              onCartUpdate(product, false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${product.name} تم حذفه من السلة')),
                              );
                            },
                            icon: const Icon(Icons.remove, size: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
