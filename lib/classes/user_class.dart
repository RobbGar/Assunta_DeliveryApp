import 'package:flutter/cupertino.dart';
import 'order_class.dart';

class User extends ChangeNotifier{
  String uid;
  String name;
  String email;
  String surname;
  String address;
  DateTime birthDate;
  List<Order> orders;
  bool signedIn = false;


  User({this.uid, this.name, this.surname, this.address, this.birthDate, this.orders, this.email});



  void signIn(){
    signedIn = true;
    notifyListeners();
  }

  void logOut(){
    signedIn = false;
    notifyListeners();
  }
  bool noOrders(){
    return (orders == null || orders.length == 0);
  }

}
