class ProductModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final num price;
  final String category;
  final bool isAliExpress;
  final String? aliExpressLink;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    required this.isAliExpress,
    this.aliExpressLink,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ProductModel(
      id: documentId,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      price: map['price'] ?? 0,
      category: map['category'] ?? '',
      isAliExpress: map['isAliExpress'] ?? false,
      aliExpressLink: map['aliExpressLink'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'category': category,
      'isAliExpress': isAliExpress,
      'aliExpressLink': aliExpressLink,
    };
  }
}