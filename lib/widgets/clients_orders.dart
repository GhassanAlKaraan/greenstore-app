// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Order {
//   final String orderId;
//   final Product product;
//   final Client customer;
//   final DateTime orderTime;

//   Order({
//     required this.orderId,
//     required this.product,
//     required this.customer,
//     required this.orderTime,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'orderId': orderId,
//       'product': product.toMap(),
//       'customer': customer.toMap(),
//       'orderTime': orderTime.toUtc(),
//     };
//   }
// }

// class Product {
//   final String productId;
//   final String name;
//   final double price;
//   final String description;
//   final String imageUrl;
//   final String category;

//   Product({
//     required this.productId,
//     required this.name,
//     required this.price,
//     required this.description,
//     required this.imageUrl,
//     required this.category,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'productId': productId,
//       'name': name,
//       'price': price,
//       'description': description,
//       'imageUrl': imageUrl,
//       'category': category,
//     };
//   }
// }

// class Client {
//   final String uid;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phone;
//   final String location;

//   Client({
//     required this.uid,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.location,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'phone': phone,
//       'location': location,
//     };
//   }

//   factory Client.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return Client(
//       uid: doc.id,
//       firstName: data['firstName'],
//       lastName: data['lastName'],
//       email: data['email'],
//       phone: data['phone'],
//       location: data['location'],
//     );
//   }
// }

// Future<void> createOrder(Product product) async {
//   final user = FirebaseAuth.instance.currentUser;

//   // إنشاء معرف فريد للطلب
//   final orderId = FirebaseFirestore.instance.collection('orders').doc().id;

//   // جلب معلومات العميل
// Client customer = await getClientInformation(user); // تأكد من تعريف واستدعاء getClientInformation بشكل صحيح

//   // إنشاء الطلب باستخدام class Order
//   final order = Order(
//     orderId: orderId,
//     product: product,
//     customer: customer,
//     orderTime: DateTime.now(),
//   );

//   // حفظ الطلب في Firestore
//   final orderCollection = FirebaseFirestore.instance.collection('orders');
//   orderCollection.doc(orderId).set(order.toMap());
// }

// Future<Client> getClientInformation(User? user) async {
//   if (user != null) {
//     final clientDoc = FirebaseFirestore.instance.collection('clients').doc(user.uid);
//     final clientSnapshot = await clientDoc.get(); // انتظر استرجاع البيانات

//     if (clientSnapshot.exists) {
//       return Client.fromFirestore(clientSnapshot);
//     }
//   }
//   throw Exception('Unable to retrieve client information.');
// }
