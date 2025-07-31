import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'screens/admin/admin_dashboard.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    routes: {
      '/admin': (context) => AdminDashboard(),
    },
  ));
}
