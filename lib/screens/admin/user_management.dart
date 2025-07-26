import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المستخدمين'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseService().getAllUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data?.docs ?? [];

          if (users.isEmpty) {
            return const Center(child: Text('لا يوجد مستخدمين.'));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final userId = user.id;
              final email = user['email'];
              final name = user['name'] ?? '';
              final balance = user['balance'] ?? 0;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(name.isNotEmpty ? name : 'مستخدم بدون اسم'),
                  subtitle: Text('البريد: $email\nالرصيد: \$${balance.toString()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showBalanceDialog(context, userId, balance);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showBalanceDialog(BuildContext context, String userId, num currentBalance) {
    final TextEditingController controller =
        TextEditingController(text: currentBalance.toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تعديل رصيد المستخدم'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'الرصيد الجديد'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newBalance = num.tryParse(controller.text) ?? currentBalance;
              await FirebaseService().updateUserBalance(userId, newBalance);
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}