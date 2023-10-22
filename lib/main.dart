import 'package:flutter/material.dart';
import 'package:messageme_app/category_screens.dart/animals.dart';
import 'package:messageme_app/category_screens.dart/dairy_products.dart';
import 'package:messageme_app/category_screens.dart/fruits.dart';
import 'package:messageme_app/category_screens.dart/meat_products.dart';
import 'package:messageme_app/category_screens.dart/seeds.dart';
import 'package:messageme_app/category_screens.dart/wood.dart';
import 'package:messageme_app/screens/add_product.dart';
import 'package:messageme_app/screens/chario.dart';
import 'package:messageme_app/screens/farmes.dart';
import 'package:messageme_app/screens/favorites.dart';
import 'package:messageme_app/screens/homeclient_screen.dart';
import 'package:messageme_app/screens/homefarmer_screen.dart';
import 'package:messageme_app/screens/manage_product_screen.dart';
import 'package:messageme_app/screens/manage_profile_screen.dart';
import 'package:messageme_app/screens/ordersscreen.dart';
import 'package:messageme_app/screens/product.dart';
import 'package:messageme_app/screens/profiledetailscreen.dart';
import 'package:messageme_app/signloginScreens.dart/registration_screen.dart';
import 'package:messageme_app/signloginScreens.dart/registrationclient_scrreen.dart';

import 'package:messageme_app/category_screens.dart/vegetables.dart';
import 'package:messageme_app/signloginScreens.dart/signin_screen.dart';
import 'package:messageme_app/signloginScreens.dart/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
 
      ],
      child: MyApp(),
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
      //home:FarmersProfilesScreen(),
      // home:HomefarmerScreen(),
      //home: Allproductscreen(),
      //home: Favorites(),
       // home: SignInScreen.screenRoute,
       initialRoute: WelcomeScreen.screenroutes,
      //home:RegistratioScreen(),
      routes:{
        WelcomeScreen.screenroutes: (context)=>WelcomeScreen(),
        SignInScreen.screenRoute: (context)=>SignInScreen(),
        RegistrationScreen.screenroutes: (context)=>RegistrationScreen(),
        RegistrationclientScreen.screenroutes: (context)=>RegistrationclientScreen(),
        HomeclientScreen.screenroutes: (context)=>HomeclientScreen(),
        HomefarmerScreen.screenroutes: (context) => HomefarmerScreen(),
        ManageProductScreen.screenroutes: (context) => ManageProductScreen(),
        ManageProfileScreen.screenRoute: (context) => ManageProfileScreen(),
        OrdersScreen.screenroutes: (context) => OrdersScreen(),
        AddProductScreen.screenroutes: (context) => AddProductScreen(),
        animalsScreen.screenroutes: (context) => animalsScreen(),
        dairyScreen.screenroutes: (context) => dairyScreen(),
        fruitsScreen.screenroutes: (context) => fruitsScreen(),
        meatScreen.screenroutes: (context) => meatScreen(),
        seedsScreen.screenroutes: (context) => seedsScreen(),
        vegetablesScreen.screenroutes: (context) => vegetablesScreen(),
        woodScreen.screenroutes: (context) => woodScreen(),
        Favorites.screenroutes: (context) => Favorites(),
        Chario.screenroutes: (context) => Chario(),
        FarmersProfilesScreen.screenroutes: (context) => FarmersProfilesScreen(),
        farmdetailsscreen.screenroutes: (context) => farmdetailsscreen(),

       
       } ,
    );
  }
}

