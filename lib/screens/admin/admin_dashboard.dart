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
