
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:messageme_app/screens/product.dart';

// import '../constants.dart';
// import '../widgets/nav_bar.dart';

// class Chario extends StatefulWidget {
//   static const String screenroutes = 'charioScreen';
//   const Chario({Key? key}) : super(key: key);

//   @override
//   State<Chario> createState() => _CharioState();
// }

// class _CharioState extends State<Chario> {
//   final user = FirebaseAuth.instance.currentUser;
//   final cartCollection = FirebaseFirestore.instance.collection('cart');
//   late final userCartDocument;
  
  

//   @override
//   void initState() {
//     super.initState();
//     // قم بإعداد الوثيقة المرتبطة بعربة التسوق الخاصة بالمستخدم
//     userCartDocument = cartCollection.doc(user!.uid);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Kpinkcolor,
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/tractor.png',
//               width: 45,
//               height: 45,
//             ),
//             SizedBox(width: 5),
//             Text('Your Cart'),
//           ],
//         ),
//       ),
//       body: FutureBuilder<QuerySnapshot>(
//         future: userCartDocument.collection('items').get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text('No items in the cart'),
//             );
//           } else {
//             // استخراج المنتجات من الاستعلام
//            final products = snapshot.data!.docs
//     .map((doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       final name = doc['name'];
//       final price = doc['price'];
//       final description = data.containsKey('description') ? data['description'] : 'No description available';
//       final imageUrl = data.containsKey('image_url') ? data['image_url'] : 'No image available';
//       final category = data.containsKey('category') ? data['category'] : 'No category available';

//       return Product(
//         id: doc.id,
//         name: name,
//         description: description,
//         price: price,
//         imageUrl: imageUrl,
//         category: category,
//         farmuserId: farmuserId,

//       );
//     })
//     .toList();


//             return Container(
//                  color: Color.fromARGB(255, 250, 225, 233),

//               child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return ListTile(
//                     leading: IconButton(
//                       icon: Icon(Icons.shopping_bag_outlined),
//                       onPressed: () {
//                         _placeOrder(product);
//                       },
//                     ),
//                     title: Text(product.name),
//                     subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () {
//                          _removeProduct(product.id); 
//                       },
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//        bottomNavigationBar: CustomBottomNavigationBar(),
//     );
//   }
//   void _removeProduct(String productId) {
//   // إزالة المنتج من Firestore
//   userCartDocument.collection('items').doc(productId).delete();
// }




// void _placeOrder(Product product) {
//   if (user != null) {
//     final clientData = user;
//     final orderData = {
//       'product_id': product.id,
//       'name': product.name,
//       'location': clientData!.displayName,
//       'email': clientData.email,
      
//     };

//     FirebaseFirestore.instance.collection('orders').add(orderData).then((orderDoc) {
//       // Handle success or any additional steps
//     }).catchError((error) {
//       print('Error while adding order: $error');
//     });
//   } else {
//     print('User is not authenticated.');
//   }
// }

// Future<String> getFarmUserIdForProduct(String productName) async {
//   final productsRef = FirebaseFirestore.instance.collection('products');
//   final productQuery = await productsRef.where('productName', isEqualTo: productName).get();

//   if (productQuery.docs.isNotEmpty) {
//     final farmUserId = productQuery.docs.first.data()['farmuserId'];
//     return farmUserId;
//   } else {
//     // إذا لم يتم العثور على مزرعة مطابقة، يمكنك إتخاذ إجراءات إضافية هنا حسب احتياجات تطبيقك.
//     return ''; // أو أي قيمة أخرى تعبر عن عدم العثور على المزرعة.
//   }
// }


// }













import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenstore_app/screens/product.dart';

import '../constants.dart';
import '../widgets/nav_bar.dart';

class Chario extends StatefulWidget {
  static const String screenroutes = 'charioScreen';
  const Chario({Key? key}) : super(key: key);

  @override
  State<Chario> createState() => _CharioState();
}

class _CharioState extends State<Chario> {
  final user = FirebaseAuth.instance.currentUser;
  final cartCollection = FirebaseFirestore.instance.collection('cart');
  late final userCartDocument;

  @override
  void initState() {
    super.initState();
    // قم بإعداد الوثيقة المرتبطة بعربة التسوق الخاصة بالمستخدم
    userCartDocument = cartCollection.doc(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kpinkcolor,
        title: Row(
          children: [
            Image.asset(
              'assets/tractor.png',
              width: 45,
              height: 45,
            ),
            SizedBox(width: 5),
            Text('Your Cart'),
          ],
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: userCartDocument.collection('items').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No items in the cart'),
            );
          } else {
            return FutureBuilder<List<Product>>(
              future: getProductsForUserCart(snapshot.data!.docs),
              builder: (context, productSnapshot) {
                if (productSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (productSnapshot.hasError) {
                  return Text('Error: ${productSnapshot.error}');
                } else if (productSnapshot.data == null || productSnapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No items in the cart'),
                  );
                } else {
                  final products = productSnapshot.data!;

                  return Container(
                    color: Color.fromARGB(255, 250, 225, 233),
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.shopping_bag_outlined),
                            onPressed: () {
                              _placeOrder(product);
                            },
                          ),
                          title: Text(product.name),
                          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _removeProduct(product.id);
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Future<void> _removeProduct(String productId) async {
    // إزالة المنتج من Firestore
    await userCartDocument.collection('items').doc(productId).delete();
  }

  void _placeOrder(Product product) {
    if (user != null) {
      final clientData = user;
      final orderData = {
        'product_id': product.id,
        'name': product.name,
        'location': clientData!.displayName,
        'email': clientData.email,
      };

      FirebaseFirestore.instance.collection('orders').add(orderData).then((orderDoc) {
        // Handle success or any additional steps
      }).catchError((error) {
        print('Error while adding order: $error');
      });
    } else {
      print('User is not authenticated.');
    }
  }

  Future<List<Product>> getProductsForUserCart(List<QueryDocumentSnapshot> items) async {
    final productsRef = FirebaseFirestore.instance.collection('products');
    final products = <Product>[];

    for (final item in items) {
      final data = item.data() as Map<String, dynamic>;
      final productName = data['name'];

      final productQuery = await productsRef.where('productName', isEqualTo: productName).get();

      if (productQuery.docs.isNotEmpty) {
        final productData = productQuery.docs.first.data();
        final product = Product(
          id: productQuery.docs.first.id,
          name: productData['productName'],
          description: productData['productDescription'],
          price: productData['productPrice'],
          imageUrl: productData['imageUrl'],
          category: productData['category'],
          farmuserId: productData['farmuserId'],
        );
        products.add(product);
      }
    }

    return products;
  }
}
