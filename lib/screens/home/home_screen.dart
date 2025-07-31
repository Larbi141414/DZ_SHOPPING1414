import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart, size: 100, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'DZ SHOPPING',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              buildMenuButton(context, 'Go to Admin Panel', Icons.admin_panel_settings, '/admin'),
              buildMenuButton(context, 'Login', Icons.login, '/login'),
              buildMenuButton(context, 'Sign Up', Icons.person_add, '/signup'),
              buildMenuButton(context, 'Cart', Icons.shopping_bag, '/cart'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuButton(BuildContext context, String text, IconData icon, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, route),
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
