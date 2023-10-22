
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messageme_app/constants.dart';

import 'package:messageme_app/widgets/Allproductwidget.dart';
import 'package:messageme_app/widgets/product_item_widget.dart';

import '../widgets/nav_bar.dart';

class Allproductscreen extends StatefulWidget {

  const Allproductscreen({Key? key, }) : super(key: key);

  @override
  State<Allproductscreen> createState() => _AllproductscreenState();
}
class _AllproductscreenState extends State<Allproductscreen> {
  
  final productsCollection = FirebaseFirestore.instance.collection('products');
  final storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kproductscreen,
          title: Row(
            children: [
              Image.asset(
                'assets/3anzati.png',
                width: 50,
                height: 50,
              ),
              SizedBox(width: 5),
              Text('Products Screen'),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products')
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

    // إذا كانت هناك منتجات، سنقوم بعرضها.
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // عرض حاويتين في كل سطر
      ),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        var productData = snapshot.data!.docs[index].data() as Map<String, dynamic>;

        // هنا نستخرج معلومات المنتج.
        String productName = productData['name'] ?? '';
        dynamic priceData = productData['price'];
        int productPrice =
            priceData is int ? priceData : int.tryParse(priceData) ?? 0;
        String productDescription = productData['description'] ?? '';
        String imageUrl = productData['image_url'] ?? '';

        // نعرض المنتج.
        return GestureDetector(
          onTap: () {
            print('تم النقر على المنتج');
            // نتنقل إلى صفحة تفاصيل المنتج ونمرر معلومات المنتج كمعلمات.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductItem(
                  imageUrl: imageUrl,
                  productName: productName,
                  productDescription: productDescription,
                  productPrice: productPrice, productId: '',
                ),
              ),
            );
          },
          child: ProductItem2(
            imageUrl: imageUrl,
            productName: productName,
            productPrice: productPrice,
          ),
        );
      },
    );
  },
),
 bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
