import 'package:animations/animations.dart';
import 'package:assunta/classes/order_class.dart';
import 'package:assunta/classes/user_class.dart';
import 'package:assunta/pages/homepage/info_page.dart';
import 'package:assunta/pages/homepage/profile_page.dart';
import 'package:assunta/services/database.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';
import 'food_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  bool _rightMovement = true;

  final _pageOptions = [FoodPage(), CartPage(), Profile(), InfoPage()];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return StreamProvider<List<Order>>.value(
      catchError: (e,ee){print(e.toString()); print(ee.toString()); return null;},
      value: DatabaseService(uid: Provider.of<User>(context).uid).orderList,
      child: Scaffold(
        body: PageTransitionSwitcher(
          reverse: !_rightMovement,
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
            );
          },
          child: _pageOptions[_current],
        ),
        bottomNavigationBar: BottomNavyBar(
          showElevation: !(_current == 1) ? true: false,
          containerHeight: 75,
          selectedIndex: _current,
          onItemSelected: (index) {
            setState(() {
              if (index > _current)
                _rightMovement = true;
              else
                _rightMovement = false;
              _current = index;
            });
          },
          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.local_dining),
                title: Text("Ordina"),
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Carrello"),
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.black,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text(
                  "Personale",
                ),
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.info),
                title: Text("Info"),
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Colors.black)
          ],
        ),
      ),
    );
  }
}
