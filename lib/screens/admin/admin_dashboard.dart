import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int usersCount = 0;
  int ordersCount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCounts();
  }

  Future<void> loadCounts() async {
    final usersSnapshot = await FirebaseFirestore.instance.collection('users').get();
    final ordersSnapshot = await FirebaseFirestore.instance.collection('orders').get();

    setState(() {
      usersCount = usersSnapshot.docs.length;
      ordersCount = ordersSnapshot.docs.length;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم الأدمن'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DashboardCard(title: 'عدد المستخدمين', value: usersCount.toString()),
                  const SizedBox(height: 16),
                  DashboardCard(title: 'عدد الطلبات', value: ordersCount.toString()),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // الانتقال إلى صفحة إدارة الطلبات
                      Navigator.pushNamed(context, '/admin/orders');
                    },
                    child: const Text('إدارة الطلبات'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // الانتقال إلى صفحة إدارة المنتجات
                      Navigator.pushNamed(context, '/admin/products');
                    },
                    child: const Text('إدارة المنتجات'),
                  ),
                ],
              ),
            ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;

  const DashboardCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}