

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenstore_app/screens/chario.dart';
import 'package:greenstore_app/screens/favorites.dart';

import 'package:greenstore_app/screens/product.dart';
import 'package:greenstore_app/widgets/my_button.dart';
import 'package:provider/provider.dart';


import '../constants.dart';
import 'farmedatailswidget.dart';

class ProductItem extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final String productDescription;
  final int productPrice;
  final String productId;

  ProductItem({
    required this.imageUrl,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productId,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int number = 1;

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
            Text('Product Details'),
          ],
        ),
      ),
     
     
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(
              widget.imageUrl,
            ),
          ),
          Scroll(),
        ],
      ),
    );
  }
  Widget Scroll() {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: (context, ScrollController) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: ScrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 5,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.productName,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                   SizedBox(width: 10,),
                   IconButton(onPressed: (){
                     Navigator.pushNamed(context, Favorites.screenroutes);
                          addTofavorite();
                   },
                    icon:Icon(Icons.favorite_border),color: Kpinkcolor, iconSize: 32,),
                    SizedBox(width: 100,),
                    TextButton(
            onPressed: () async {
  // ابحث عن "farmId" المسجل داخل المستند في مجموعة "products"
  // هنا يجب أن تكون لديك طريقة للوصول إلى "userId" المسجل في مستند "products"
  String productName =widget.productName; // قم بتعيين productId بالطريقة الصحيحة

  // ابحث عن "userId" في مستند "products" باستخدام "productname"
  final productsRef = FirebaseFirestore.instance.collection('products');
  final productQuery = await productsRef.doc(productName).get();
  final userIdInProduct = productQuery.data()?['farmuserId'];

  // الآن قم بإجراء البحث في مجموعة "farmersprofile" باستخدام "userId" المسجل داخل المستند في "products"
  final farmersProfileRef = FirebaseFirestore.instance.collection('farmersprofile');
  final query = await farmersProfileRef.where('farmID', isEqualTo: userIdInProduct).get();

  // إذا تم العثور على المستند المطابق، قم بفتح صفحة "ProfiledetailItem"
  if (query.docs.isNotEmpty) {
    final profileData = query.docs.first.data() as Map<String, dynamic>;
    final imageUrl = profileData['profileImageUrl'];
    final farmName = profileData['farmename'];
    final farmDescription = profileData['farmedescription'];
    final firstLastName = profileData['firstlastname'];
    final email = profileData['email'];
    final phone = profileData['phone'];
    final location = profileData['location'];
    
    // قم بتمرير المعلومات إلى صفحة "ProfiledetailItem"
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfiledetailItem(
          imageUrl: imageUrl,
          farmName: farmName,
          farmDescription: farmDescription,
          firstLastName: firstLastName,
          email: email,
          phone: phone,
          location: location,
        ),
      ),
    );
  } else {
    // إذا لم يتم العثور على مستند متطابق، يمكنك إظهار رسالة خطأ أو اتخاذ إجراء آخر حسب احتياجات تطبيقك.
    // مثال: عرض رسالة تنبيه.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Profile Not Found'),
          content: Text('No matching farm profile found for the selected product.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
},
child: Text('Show Farm', style: TextStyle(color: Kpinkcolor)),)
                 


                  ],
                ),
                const SizedBox(height: 15,),
                Text(
                  'Description:',
                  style:
                   TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.w500,
                       height: 2),
                ),
                SizedBox(height: 7,),
                Text(
                  widget.productDescription,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Color.fromARGB(255, 135, 134, 134)),
                ),
                
                SizedBox(height: 20,),
                Container(
                  decoration:BoxDecoration(
                     color: Kpinkcolor,
                     borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: EdgeInsets.all(25),  
                  child: Column(
                    children: [ 
                      Row(
                       children: [
                        SizedBox(height: 7,),
                     Text(
                       ' \$${widget.productPrice.toString()}',
                       style: Theme.of(context)
                       .textTheme
                       .titleLarge
                        ?.copyWith(color:Colors.white),
                        
                        ),
                      SizedBox(width: 125,),
                        
                Row(  
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(109, 140, 94, 91),
                        shape: BoxShape.circle,
                        
                      ),
                      child: IconButton(
                        icon: Icon(Icons.remove, color: Colors.white,),
                        onPressed: () {
                          setState(() {
                            if (number > 1) {
                              number--;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 27,
                      child:Center(
                         child: Text(
                        number.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      ),
                     
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(109, 140, 94, 91),
                        shape: BoxShape.circle,
                        
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white, ),
                        onPressed: () {
                          setState(() {
                            number++;
                              });
                             },
                            ),
                           ),
                          ],
                        ),
                       ],
                      ),
                      SizedBox(height: 15,),
                      Mybutton(
                        color: Color.fromARGB(109, 140, 94, 91),
                         title: 'Add to cart', 
                         onPressed: (){
                          Navigator.pushNamed(context, Chario.screenroutes);
                          addToCart();
                         }, 
                         fontSize:100 ),
                    ],
                  ),
                ),
             ],
            ),
          ),
        );
      },
    );
  }

  void addToCart() {
  // تأكد من أن الكمية المحددة أكبر من صفر قبل إضافة المنتج لسلة التسوق
  if (number > 0) {
    // استيراد مزود البيانات
    final productProvider = Provider.of<ProductList>(context, listen: false);

    // العثور على المنتج المطابق بناءً على الاسم أو الـ ID أو أي معلمة أخرى
   Product productToAdd = productProvider.productList.firstWhere(
     (product) => product.name == widget.productName,
     orElse: () => Product( // استخدام Product كقيمة افتراضية
        id: '',
        name: widget.productName,
        description: '',
        price:  widget.productPrice, 
        imageUrl: '',
        category: '',
        farmuserId: '',

        ),
       );


    if (productToAdd != null) {
      // إضافة المنتج إلى سلة التسوق
      productProvider.addToCart(productToAdd, number);


      // hon 3m nhet l product te3in kl user bl cart tb3o bl firestore krmel eza 3mel sig out w rj3 3ml login ybyno
       // Create a reference to the user's cart document
      final user = FirebaseAuth.instance.currentUser;
      final cartCollection = FirebaseFirestore.instance.collection('cart');
      final userCartDocument = cartCollection.doc(user!.uid);

      // Create a reference to the "items" subcollection within the user's cart document
      final itemsCollection = userCartDocument.collection('items');

      // Create a new document for the added product
      itemsCollection.add({
        'name': productToAdd.name,
        'price': productToAdd.price,
        'quantity': number,
        'farmuserId': productToAdd.farmuserId,
        
      });

      

      // إظهار رسالة تأكيد للمستخدم
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('added to cart'),
            content: Text('  ${widget.productName} added to cart successfuly'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok', style: TextStyle(color: Kpinkcolor),),
              ),
            ],
          );
        },
      );
    } else {
      // إذا لم يتم العثور على المنتج، قم بعرض رسالة خطأ
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('خطأ في العثور على المنتج'),
            content: Text('عذرًا، لم يتم العثور على ${widget.productName}.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:  Text('ok', style: TextStyle(color: Kpinkcolor),),
              ),
            ],
          );
        },
      );
    }
    } 
    }


   void addTofavorite() {
    // استيراد مزود البيانات
    final productProviderfav = Provider.of<ProductList>(context, listen: false);

    // العثور على المنتج المطابق بناءً على الاسم أو الـ ID أو أي معلمة أخرى
   Product productTofav = productProviderfav.productList.firstWhere(
     (product) => product.name == widget.productName,
     orElse: () => Product( // استخدام Product كقيمة افتراضية
        id: '',
        name: widget.productName,
        description: '',
        price:  widget.productPrice, 
        imageUrl: '',
        category: '',
        farmuserId: '',
        ),
       );


    if (productTofav != null) {
      // إضافة المنتج إلى سلة التسوق
      productProviderfav.addTofavorite(productTofav);
      
      final user = FirebaseAuth.instance.currentUser;
      final favCollection = FirebaseFirestore.instance.collection('favorite');
      final userfavDocument = favCollection.doc(user!.uid);

      // Create a reference to the "items" subcollection within the user's cart document
      final itemsCollection = userfavDocument.collection('itemsfav');

      // Create a new document for the added product
      itemsCollection.add({
        'name': productTofav.name,
        'price': productTofav.price,
      });

      


      // إظهار رسالة تأكيد للمستخدم
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('added to favorite'),
            content: Text('  ${widget.productName} added to favorite successfuly'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok', style: TextStyle(color: Kpinkcolor),),
              ),
            ],
          );
        },
      );
       
     }
    } 
    }
  
  
 



