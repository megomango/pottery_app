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
            // 📷 صورة المنتج + Hero Animation
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: product.id, // تأكد من uniqueness
                child: Image.asset(
                  product.image,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // ✨ عناصر الصفحة بأنيميشن
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) => Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 50 * (1 - value)),
                  child: child,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'السعر: ${product.price.toStringAsFixed(2)} جنيه',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // 🛒 زر السلة
                  _buildAnimatedButton(
                    addedToCart,
                    onPressed: () => toggleCart(product),
                    labelTrue: 'إزالة من السلة',
                    labelFalse: 'إضافة إلى السلة',
                    iconTrue: Icons.remove_shopping_cart,
                    iconFalse: Icons.add_shopping_cart,
                  ),
                  const SizedBox(height: 10),

                  // ❤️ زر المفضلة
                  _buildAnimatedButton(
                    addToFav,
                    onPressed: () => toggleFavorite(product),
                    labelTrue: 'إزالة من المفضلة',
                    labelFalse: 'إضافة إلى المفضلة',
                    iconTrue: Icons.favorite,
                    iconFalse: Icons.favorite_border,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔘 زر متحرك مع Scale بسيط
  Widget _buildAnimatedButton(
      bool condition, {
        required VoidCallback onPressed,
        required String labelTrue,
        required String labelFalse,
        required IconData iconTrue,
        required IconData iconFalse,
      }) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: condition ? Colors.redAccent : Colors.orange,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              condition ? iconTrue : iconFalse,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              condition ? labelTrue : labelFalse,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
