import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final String status;
  final num total;
  final Timestamp timestamp;
  final String paymentMethod;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.status,
    required this.total,
    required this.timestamp,
    required this.paymentMethod,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data, String documentId) {
    return OrderModel(
      id: documentId,
      userId: data['userId'] ?? '',
      status: data['status'] ?? 'pending',
      total: data['total'] ?? 0,
      timestamp: data['timestamp'] ?? Timestamp.now(),
      paymentMethod: data['paymentMethod'] ?? '',
      items: (data['items'] as List<dynamic>).map((item) => OrderItem.fromMap(item)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'status': status,
      'total': total,
      'timestamp': timestamp,
      'paymentMethod': paymentMethod,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }
}

class OrderItem {
  final String productId;
  final String name;
  final String image;
  final num price;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      price: map['price'] ?? 0,
      quantity: map['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }
}
