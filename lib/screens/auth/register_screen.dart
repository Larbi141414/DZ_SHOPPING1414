import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  Future<void> _register() async {
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        errorMessage = 'كلمتا المرور غير متطابقتين';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = credential.user?.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': emailController.text.trim(),
        'name': nameController.text.trim(),
        'balance': 0,
        'isAdmin': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'حدث خطأ أثناء إنشاء الحساب';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _navigateToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'الاسم الكامل'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'كلمة المرور'),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(labelText: 'تأكيد كلمة المرور'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: 'تسجيل',
                    onPressed: _register,
                  ),
            TextButton(
              onPressed: _navigateToLogin,
              child: const Text('لديك حساب؟ تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }
}