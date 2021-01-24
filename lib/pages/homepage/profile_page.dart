
import 'package:assunta/classes/order_class.dart';
import 'package:assunta/classes/user_class.dart';
import 'package:assunta/pages/adds/rounded_title.dart';
import 'package:assunta/pages/homepage/single_order_page.dart';
import 'package:assunta/services/auth.dart';
import 'package:assunta/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    user.orders = Provider.of<List<Order>>(context);
    return StreamProvider<List<Order>>.value(
      catchError: (e,ee){print(e.toString() + ee.toString()); return null;},
      value: DatabaseService(uid: user.uid).orderList,
      child: Column(
        children: <Widget>[
          /*TITLE BAR*/
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                  child: RoundedTitle(title: "Profilo")
              ),
              Positioned(

                height: 60,
                top: 205,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 8,
                          spreadRadius: 3,
                          color: Colors.grey.withOpacity(0.5))
                    ]
                  ),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    child: Text(user.name[0].toUpperCase() + user.surname[0].toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ),
              ),



            ],
          ),
          /*I TUOI ORDINI LABEL*/
          Align(
            alignment: FractionalOffset.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
              child: Text(
                "I TUOI ORDINI",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11
                ),
              ),
            ),
          ),

          /*ORDER LIST BEGIN*/
          if (user.noOrders())
            Text(
              "Nessun ordine effettuato",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 14,
                letterSpacing: 0.6
              ),
            )
          else

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<User>(
                builder: (context, user, index) {
                  return SizedBox(
                    height: 120,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,

                      children: <Widget>[
                        for (var elem in user.orders)
                          Row(
                            children: <Widget>[
                              OrderCard(order: elem),
                              SizedBox(width: 15)
                            ],
                          ),




                      ],
                    ),
                  );
                }
              ),
            ),
          /*ORDER LIST END*/

          /* LOGOUT BUTTON */

          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(

                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Theme.of(context).buttonColor,
                          )
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.all(10),
                          color: Colors.transparent,
                          onPressed: () {
                            _auth.signOut();
                            user.logOut();
                          },
                          child: Text(
                            "Esci"
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )



        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({this.order});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(offset: Offset(1,2), color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 1)
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        child: Stack(
          children: <Widget>[

            ClipRRect(
              borderRadius: BorderRadius.circular(20),child: Hero(tag: 'image+${order.date}+${order.totPrice.toString()}', child: Image.asset('asset/chiesa1.jpg', fit: BoxFit.fill,))
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration:BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))
                ),
                width: 120,
                height: 40,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        order.date,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13
                        ),
                      ),
                      Text(
                        order.status,
                        style: TextStyle(
                          color: order.status == "Confermato" ? Colors.green : Colors.white,
                          fontSize: 13
                        ),
                      )
                    ],
                  ),
                ),

              ),
            ),

          ]
        ),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SingleOrderPage(order: order)),
          );
        },
      ),
    );
  }
}

