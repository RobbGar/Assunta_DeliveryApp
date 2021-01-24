
import 'package:assunta/classes/cart_class.dart';
import 'package:assunta/pages/adds/rounded_title.dart';
import 'package:assunta/pages/orderpage/order_page_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              //Title

              SliverList(delegate: SliverChildListDelegate([RoundedTitle(title: "Carrello")])),
              //list_cart
              CartList(),

              //Bottom bar
              SliverList(
                delegate: SliverChildListDelegate([
                ]
                )
              )

            ],
          ),
        ),
        Consumer<Cart>(
            builder: (context, cart, index) {
              return Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(spreadRadius: 1,blurRadius: 4,color: Colors.grey.withOpacity(0.3), offset: Offset(0,-2))
                      ]
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Totale: ",
                            style: TextStyle(
                                fontSize: 14
                            ),
                          ),
                          Text(
                            "€ ${cart.totPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 60,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                color: Theme.of(context).buttonColor,
                                child: Text("Completa Ordine"),
                                onPressed: () {
                                  if(cart.isEmpty()) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Carrello Vuoto"),
                                      action: SnackBarAction(
                                          label: "OK", onPressed: () {}),
                                    ));
                                  }
                                  else{
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => OrderPage()),
                                    );
                                  }

                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        ),

      ],
    );
  }
}




class CartList extends StatefulWidget {

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {

    var cart = Provider.of<Cart>(context);

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index){
                var keys = cart.products.keys.toList();
                var val = cart.products[keys[index]];
                if (cart.isEmpty())
                  return Text("Carrello vuoto");

                else
                return Column(
                  children: <Widget>[

                    Dismissible(
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent[100]
                        ),
                        child: Center(child: Text("Elimina")),
                      ),
                      key: Key(val.product.name),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                          cart.removeSingleFood(val.product);
                      },
                      child: ListTile(
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.redAccent[100],
                          onPressed: () {
                              cart.removeSingleFood(val.product);

                          },
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(val.quantity.toString() + " x " + val.product.name),

                              Text(
                                (val.product.price*val.quantity).toStringAsFixed(2),
                                style: TextStyle(
                                color: Colors.green
                                ),
                              )
                            ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              childCount: cart.numElem,
            ),
          );
  }
}

