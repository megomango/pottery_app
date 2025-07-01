class Product {
  final String name;
  final double price;
  final String image;

  Product({
    required this.name,
    required this.price,
    required this.image,
  });

  // ✅ لتحويل الكائن إلى JSON (عند الحفظ)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'image': image,
    };
  }

  // ✅ لتحويل JSON إلى كائن (عند الاسترجاع)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: (json['price'] as num).toDouble(), // تأكد من النوع double
      image: json['image'],
    );
  }

  // ✅ لازم تعريف == و hashCode علشان نقدر نقارن بين المنتجات
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              price == other.price &&
              image == other.image;

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ image.hashCode;
}
