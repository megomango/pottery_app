import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../models/product_model/product_model.dart';

class FavoriteScreen extends StatefulWidget {
  final List<Product> favoriteItems;

  const FavoriteScreen({super.key, required this.favoriteItems});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late List<Product> favorites;

  @override
  void initState() {
    super.initState();
    favorites = List.from(widget.favoriteItems); // ننسخ القائمة لنتعامل عليها
  }

  void removeFromFavorites(Product product) {
    setState(() {
      favorites.remove(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} تم حذفه من المفضلة'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('المفضلة')),
        backgroundColor: Colors.blueAccent,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: favorites.isEmpty
            ? const Center(
          key: ValueKey('empty'),
          child: Text(
            '💔 لا توجد منتجات مفضلة حالياً',
            style: TextStyle(fontSize: 18),
          ),
        )
            : AnimationLimiter(
          key: const ValueKey('list'),
          child: ListView.separated(
            itemCount: favorites.length,
            separatorBuilder: (context, index) =>
            const Divider(height: 10),
            itemBuilder: (context, index) {
              final product = favorites[index];

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 400),
                child: SlideAnimation(
                  verticalOffset: 40.0,
                  child: FadeInAnimation(
                    child: Dismissible(
                      key: ValueKey(product.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerRight,
                        color: Colors.redAccent,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => removeFromFavorites(product),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(product.image,
                                width: 60, height: 60, fit: BoxFit.cover),
                          ),
                          title: Text(product.name),
                          subtitle: Text(
                              '${product.price.toStringAsFixed(2)} جنيه'),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
