import 'package:assunta/classes/cart_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assunta/classes/food_class.dart';
import 'package:provider/provider.dart';

class ModalColumn extends StatefulWidget {
  ModalColumn({this.dish,this.quantity});
  final Food dish;
  final int quantity;

  @override
  _ModalColumnState createState() => _ModalColumnState(dish: dish,quantity: quantity);
}

class _ModalColumnState extends State<ModalColumn> {
  final Food dish;
  double _totPrice;
  int quantity;
  _ModalColumnState({this.dish, this.quantity});
  @override
  void initState() {
    super.initState();
    _totPrice = quantity * dish.price;
  }


  @override
  Widget build(BuildContext context) {
         return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //Dish Name
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5),
              child: Text(
                dish.name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            //Dish Price
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
              child: Text(
                "€ ${dish.price.toStringAsFixed(2)}",
                style: TextStyle(
                    color: Colors.green[200],
                    fontWeight: FontWeight.bold
                ),
              ),
            ),


            //Dish Image
            Container(
                height: 150,
                width: 150,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          color: Colors.grey.withOpacity(0.5))
                    ],
                  image: DecorationImage(
                    image: AssetImage(
                      'asset/${dish.dishURL}'

                      //dish.dishURL
                    ),
                    fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent
                ),
            ),

            //Divider(height: 10, thickness: 1, indent: 20, endIndent: 20),

            //Quantity_Row
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    splashColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        if (quantity > 0) quantity--;
                        _totPrice = quantity * dish.price;
                      });
                    },
                  ),

                  Text(quantity.toString()),

                  IconButton(
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.add),
                    onPressed: () {
                        setState(() {
                          quantity ++;
                          _totPrice = quantity * dish.price;
                        });

                    },
                  )
                ],
              ),
            ),


            Text(
              "€ ${_totPrice.toStringAsFixed(2)}",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold
              ),
            ),


            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 10, left: 10, bottom: 10, top: 10),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Text("Aggiungi al carrello"),
                      color: Theme.of(context).buttonColor,
                      onPressed: () {
                        if (quantity != 0) {
                          var cart = Provider.of<Cart>(context);
                          cart.addFood(dish, quantity);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        );
  }
}
