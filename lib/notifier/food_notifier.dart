import 'dart:collection';

import 'package:lavajava/model/food.dart';
import 'package:flutter/cupertino.dart';

class FoodNotifier with ChangeNotifier {
  List<Food> _foodList = [];
  List<Food> _cartList =[];
  Food _currentFood;

  UnmodifiableListView<Food> get foodList => UnmodifiableListView(_foodList);
  UnmodifiableListView<Food> get cartList => UnmodifiableListView(_cartList);

  Food get currentFood => _currentFood;

  set foodList(List<Food> foodList) {
    _foodList = foodList;
    notifyListeners();
  }

  set cartList(List<Food> cartList) {
    _cartList = cartList;
    notifyListeners();
  }

  set currentFood(Food food) {
    _currentFood = food;
    notifyListeners();
  }

  addFood(Food food) {
    _foodList.insert(0, food);
    notifyListeners();
  }

  addCart(Food _cart) {
    _cartList.insert(0, _cart);
    notifyListeners();
  }

  deleteFood(Food food) {
    _foodList.removeWhere((_food) => _food.id == food.id);
    notifyListeners();
  }

  deleteCart(Food _cart) {
    _cartList.removeWhere((_cart) => _cart.id == _cart.id);
    notifyListeners();
  }
}
