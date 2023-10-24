import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenstore_app/category_screens.dart/animals.dart';
import 'package:greenstore_app/category_screens.dart/dairy_products.dart';
import 'package:greenstore_app/category_screens.dart/fruits.dart';
import 'package:greenstore_app/category_screens.dart/meat_products.dart';
import 'package:greenstore_app/category_screens.dart/seeds.dart';
import 'package:greenstore_app/category_screens.dart/wood.dart';
import 'package:greenstore_app/screens/add_product.dart';
import 'package:greenstore_app/screens/chario.dart';
import 'package:greenstore_app/screens/farmes.dart';
import 'package:greenstore_app/screens/favorites.dart';
import 'package:greenstore_app/screens/homeclient_screen.dart';
import 'package:greenstore_app/screens/homefarmer_screen.dart';
import 'package:greenstore_app/screens/manage_product_screen.dart';
import 'package:greenstore_app/screens/manage_profile_screen.dart';
import 'package:greenstore_app/screens/ordersscreen.dart';
import 'package:greenstore_app/screens/product.dart';
import 'package:greenstore_app/screens/profiledetailscreen.dart';
import 'package:greenstore_app/signloginScreens.dart/registration_screen.dart';
import 'package:greenstore_app/signloginScreens.dart/registrationclient_scrreen.dart';

import 'package:greenstore_app/category_screens.dart/vegetables.dart';
import 'package:greenstore_app/signloginScreens.dart/signin_screen.dart';
import 'package:greenstore_app/signloginScreens.dart/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessageMe app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: FirebaseAuth.instance
            .authStateChanges()
            .first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // You can show a loading indicator here if needed.
            return CircularProgressIndicator(color: Colors.pink,backgroundColor: Colors.pink.shade50,);
          } else {
            // Check if the user is logged in
            if (snapshot.hasData) {
              return const HomefarmerScreen(); // Show the homepage if logged in
            } else {
              return const WelcomeScreen(); // Show the welcome/login screen if not logged in
            }
          }
        },
      ),
      //home:FarmersProfilesScreen(),
      // home:HomefarmerScreen(),
      //home: Allproductscreen(),
      //home: Favorites(),
      // home: SignInScreen.screenRoute,

    //home:RegistratioScreen(),
    routes: {
    WelcomeScreen.screenroutes: (context) => const WelcomeScreen(),
    SignInScreen.screenRoute: (context) => const SignInScreen(),
    RegistrationScreen.screenroutes: (context) =>
    const RegistrationScreen(),
    RegistrationclientScreen.screenroutes: (context) =>
    const RegistrationclientScreen(),
    HomeclientScreen.screenroutes: (context) => const HomeclientScreen(),
    HomefarmerScreen.screenroutes: (context) => const HomefarmerScreen(),
    ManageProductScreen.screenroutes: (context) =>
    const ManageProductScreen(),
    ManageProfileScreen.screenRoute: (context) =>
    const ManageProfileScreen(),
    OrdersScreen.screenroutes: (context) => const OrdersScreen(),
    AddProductScreen.screenroutes: (context) => const AddProductScreen(),
    AnimalsScreen.screenroutes: (context) => const AnimalsScreen(),
    DairyScreen.screenroutes: (context) => const DairyScreen(),
    FruitsScreen.screenroutes: (context) => const FruitsScreen(),
    meatScreen.screenroutes: (context) => const meatScreen(),
    seedsScreen.screenroutes: (context) => const seedsScreen(),
    vegetablesScreen.screenroutes: (context) => const vegetablesScreen(),
    woodScreen.screenroutes: (context) => const woodScreen(),
    Favorites.screenroutes: (context) => const Favorites(),
    Chario.screenroutes: (context) => const Chario(),
    FarmersProfilesScreen.screenroutes: (context) =>
    const FarmersProfilesScreen(),
    FarmDetailsScreen.screenroutes: (context) => const FarmDetailsScreen(),
    },
    );
  }
}
