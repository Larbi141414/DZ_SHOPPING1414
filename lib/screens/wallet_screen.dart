import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  num balance = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBalance();
  }

  Future<void> fetchBalance() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        balance = doc.data()?['balance'] ?? 0;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المحفظة'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'رصيدك الحالي:',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '$balance دج',
                    style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
      ),
    );
  }
}
