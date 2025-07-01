import 'package:flutter/material.dart';
import '../../models/product_model/product_model.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Product> favoriteItems;

  const FavoriteScreen({super.key, required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('المفضلة')),
        backgroundColor: Colors.blueAccent,
      ),
      body: favoriteItems.isEmpty
          ? const Center(child: Text('💔 لا توجد منتجات مفضلة حالياً'))
          : ListView.separated(
        itemCount: favoriteItems.length,
        separatorBuilder: (context, index) => const Divider(height: 10),
        itemBuilder: (context, index) {
          final product = favoriteItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Image.asset(product.image, width: 60, height: 60),
              title: Text(product.name),
              subtitle: Text('${product.price.toStringAsFixed(2)} جنيه'),
            ),
          );
        },
      ),
    );
  }
}