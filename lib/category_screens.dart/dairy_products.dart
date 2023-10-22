import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messageme_app/widgets/Allproductwidget.dart';
import '../widgets/nav_bar.dart';
import '../widgets/product_item_widget.dart';

class dairyScreen extends StatefulWidget {
  static const String screenroutes = 'dairyProducts';
  const dairyScreen({super.key});

  @override
  State<dairyScreen> createState() => _dairyScreenState();
}

class _dairyScreenState extends State<dairyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 131, 188, 235),
        title: Row(
          children: [
            Image.asset(
              'assets/laitier.png',
              width: 60,
              height: 60,
            ),
            SizedBox(width: 5),
            Text('Dairy Product'),
          ],
        ),
      ),
        body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('category', isEqualTo: 'Dairy Products') // قم بتصفية الوثائق بناءً على الفئة
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
              child: Text('No dairy products products available.'),
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
