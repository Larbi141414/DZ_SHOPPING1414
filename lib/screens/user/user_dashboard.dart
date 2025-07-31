import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  double balance = 1000.0; // الرصيد الابتدائي

  void depositMoney(double amount) {
    setState(() {
      balance += amount;
    });
  }

  void showDepositDialog() {
    final TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deposit Money'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Enter amount',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text);
              if (amount != null && amount > 0) {
                depositMoney(amount);
                Navigator.pop(context);
              }
            },
            child: const Text('Deposit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your Balance:",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "\$${balance.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: showDepositDialog,
              child: const Text("Deposit"),
            ),
          ],
        ),
      ),
    );
  }
}
