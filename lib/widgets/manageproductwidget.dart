
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Producttomanage extends StatefulWidget {
  final String productId;
  final String imageUrl;
  final String productName;
  final int productPrice;
  final String description;

  Producttomanage({
    required this.productId,
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    required this.description,
  });

  @override
  _ProducttomanageState createState() => _ProducttomanageState();
}

class _ProducttomanageState extends State<Producttomanage> {
  late String _editedProductName;
  late int _editedProductPrice;
  late String _editedProductDescription;

  @override
  void initState() {
    super.initState();
    _editedProductName = widget.productName;
    _editedProductPrice = widget.productPrice;
    _editedProductDescription = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
      child: Container(
        height: 120,
        color: Color.fromARGB(255, 201, 255, 203),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            SizedBox(width: 12,),
            Container(
              color: Color.fromARGB(255, 201, 255, 203),
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Text(
                    _editedProductName,
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 3,),
                  Text(
                    '\$$_editedProductPrice',
                    style: TextStyle(
                      color: Color.fromARGB(255, 113, 112, 112),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 3,),
                  Text(
                    _editedProductDescription,
                    style: TextStyle(
                      color: Color.fromARGB(255, 148, 144, 144),
                      fontSize: 16,
                    ),
                    softWrap: true,
                    maxLines: 5,
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => _editProduct(context),
                          icon: Icon(Icons.edit)),

                           IconButton(
                            onPressed: () => _deleteProduct(context),
                             icon: Icon(Icons.delete)),
                    ],
                  ),
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController =
            TextEditingController(text: _editedProductName);
        TextEditingController priceController =
            TextEditingController(text: '$_editedProductPrice');
        TextEditingController descriptionController =
            TextEditingController(text: _editedProductDescription);

        return AlertDialog(
          title: Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _editedProductName = value;
                  });
                },
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter new product name...',
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _editedProductPrice = int.tryParse(value) ?? 0;
                  });
                },
                controller: priceController,
                decoration: InputDecoration(
                  hintText: 'Enter new product price...',
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _editedProductDescription = value;
                  });
                },
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter new product description...',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              
              onPressed: () {
                // تحديث البيانات في Firestore
                _updateProductInFirestore(
                  widget.productId,
                  _editedProductName,
                  _editedProductPrice,
                  _editedProductDescription,
                );

                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _updateProductInFirestore(String documentId, String newProductName,
      int newProductPrice, String newProductDescription) {
    FirebaseFirestore.instance.collection('products').doc(documentId).update({
      'name': newProductName,
      'price': newProductPrice,
      'description': newProductDescription,
    }).then((value) {
      // تم تحديث المنتج بنجاح
    }).catchError((error) {
      // حدث خطأ أثناء تحديث المنتج
    });
  }

  void _deleteProduct(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Product'),
        content: Text('Are you sure you want to delete this product?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // حذف المنتج من Firestore باستخدام وظيفة خاصة
              _deleteProductFromFirestore(widget.productId);
              Navigator.pop(context); // أغلق مربع الحوار
            },
            child: Text('Delete'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // أغلق مربع الحوار دون حذف المنتج
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}

void _deleteProductFromFirestore(String documentId) {
  FirebaseFirestore.instance.collection('products').doc(documentId).delete().then((value) {
    // تم حذف المنتج بنجاح من Firestore
    // يمكنك أيضًا تنفيذ أي إجراء آخر هنا إذا كان ذلك ضروريًا.
  }).catchError((error) {
    // حدث خطأ أثناء حذف المنتج من Firestore
  });
}
}










