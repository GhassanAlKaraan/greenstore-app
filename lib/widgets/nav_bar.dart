import 'package:flutter/material.dart';
import 'package:messageme_app/screens/chario.dart';
import 'package:messageme_app/screens/favorites.dart';

import '../screens/homeclient_screen.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onBottomNavigationBarTapped(BuildContext context, int index) {
      if (index == 0) {
        Navigator.of(context).pushReplacementNamed(HomeclientScreen.screenroutes);
      } else if (index == 1) {
        Navigator.of(context).pushReplacementNamed(Chario.screenroutes);
      } else if (index == 2) {
        Navigator.of(context).pushReplacementNamed(Favorites.screenroutes);
      }
    }

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: Color.fromARGB(255, 132, 131, 131),
      unselectedItemColor: Color.fromARGB(255, 132, 131, 131),
      onTap: (int index) {
        onBottomNavigationBarTapped(context, index);
      },
    );
  }
}
