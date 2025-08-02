import 'product.dart';

class ProductModel {
  static List<Product> products = [
    Product(
      id: '1',
      name: 'Smart Watch',
      imageUrl: 'https://ae01.alicdn.com/kf/Sc1.jpg',
      price: 3500, // السعر الذي تضعه أنت
      originalUrl: 'https://www.aliexpress.com/item/123456.html',
      originalPrice: 20, // بالدولار مثلا
    ),
    Product(
      id: '2',
      name: 'Wireless Earbuds',
      imageUrl: 'https://ae01.alicdn.com/kf/S2.jpg',
      price: 2500,
      originalUrl: 'https://www.aliexpress.com/item/987654.html',
      originalPrice: 15,
    ),
  ];
}
