import 'package:assunta/classes/order_class.dart';
import 'package:assunta/pages/adds/clipper.dart';
import 'package:flutter/material.dart';

class SingleOrderPage extends StatelessWidget {
  final Order order;

  SingleOrderPage({this.order});

  @override
  Widget build(BuildContext context) {
    var totPrice = order.products.remove('Prezzo Totale');
    var date = order.products.remove('Data');
    var note = order.products.remove('Note');
    var status = order.products.remove('Stato');
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: 'image+${order.date}+${order.totPrice.toString()}',
                child: ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "asset/chiesa1.jpg"
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.5), offset: Offset(0,2), blurRadius: 6.0)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 20,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 30.0,
                  color: Colors.white,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                bottom: 60,
                left: 20,
                child: Text(
                  order.date,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(

              itemCount: order.products.length,
              itemBuilder: (context, index){

                var keys = order.products.keys.toList();
                var val = order.products[keys[index]];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Text(
                      keys[index] + ': ' + val.toString()
                    ),
                  ),
                );
              }
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0,-2),
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 6.0
                )
              ],
              color: Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Prezzo: €' + order.totPrice.toString(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 15
                  ),
                ),
                Text(
                  'Stato: ' + order.status,
                  style: TextStyle(
                      fontSize: 15
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
