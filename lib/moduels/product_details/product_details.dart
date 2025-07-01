import 'package:flutter/material.dart';
import '../../models/product_model/product_model.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  final bool isInCart;
  final bool isInFavorite;
  final Function(Product, bool) onCartUpdate;
  final Function(Product, bool) onFavoriteUpdate;

  const ProductDetails({
    super.key,
    required this.product,
    required this.isInCart,
    required this.isInFavorite,
    required this.onCartUpdate,
    required this.onFavoriteUpdate,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late bool addedToCart;
  late bool addToFav;

  @override
  void initState() {
    super.initState();
    addedToCart = widget.isInCart;
    addToFav = widget.isInFavorite;
  }

  void toggleCart(Product product) {
    setState(() {
      addedToCart = !addedToCart;
    });
    widget.onCartUpdate(product, addedToCart);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          addedToCart
              ? '${product.name} تم إضافته إلى السلة'
              : '${product.name} تم حذفه من السلة',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void toggleFavorite(Product product) {
    setState(() {
      addToFav = !addToFav;
    });
    widget.onFavoriteUpdate(product, addToFav);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          addToFav
              ? '${product.name} تم إضافته إلى المفضلة'
              : '${product.name} تم حذفه من المفضلة',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(product.image, height: 250, fit: BoxFit.cover),
            ),
            const SizedBox(height: 24),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'السعر: ${product.price.toStringAsFixed(2)} جنيه',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // زر السلة
            ElevatedButton.icon(
              onPressed: () => toggleCart(product),
              icon: Icon(
                addedToCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart,
              ),
              label: Text(addedToCart ? 'إزالة من السلة' : 'إضافة إلى السلة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: addedToCart ? Colors.redAccent : Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),

            // زر المفضلة
            ElevatedButton.icon(
              onPressed: () => toggleFavorite(product),
              icon: Icon(
                addToFav ? Icons.favorite : Icons.favorite_border,
              ),
              label: Text(addToFav ? 'إزالة من المفضلة' : 'إضافة إلى المفضلة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: addToFav ? Colors.redAccent : Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
