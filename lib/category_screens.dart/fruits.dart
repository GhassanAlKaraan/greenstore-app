// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/all_product_widget.dart';
import '../widgets/nav_bar.dart';
import '../widgets/product_item_widget.dart';

class FruitsScreen extends StatefulWidget {
  static const String screenroutes = 'fruitsProducts';
  const FruitsScreen({super.key});

  @override
  State<FruitsScreen> createState() => _FruitsScreenState();
}

class _FruitsScreenState extends State<FruitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 124, 157),
        title: Row(
          children: [
            Image.asset(
              'assets/frez.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 5),
            const Text('Fruits Product'),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('category',
                isEqualTo: 'Fruits') // قم بتصفية الوثائق بناءً على الفئة
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No fruits products available.'),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عرض حاويتين في كل سطر
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var productData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              // استخدم ProductItem لعرض المنتج
              String productName = productData['name'] ?? '';
              dynamic priceData = productData['price'];
              int productPrice =
                  priceData is int ? priceData : int.tryParse(priceData) ?? 0;
              String productDescription = productData['description'] ?? '';
              String imageUrl = productData['image_url'] ?? '';

              return GestureDetector(
                onTap: () {
                  print('تم النقر على المنتج');
                  // Navigate to the product detail screen and pass product details as parameters.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductItem(
                        imageUrl: imageUrl,
                        productName: productName,
                        productDescription: productDescription,
                        productPrice: productPrice,
                        productId: '',
                      ),
                    ),
                  );
                },
                child: ProductItem2(
                  imageUrl: imageUrl,
                  productName: productName,
                  //productDescription: productDescription,
                  productPrice: productPrice,
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
