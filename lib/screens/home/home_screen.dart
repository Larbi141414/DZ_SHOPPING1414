import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DZ SHOPPING"),
        backgroundColor: Colors.green,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
            child: const Text("Admin", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: const Center(
        child: Text("واجهة المستخدم الرئيسية"),
      ),
    );
  }
}
