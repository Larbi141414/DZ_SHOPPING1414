import '../models/product_model.dart';

class ProductService {
  static Future<List<Product>> getAllProducts() async {
    // لاحقاً سيتم جلبها من Firebase
    return [
      Product(id: '1', name: 'Example', price: 10.0, imageUrl: 'https://via.placeholder.com/150'),
    ];
  }
}
