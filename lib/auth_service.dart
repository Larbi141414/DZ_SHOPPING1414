import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService _firebaseService = FirebaseService();

  // تسجيل الدخول بالبريد وكلمة المرور
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      debugPrint("Sign in error: $e");
      rethrow;
    }
  }

  // التسجيل بحساب جديد
  Future<User?> registerWithEmailAndPassword(String email, String password, String name) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;
      if (user != null) {
        await _firebaseService.createUserDocument(user, name);
      }
      return user;
    } catch (e) {
      debugPrint("Register error: $e");
      rethrow;
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // المستخدم الحالي
  User? get currentUser => _auth.currentUser;

  // متابعة حالة تسجيل الدخول
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
