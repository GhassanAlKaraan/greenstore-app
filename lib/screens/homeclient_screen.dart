// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenstore_app/category_screens.dart/animals.dart';
import 'package:greenstore_app/category_screens.dart/dairy_products.dart';
import 'package:greenstore_app/category_screens.dart/fruits.dart';
import 'package:greenstore_app/category_screens.dart/meat_products.dart';
import 'package:greenstore_app/category_screens.dart/seeds.dart';
import 'package:greenstore_app/category_screens.dart/vegetables.dart';
import 'package:greenstore_app/category_screens.dart/wood.dart';
import 'package:greenstore_app/constants.dart';

class Category {
  final String name;
  final Color color;
  final String imageAsset;
  final String description;
  final String screenRoute; // Add this property

  const Category(this.name, this.color, this.imageAsset, this.description,
      this.screenRoute);
}

class HomeclientScreen extends StatefulWidget {
  static const String screenroutes = 'homeclient_screen';

  const HomeclientScreen({super.key});

  @override
  _HomeclientScreenState createState() => _HomeclientScreenState();
}

class _HomeclientScreenState extends State<HomeclientScreen> {
  final List<Category> categories = [
    const Category(
      'Vegetable',
      Color.fromARGB(255, 136, 252, 140),
      'assets/khas.png',
      'Fresh and healthy  vegetables for your kitchen!',
      vegetablesScreen.screenroutes,
    ),
    const Category(
      'Fruits',
      Color.fromARGB(255, 249, 124, 157),
      'assets/frez.png',
      'Juicy and delicious fruits for your taste buds!',
      FruitsScreen.screenroutes,
    ),
    const Category(
      'Animals',
      Color.fromARGB(255, 255, 240, 108),
      'assets/3anzati.png',
      'Cute and lovely animals for your farm!',
      AnimalsScreen.screenroutes,
    ),
    const Category(
      ' Wood',
      Color.fromARGB(255, 245, 134, 94),
      'assets/wood.png',
      'High-quality wood for your garden!',
      woodScreen.screenroutes,
    ),
    const Category(
      'Dairy Products',
      Color.fromARGB(255, 131, 188, 235),
      'assets/laitier.png',
      'Fresh and creamy dairy products for your kitchen!',
      DairyScreen.screenroutes,
    ),
    const Category(
      'Meat Products',
      Color.fromARGB(255, 255, 163, 107),
      'assets/meats.png',
      'High-quality meat products for your meals!',
      meatScreen.screenroutes,
    ),
    const Category(
      'Seeds',
      Color.fromARGB(255, 255, 214, 123),
      'assets/buzur.png',
      'A variety of seeds for planting and growing!',
      seedsScreen.screenroutes,
    ),
  ];

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
            const SizedBox(width: 5),
            const Text('GreenStore'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: List.generate(categories.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  categories[index].screenRoute, // Use the screenRoute property
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 165,
                  decoration: BoxDecoration(
                    color: categories[index].color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 2,
                        left: 5,
                        child: Image.asset(
                          categories[index].imageAsset,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 30,
                        right: 30,
                        child: Text(
                          categories[index].name,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        right: 15,
                        child: Text(
                          categories[index].description,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
