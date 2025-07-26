import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'status': newStatus,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة الطلبات')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data?.docs ?? [];

          if (orders.isEmpty) {
            return const Center(child: Text('لا توجد طلبات حالياً.'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final orderId = order.id;
              final userId = order['userId'];
              final productName = order['productName'];
              final quantity = order['quantity'];
              final status = order['status'];
              final timestamp = (order['timestamp'] as Timestamp).toDate();

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text('المنتج: $productName'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('المستخدم: $userId'),
                      Text('الكمية: $quantity'),
                      Text('الحالة: $status'),
                      Text('التاريخ: $timestamp'),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      updateOrderStatus(orderId, value);
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'قيد التنفيذ', child: Text('قيد التنفيذ')),
                      const PopupMenuItem(value: 'تم الشحن', child: Text('تم الشحن')),
                      const PopupMenuItem(value: 'تم التوصيل', child: Text('تم التوصيل')),
                      const PopupMenuItem(value: 'ملغى', child: Text('ملغى')),
                    ],
                    child: const Icon(Icons.more_vert),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}