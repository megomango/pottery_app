class Product {
  final String id;
  final String name;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  // ✅ لتحويل الكائن إلى JSON (عند الحفظ)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
    };
  }

  // ✅ لتحويل JSON إلى كائن (عند الاسترجاع)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '', // لو id مش موجود
      name: json['name'] ?? 'اسم غير معروف',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] ?? 'assets/images/placeholder.jpg', // تأكد إن الصورة موجودة
    );
  }


  // ✅ المقارنة بناءً على id فقط (أفضل أداء وأمان)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}
