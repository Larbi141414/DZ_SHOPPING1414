<<<<<<< HEAD
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
=======
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  final List<String> options = [
    "إضافة مسح",
    "إدارة المستخدمين",
    "الطلبات",
    "إشعارات",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text("DZ SHOPPING"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("English", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: options.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {},
              child: Text(options[index], style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Admin"),
        ],
      ),
    );
  }
}
>>>>>>> 7bee6cb7fb3f02d97e350d9f59ea00a13815abfa
