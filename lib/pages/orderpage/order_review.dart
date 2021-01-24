
import 'package:assunta/classes/cart_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    var keys = cart.products.keys.toList();
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              
              slivers: <Widget>[
                SliverList(

                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 15, bottom: 10),
                        child: Text(
                          "Articoli",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 1
                          ),
                        ),
                      ),
                      for (int i = 0; i < keys.length; ++i)
                        ListTile(
                          leading: SizedBox(
                            height: 60,
                            width: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),

                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(2,3), color: Colors.grey.withOpacity(0.5), blurRadius: 5, spreadRadius: 2)
                                ]
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset('asset/${cart.products[keys[i]].product.dishURL}', fit: BoxFit.fill)
                              ),

                            ),
                          ),
                          title: Text(cart.products[keys[i]].product.name),
                          subtitle: Text(cart.products[keys[i]].quantity.toString() + " x " + cart.products[keys[i]].product.price.toStringAsFixed(2)),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.redAccent[100],
                            onPressed: () {
                              var elem = cart.products[keys[i]].product;
                              var quantity = cart.products[keys[i]].quantity;
                              cart.removeSingleFood(elem);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Articolo Rimosso"),
                                action: SnackBarAction(
                                  label: "Annulla",
                                  onPressed: () {
                                    cart.addFood(elem, quantity);
                                  },
                                ),
                              ));
                            },
                          ),
                        ),
                    ]
                  ),
                ),


              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Totale:  €${cart.totPrice.toStringAsFixed(2)}",
              ),
            ),
          )
        ],
      )
    );
  }
}

