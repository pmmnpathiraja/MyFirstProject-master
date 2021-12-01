import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lavajava/Models/Products.dart';
import 'package:lavajava/Widgets/CustomText.dart';
import 'package:lavajava/api/food_api.dart';
import 'package:lavajava/model/food.dart';
import 'package:lavajava/notifier/food_notifier.dart';
import 'package:provider/provider.dart';

import 'confirmOrder.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  // Product product =
  //     Product(name: 'Meals', image: 'biriyani.jpg', wishList: true, price: 150);

  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    _onFoodDeleted(Food food) {
      // Navigator.pop(context);

      foodNotifier.deleteCart(food);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "Shopping Cart",
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: foodNotifier.cartList.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(color: Colors.black, boxShadow: [
                    BoxShadow(
                        color: Colors.white10,
                        offset: Offset(3, 2),
                        blurRadius: 30)
                  ]),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                        child: Container(
                          height: 100,
                          width: 100,
                          // color: Colors.yellow[800],
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.50),
                                    BlendMode.darken),
                                // image: (
                                //   foodNotifier.foodList[index].image != null
                                //       ? foodNotifier.foodList[index].image
                                //       : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                // ),
                                image: NetworkImage(
                                  foodNotifier.cartList[index].image != null
                                      ? foodNotifier.cartList[index].image
                                      : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                ),
                              )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: foodNotifier.cartList[index].name + "\n",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),),
                            TextSpan(
                                text: "\Rs." +
                                    foodNotifier.cartList[index].amount
                                        .toString() +
                                    "\n",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17))

                          ])),
                          SizedBox(
                            width:5 ,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                List<Food> _cartList = [];
                                foodNotifier.cartList.forEach((document) {
                                  _cartList.add(document);
                                });
                                _cartList.removeAt(index);
                                foodNotifier.cartList = _cartList;
                              })
                        ],
                      )
                    ],
                  ),
                ),
              );

            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          double total = 0;
          foodNotifier.cartList.forEach((document) {
            total = total + document.amount;
          });
          foodNotifier.currentFood;
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return ConfirmOrder(total);
            }),
          );
        },
        child: Icon(Icons.attach_money_outlined),
        foregroundColor: Colors.white,
      ),
    );
  }
}
