import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_product_screen.dart';

class ProductManagementScreen extends StatelessWidget {
  const ProductManagementScreen({super.key});

  Future<void> deleteProduct(String productId) async {
    await FirebaseFirestore.instance.collection('products').doc(productId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المنتجات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddProductScreen()),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data?.docs ?? [];

          if (products.isEmpty) {
            return const Center(child: Text('لا توجد منتجات حالياً.'));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final productId = product.id;
              final name = product['name'];
              final price = product['price'];
              final imageUrl = product['imageUrl'];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(name),
                  subtitle: Text('السعر: \$${price.toString()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteProduct(productId),
                  ),
                  onTap: () {
                    // يمكنك لاحقًا فتح شاشة تعديل المنتج
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}