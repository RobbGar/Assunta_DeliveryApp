import 'package:assunta/classes/cart_class.dart';
import 'package:assunta/classes/user_class.dart';
import 'package:assunta/pages/authpages/loading_page.dart';
import 'package:assunta/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<DropdownMenuItem> buildList(List list) => list.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList();

class OrderInfo extends StatefulWidget {
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  final _formKey = GlobalKey<FormState>();
  String _selectedDay = "14";
  String _selectedHour;
  bool loading = false;
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final noteController = TextEditingController();
  final civicController = TextEditingController();

  final _dayList = [
    "14","15"
  ];

  final _firstTimeList = [
    '19:00',
    '19:30',
    '20:00',
    '20:30',
    '21:00',
    '21:30'
  ];

  final _secondTimeList = [
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00'
  ];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return loading ? Loading() : SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Indirizzo"),
                  Expanded(child: Align(alignment: Alignment.centerRight,child: Text("Civico")))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: TextFormField(
                      controller: addressController,
                      validator: (value){
                        if (value.isEmpty){
                          return "Inserisci l'Indirizzo";
                        }
                        else
                          return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  Flexible(

                    child: TextFormField(
                      controller: civicController,
                      validator: (value){
                        if (value.isEmpty){
                          return "Inserisci l'Indirizzo";
                        }
                        else
                          return null;
                      },
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10),
              Text("Numero di Telefono"),
              Row(
                children: <Widget>[
                  Text("+39"),
                  SizedBox(width: 10,),
                  Flexible(
                    flex: 5,
                    child: TextFormField(

                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      validator: (value){
                        if(value.length != 10){
                          return 'Inserisci un numero di telefono valido';
                        }
                        if(value.isEmpty){
                          return "Inserisci il tuo numero di telefono";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text("Data di Consegna"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Giorno: "),
                  SizedBox(width: 10,),
                  DropdownButton(
                    value: _selectedDay,
                    items: buildList(_dayList),
                    onChanged: (e){
                      setState(() {
                        _selectedDay = e;
                        _selectedHour = null;
                      });
                    },
                  ),
                  SizedBox(width: 20,),
                  Text("Ora"),
                  SizedBox(width: 10,),
                  DropdownButton(
                    value: _selectedHour,
                    items: _selectedDay == "14" ? buildList(_firstTimeList) : buildList(_secondTimeList),
                    onChanged: (e){
                      setState(() {
                        _selectedHour = e;
                      });
                    },
                  ),
                ],
              ),
              Text("Note aggiuntive"),
              TextFormField(
                maxLines: 3,
                controller: noteController,
                validator: (value){
                  return null;
                },
              ),


              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: RaisedButton(
                    child: Text("Conferma"),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        setState(() {
                          loading = true;
                        });
                        User usr = Provider.of<User>(context);
                        Cart cart = Provider.of<Cart>(context);
                        var db = DatabaseService(uid: usr.uid);
                        dynamic result = db.insertOrder(cart.products,cart.totPrice, user, phoneController.text, addressController.text + ' ' + civicController.text, noteController.text, _selectedDay + ' Agosto ' + _selectedHour);
                        if (result == null){
                          setState(() {
                            loading = false;
                          });
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Errore, riprovare più tardi"),
                          ));
                        }
                        else{
                          setState(() {
                            loading = false;
                          });
                          cart.resetCart();
                          Navigator.pushReplacementNamed(context, '/finished');
                        }
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
