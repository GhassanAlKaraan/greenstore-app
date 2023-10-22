// import 'package:flutter/material.dart';

// class ProductDetailScreen extends StatefulWidget {
//   static const String screenRoute = '/product_detail_screen';

//   final String imageUrl;
//   final String productName;
//   final String productDescription;
//   final int productPrice;

//   ProductDetailScreen({
//     required this.imageUrl,
//     required this.productName,
//     required this.productDescription,
//     required this.productPrice,
//   });

//   @override
//   _ProductDetailScreenState createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(widget.imageUrl), 
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.productName, 
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Description: ${widget.productDescription}', 
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Price: \$${widget.productPrice}', 
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
