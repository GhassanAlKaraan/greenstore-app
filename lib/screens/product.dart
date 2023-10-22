// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Product  {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final String category;
  final String farmuserId;


  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.farmuserId,

  });
}

class ProductList extends ChangeNotifier{
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  List<Product> _productslist = [];

  Future<void> fetchProducts() async {
    final QuerySnapshot querySnapshot = await _productsCollection.get();

    _productslist = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Product(
        id: doc.id,
        name: data['name'],
        description: data['description'],
        price: data['price'].toDouble(),
        imageUrl: data['image_url'],
        category: data['category'],
        farmuserId: data['farmuserId'],

      );
    }).toList();

    notifyListeners();
  }

  //customer cart
   List<Product> _cart =[];

   //getter methods
   List<Product> get productList => _productslist;
   List <Product> get cart => _cart;

   // add to cart
   void addToCart (Product product, int quantity ){
    for(int i=0 ; i<quantity; i++){
      _cart.add(product);
    }
    notifyListeners();
   }

   // remove from cart
   void removeFromCart (Product product){
    _cart.remove(product);
    notifyListeners();
   }


   //customer favorite
   List<Product> _favproduct=[];

   //getter methods
   List<Product> get favorites => _favproduct;

   //add to favorite
   void addTofavorite (Product product){
      _favproduct.add(product);
    notifyListeners();
   }

   // remove from cart
   void removeFromfav (Product product){
    _favproduct.remove(product);
    notifyListeners();
   }



}

