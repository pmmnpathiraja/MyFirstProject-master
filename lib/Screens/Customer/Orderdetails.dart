import 'package:flutter/material.dart';
import 'package:lavajava/Models/Products.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:lavajava/Widgets/CustomText.dart';
import 'package:lavajava/notifier/food_notifier.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class Details extends StatefulWidget {
  // final Product product;
  //
  // Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  double amount= 0 ;
  void calculator(String price){
    print('cal');
    setState(() {
      double value = double.parse(price);
      amount = amount + value;
      print(amount);
    });
  }
  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: Stack(children: <Widget>[
              Carousel(
                images: [
                  NetworkImage(
                    foodNotifier.currentFood.image != null
                        ? foodNotifier.currentFood.image
                        : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                  ),
                ],
                dotBgColor: Colors.black,
                dotColor: Colors.white,
                dotIncreasedColor: Colors.orange,
                dotIncreaseSize: 1.2,
                autoplay: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "ShoppingCart");
                      },
                    ),
                  )
                ],
              )
            ]),
          ),
          CustomText(
            text: foodNotifier.currentFood.name,
            size: 24,
            weight: FontWeight.bold,
          ),
          CustomText(
            text: "\Rs." + foodNotifier.currentFood.price,
            size: 18,
            weight: FontWeight.w300,
            color: Colors.orange[100],
          ),
          SizedBox(
            height: 20,
          ),
          CustomText(
            text: "DESCRIPTION",
            size: 20,
            weight: FontWeight.w300,
            color: Colors.white,
          ),
          SizedBox(
            height: 4,
          ),
          CustomText(
            text: foodNotifier.currentFood.description,
            size: 10,
            weight: FontWeight.w300,
            color: Colors.orange[100],
          ),
          SizedBox(
            height:20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(
                      Icons.remove,
                      size: 28,
                    ),
                    onPressed: () {}),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 24, 12),
                      child: GestureDetector(
                        onTap: () {
                          foodNotifier.currentFood.amount = amount;
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return ShoppingCart();
                          }));
                        },
                        child: CustomText(
                            text: "Add to cart", color: Colors.white, size: 24),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 28,
                      color: Colors.red[300],
                    ),
                    onPressed: ()=> calculator(foodNotifier.currentFood.price)),
              ),
            ],
          ),
          SizedBox(
            height:20,
          ),
          CustomText(
            text: amount == 0 ? '' : '$amount',
            size: 10,
            weight: FontWeight.w300,
            color: Colors.orange[100],
          ),
        ],
      ),
    );
  }
}
