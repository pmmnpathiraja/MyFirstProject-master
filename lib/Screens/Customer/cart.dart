import 'package:flutter/material.dart';
import 'package:lavajava/Models/Products.dart';
import 'package:lavajava/Widgets/CustomText.dart';
import 'package:lavajava/notifier/food_notifier.dart';
import 'package:provider/provider.dart';

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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 120,
              decoration: BoxDecoration(color: Colors.black, boxShadow: [
                BoxShadow(
                    color: Colors.red[100],
                    offset: Offset(3, 2),
                    blurRadius: 30)
              ]),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Container(
                      height:100 ,
                      width: 100,
                      // color: Colors.yellow[800],
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.50), BlendMode.darken),
                            // image: (
                            //   foodNotifier.foodList[index].image != null
                            //       ? foodNotifier.foodList[index].image
                            //       : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                            // ),
                            image: NetworkImage(
                              foodNotifier.currentFood.image != null
                                  ? foodNotifier.currentFood.image
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
                            text: foodNotifier.currentFood.name + "\n",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        TextSpan(
                            text: "\Rs." + foodNotifier.currentFood.amount.toString() + "\n",
                            style: TextStyle(color: Colors.white, fontSize: 17))
                      ])),
                      SizedBox(
                        width: 30,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {})
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
                child: Text("PLACE ORDER"),
                color: Colors.yellow,
                onPressed: () {
                  //order eka place kalama address eka illana screen ekata gihin e address ekath ekka order details order table ehata yanna oni user id eka yatathe
                  Navigator.pushReplacementNamed(context, "ConfirmOrder");
                }),
          )
        ],
      ),
    );
  }
}
