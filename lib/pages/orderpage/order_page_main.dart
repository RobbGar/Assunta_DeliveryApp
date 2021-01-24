import 'package:animations/animations.dart';
import 'package:assunta/pages/orderpage/order_info.dart';
import 'package:assunta/pages/orderpage/order_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}



class _OrderPageState extends State<OrderPage> {
  int count = 0;
  var _pages = [
    OrderReview(),
    OrderInfo()
  ];

  var _titles = [
    "Riepilogo Ordine",
    "Informazioni sull'Ordine"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[count]),
      ),
      body: PageTransitionSwitcher(
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
        child: _pages[count],
      ),
      bottomNavigationBar: _createNavBar(),

    );
  }

  Widget _createNavBar(){
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(0,-1),
              blurRadius: 1,
            )
          ],
          color: Colors.white
        ),
        padding: EdgeInsets.all(10),
        child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    color: Colors.transparent,
                    child: Text("Indietro"),
                    onPressed: () {
                      if (count > 0)
                      setState(() {
                          count--;
                      });
                    },
                  ),
                  if(count != 1)
                  FlatButton(
                    color: Theme.of(context).buttonColor,
                    child: Text("Avanti"),
                    onPressed: (){
                      if (count < _pages.length-1)
                      setState(() {
                        count++;
                      });

                    },
                  )

                ],
              ),
        ),
      );
  }
}

