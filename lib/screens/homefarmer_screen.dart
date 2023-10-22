import 'package:flutter/material.dart';
import 'package:messageme_app/screens/farmes.dart';
import 'package:messageme_app/screens/ordersscreen.dart';
import '../widgets/my_button.dart';
import 'manage_product_screen.dart';
import 'manage_profile_screen.dart';


class HomefarmerScreen extends StatefulWidget {
  static const String screenroutes = 'homefarmer_screen';

  @override
  _HomefarmerScreenState createState() => _HomefarmerScreenState();
}

class _HomefarmerScreenState extends State<HomefarmerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            
            Image.asset(
              'assets/tractor.png',
              width: 45,
              height: 45,
            ),
            Text('Farmer\'s Home'),
          ],
        ),
        backgroundColor:Color.fromARGB(255, 248, 147, 180), 
      ),
      
      body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children: [
           Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 0),
                child: Container(
                  height: 180,
                  child: Image.asset('assets/tractorbiglogo.png'),
                ),
              ),
             
            ],
          ),
          SizedBox(height: 45,),
          Mybutton(
            color: Color.fromARGB(255, 126, 184, 250),  
            title: 'Manage Profile',
            onPressed: (){
              Navigator.pushNamed(context, ManageProfileScreen.screenRoute);
            },
                 fontSize: 50,

          ),
          Mybutton(
            color: Color.fromARGB(255, 162, 255, 92),  
            title: 'Manage Product',
            onPressed: (){
              Navigator.pushNamed(context, ManageProductScreen.screenroutes);
            },
                 fontSize: 50,

          ),
          Mybutton(
            color: Color.fromARGB(255, 252, 157, 220),  
            title: 'View farmes',
            onPressed: (){
              Navigator.pushNamed(context,FarmersProfilesScreen.screenroutes);
            },
                 fontSize: 50,

          ),
           Mybutton(
            color: Color.fromARGB(255, 254, 245, 83),  
            title: 'View orders',
            onPressed: (){
              Navigator.pushNamed(context,OrdersScreen.screenroutes);
            },
                 fontSize: 50,

          ),
        ],
      ),
      ),
    );
     
   
  }
}
