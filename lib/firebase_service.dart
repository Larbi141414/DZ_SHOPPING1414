import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // تسجيل مستخدم جديد في Firestore بعد التسجيل
  Future<void> createUserDocument(User user, String name) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    final exists = (await userDoc.get()).exists;
    if (!exists) {
      await userDoc.set({
        'uid': user.uid,
        'email': user.email,
        'name': name,
        'balance': 0,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // جلب بيانات المستخدم الحالي
  Future<DocumentSnapshot> getCurrentUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      return await _firestore.collection('users').doc(uid).get();
    }
    throw Exception("User not logged in");
  }

  // تدفق لجميع المستخدمين (للأدمن)
  Stream<QuerySnapshot> getAllUsersStream() {
    return _firestore.collection('users').snapshots();
  }

  // تحديث رصيد مستخدم معين (للأدمن)
  Future<void> updateUserBalance(String userId, num newBalance) async {
    await _firestore.collection('users').doc(userId).update({
      'balance': newBalance,
    });
  }

  // جلب جميع الطلبات
  Stream<QuerySnapshot> getAllOrders() {
    return _firestore.collection('orders').orderBy('timestamp', descending: true).snapshots();
  }

  // إنشاء طلب جديد
  Future<void> createOrder(Map<String, dynamic> orderData) async {
    await _firestore.collection('orders').add(orderData);
  }

  // جلب المنتجات
  Stream<QuerySnapshot> getAllProducts() {
    return _firestore.collection('products').snapshots();
  }

  // إضافة منتج جديد
  Future<void> addProduct(Map<String, dynamic> productData) async {
    await _firestore.collection('products').add(productData);
  }

  // حذف منتج
  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }
}
