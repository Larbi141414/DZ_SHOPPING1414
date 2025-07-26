import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('عربة التسوق'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('سلة المشتريات فارغة'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return ListTile(
                        leading: Image.network(product.image, width: 50),
                        title: Text(product.name),
                        subtitle: Text('${product.price} دج'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            cartProvider.removeFromCart(product);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'المجموع: ${cartProvider.totalPrice.toStringAsFixed(2)} دج',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: 'إتمام الطلب',
                        onPressed: () {
                          // تنفيذ عملية الشراء أو الانتقال إلى شاشة الدفع
                          // يمكنك تعديل هذا حسب منطق التطبيق
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('سيتم تنفيذ الطلب قريبًا'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
