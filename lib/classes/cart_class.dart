import 'package:assunta/classes/food_class.dart';
import 'dart:core';
import 'package:flutter/cupertino.dart';

class Cart extends ChangeNotifier{
  Map<String, Pair> products;
  int numElem;
  double totPrice = 0;


  Cart() {
    products = new Map();
    totPrice = 0;
    numElem = 0;
  }



  bool isEmpty(){
    return products.isEmpty;
  }

  void resetCart(){
    products = new Map();
    totPrice = 0;
    numElem = 0;
    notifyListeners();
  }



  void addFood(Food product, int quantity) {
    var tmp = products[product.name];
    if (tmp != null) {
      totPrice += (quantity - tmp.quantity)*product.price;
      tmp.quantity = quantity;
    }
    else {
      products[product.name] = new Pair(product: product, quantity: quantity);
      numElem++;
      totPrice += products[product.name].product.price*products[product.name].quantity;
    }
    notifyListeners();
  }

  void removeFood(Food product, int quantity) {
    totPrice -= quantity *product.price;
    products[product.name].quantity -= quantity;
    notifyListeners();
  }

  void removeSingleFood(Food product){
    totPrice -= products[product.name].quantity*product.price;
    products.remove(product.name);
    numElem--;
    notifyListeners();
  }

  void removeAll() {
    products.clear();
    numElem = 0;
    notifyListeners();
  }

  int getQuantity(Food dish){
    if (products[dish.name] == null) return 0;
    else
      return products[dish.name].quantity;
  }
}



class Pair{
  Food product;
  int quantity;

  Pair({this.quantity, this.product});

  void add(int num){
    quantity = quantity + num;
  }
}


