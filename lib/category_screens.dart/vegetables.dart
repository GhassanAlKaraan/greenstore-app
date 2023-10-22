import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/Allproductwidget.dart';
import '../widgets/nav_bar.dart';
import '../widgets/product_item_widget.dart';

class vegetablesScreen extends StatefulWidget {
  static const String screenroutes = 'vegetablesProducts';
  const vegetablesScreen({super.key});

  @override
  State<vegetablesScreen> createState() => _vegetablesScreenState();
}

class _vegetablesScreenState extends State<vegetablesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 136, 252, 140),
        title: Row(
          children: [
            Image.asset(
              'assets/khas.png',
              width: 60,
              height: 60,
            ),
            SizedBox(width: 5),
            Text('Vegetables Products'),
          ],
        ),
      ),
    body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('category', isEqualTo: 'vegetables') // قم بتصفية الوثائق بناءً على الفئة
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
              child: Text('No vegetable products available.'),
            );
          }

         return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عرض حاويتين في كل سطر
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var productData = snapshot.data!.docs[index].data() as Map<String, dynamic>;

              // استخدم ProductItem لعرض المنتج
              String productName = productData['name'] ?? '';
              dynamic priceData = productData['price'];
              int productPrice = priceData is int ? priceData : int.tryParse(priceData) ?? 0;
              String productDescription = productData['description'] ?? '';
              String imageUrl = productData['image_url'] ?? '';

               return GestureDetector(
           onTap: () {
           print('تم النقر على المنتج');
           // Navigate to the product detail screen and pass product details as parameters.
            Navigator.push(
            context,
           MaterialPageRoute(
           builder: (context) =>ProductItem (
          imageUrl: imageUrl,
          productName: productName,
          productDescription: productDescription,
          productPrice: productPrice, productId: '',
          
            ),
           ),
          );
         },
        child:ProductItem2(
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
    bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
