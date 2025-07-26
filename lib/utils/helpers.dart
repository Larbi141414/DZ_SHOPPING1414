import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  // تنسيق السعر (مثلاً: 1,500 د.ج)
  static String formatPrice(num price) {
    final formatCurrency = NumberFormat.decimalPattern('ar_DZ');
    return '${formatCurrency.format(price)} د.ج';
  }

  // عرض رسالة SnackBar
  static void showSnackBar(BuildContext context, String message,
      {Color backgroundColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textDirection: TextDirection.rtl),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // التحقق من بريد إلكتروني صالح
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // تحويل التاريخ إلى نص منسق
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(date);
  }

  // عرض حوار تأكيد بسيط
  static Future<bool> showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
  ) async {
    bool confirmed = false;
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
              onPressed: () {
                confirmed = false;
                Navigator.of(context).pop();
              },
              child: const Text("إلغاء")),
          ElevatedButton(
              onPressed: () {
                confirmed = true;
                Navigator.of(context).pop();
              },
              child: const Text("تأكيد")),
        ],
      ),
    );
    return confirmed;
  }
}
