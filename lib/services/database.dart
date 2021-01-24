import 'package:assunta/classes/food_class.dart';
import 'package:assunta/classes/order_class.dart';
import 'package:assunta/classes/user_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  /*Collection References*/
  final CollectionReference foodCollection = Firestore.instance.collection('food');
  final CollectionReference userCollection = Firestore.instance.collection('user');
  final CollectionReference orderCollection = Firestore.instance.collection('orders');

  /*Getters*/
  Future<DocumentSnapshot> get userData async{
    return userCollection.document(uid).get().then((value) => value);
  }

  Stream<List<Food>> get foodData {
    return foodCollection.snapshots().map(_foodListFromSnapshot);
  }

  Stream<List<Order>> get orderList{
    var snap =  orderCollection.document(uid).collection('orders').snapshots();
        return snap.map(_orderListFromSnapshot);
  }

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot){
    return (snapshot.documents.map((e) {
      Order order = new Order();
      order.products = new Map();
      order.status = e.data['Stato'];
      order.totPrice = e.data['Prezzo Totale'];
      order.date = e.data['Data'];
      order.products = (e.data);
      return order;
    }).toList());
  }


  List<Food> _foodListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((e) => Food(name: e.data['name'], description: e.data['description'], price: e.data['price'], available: e.data['available'], dishURL: e.data['dishURL'], type: e.data['type'])).toList();
  }


  Future updateUserData(String name, String surname) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'surname': surname
    });
  }

  Future insertOrder(Map cart, double totPrice, User user, String phoneNumber, String address, String note, String data) async {
    await orderCollection.document(uid).setData({
      'name': user.name,
      'surname': user.surname,
      'email': user.email,
      'phone': phoneNumber,
      'address': address
    });
    Map<String, String> _map = cart.map((key, value) => MapEntry(key, value.quantity.toString()));
    _map['Prezzo Totale'] = totPrice.toStringAsFixed(2);
    _map['Note'] = note;
    _map['Stato'] = 'Da Confermare';
    _map['Data'] = data;

    return await orderCollection.document(uid).collection('orders').add(_map);

  }

}