import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenstore_app/screens/product.dart';

import '../constants.dart';
import '../widgets/nav_bar.dart';

class Favorites extends StatefulWidget {
  static const String screenroutes = 'favoritesScreen';
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final ProductList productProviderfav = ProductList();
  final user = FirebaseAuth.instance.currentUser;
  final favCollection = FirebaseFirestore.instance.collection('favorite');
  late final userfavDocument;
  

  @override
  void initState() {
    super.initState();
    // قم بإعداد الوثيقة المرتبطة بعربة التسوق الخاصة بالمستخدم
    userfavDocument = favCollection.doc(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.favorite, size: 40,)),
            SizedBox(width: 5),
            Text('Your favorite screen'),
          ],
        ),
      ),
      body: 
      FutureBuilder<QuerySnapshot>(
        future: userfavDocument.collection('itemsfav').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No items in the favorite screen'),
            );
          } else {
            // استخراج المنتجات من الاستعلام
           final products = snapshot.data!.docs
    .map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final name = doc['name'];
      final price = doc['price'];
      final description = data.containsKey('description') ? data['description'] : 'No description available';
      final imageUrl = data.containsKey('image_url') ? data['image_url'] : 'No image available';
      final category = data.containsKey('category') ? data['category'] : 'No category available';

      return Product(
        id: doc.id,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
        category: category,
        farmuserId: category,

      );
    })
    .toList();


            return Container(
              color: Color.fromARGB(255, 250, 225, 233),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    leading: IconButton(icon: Icon(Icons.add_shopping_cart),
                           onPressed: () {
                        productProviderfav.addToCart(product, 1); // إضافة المنتج إلى سلة التسوق
            
                       // إضافة المنتج إلى Firestore أيضًا
                final user = FirebaseAuth.instance.currentUser;
                final cartCollection = FirebaseFirestore.instance.collection('cart');
                final userCartDocument = cartCollection.doc(user!.uid);
                final itemsCollection = userCartDocument.collection('items');
            
                itemsCollection.add({
                  'name': product.name,
                  'price': product.price,
                  'quantity': 1, 
                });
            
                
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Added to Cart'),
                    content: Text('${product.name} has been added to your cart.'),
                    actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: TextStyle(color: Kpinkcolor)),
                       ),
                      ],
                     );
                    },
                   );
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
      ),
       bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
  void _removeProduct(String productId) {
  // إزالة المنتج من Firestore
  userfavDocument.collection('itemsfav').doc(productId).delete();
}
}
