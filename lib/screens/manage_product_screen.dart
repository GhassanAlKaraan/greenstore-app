
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:greenstore_app/screens/add_product.dart';
import 'package:greenstore_app/screens/homefarmer_screen.dart';

import 'package:greenstore_app/screens/manage_profile_screen.dart';

import 'package:greenstore_app/widgets/manageproductwidget.dart';

class ManageProductScreen extends StatefulWidget {
  static const String screenroutes = 'manage_product_screen';

  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final user = FirebaseAuth.instance.currentUser;
  int index = 0;
  final productsCollection = FirebaseFirestore.instance.collection('products');
  final storage = FirebaseStorage.instance;
  
  get userId => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 162, 255, 92),
        title: Row(
          children: [
            Image.asset(
              'assets/tractor.png',
              width: 45,
              height: 45,
            ),
            SizedBox(width: 5),
            Text('Manage your product'),
          ],
        ),
      ),
      
      body:
         StreamBuilder<QuerySnapshot>(
         stream: productsCollection
        .where('userId', isEqualTo: user?.uid)
        .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Center(
        child: Text('Error: ${snapshot.error}'),
      );
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Center(
        child: Text('No products available.'),
      );
    }
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        var productData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
        String productName = productData['name'] ?? '';
        dynamic priceData = productData['price'];
        int productPrice = priceData is int ? priceData : int.tryParse(priceData) ?? 0;
        String productDescription = productData['description'] ?? '';
        String imageUrl = productData['image_url'] ?? '';
        return Producttomanage(
          imageUrl: imageUrl,
          productName: productName,
          description: productDescription,
          productPrice: productPrice,
          productId: snapshot.data!.docs[index].id,
        );
      },
    );
  },
),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Color.fromARGB(255, 132, 131, 131),
        unselectedItemColor: Color.fromARGB(255, 132, 131, 131),
        onTap: (int newIndex) {
          setState(() {
            index = newIndex;
            _navigateToScreen(index, context);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _navigateToScreen(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomefarmerScreen(),
          ),
        );
        break;
      case 1:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>AddProductScreen(),
          ),
        );
        break;
      case 2:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ManageProfileScreen(),
          ),
        );
        break;
    }
  }

  
}

  
  

