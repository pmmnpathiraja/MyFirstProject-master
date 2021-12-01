import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lavajava/Screens/Customer/Orderdetails.dart';
import 'package:lavajava/Shared/screenNavigation.dart';
import 'package:lavajava/Widgets/CustomText.dart';
import 'package:lavajava/Models/Products.dart';
import 'package:lavajava/api/food_api.dart';
import 'package:lavajava/notifier/food_notifier.dart';
import 'package:provider/provider.dart';

List<Product> productsList = [
  Product(name: 'Meals', image: 'biriyani.jpg', wishList: true, price: 150),
  Product(name: 'Fast Food', image: 'burger.jpg', wishList: true, price: 150),
  Product(name: 'Meals', image: 'rice.jpg', wishList: false, price: 150),
  Product(name: 'Desserts', image: 'nasi.jpg', wishList: false, price: 150),
  Product(name: 'Beverages', image: 'hotdog.jpg', wishList: true, price: 150),
];

class Featured extends StatefulWidget {
//  Feed(this.userSet):super();
//  final UserData userSet;
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  void initState() {
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);
    //AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    User _firebaseUser = FirebaseAuth.instance.currentUser;
    getFoods(foodNotifier, _firebaseUser.displayName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User _firebaseUser = FirebaseAuth.instance.currentUser;
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    Future<void> _refreshList() async {
      getFoods(foodNotifier, _firebaseUser.displayName);
    }

    return Container(
      height: 250,
      child: RefreshIndicator(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: foodNotifier.foodList.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(12, 14, 16, 12),
                child: GestureDetector(
                  onTap: () {
                    //changeScreen(_, Details(product: productsList[index]));
                    foodNotifier.currentFood = foodNotifier.foodList[index];
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return Details();
                    }));
                  },
                  child: Container(
                    height: 260,
                    width: 220,
                    decoration: BoxDecoration(color: Colors.black, boxShadow: [
                      BoxShadow(
                          color: Colors.white38,
                          offset: Offset(1, 1),
                          blurRadius: 4)
                    ]),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 130,
                            width: double.infinity,
                            // color: Colors.yellow[800],
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50)),
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  // colorFilter: ColorFilter.mode(
                                  //     Colors.black.withOpacity(0.75), BlendMode.darken),
                                  image: NetworkImage(
                                    foodNotifier.foodList[index].image != null
                                        ? foodNotifier.foodList[index].image
                                        : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                  ),
                                )),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CustomText(
                                text: foodNotifier.foodList[index].image != null
                                    ? foodNotifier.foodList[index].name
                                    : '',
                                size: 16,
                                color: Colors.orange[100],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white38,
                                          offset: Offset(1, 1),
                                          blurRadius: 4)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 18,
                                      )
                                      // ? Icon(
                                      //     Icons.favorite,
                                      //     color: Colors.red,
                                      //     size: 18,
                                      //   )
                                      // : Icon(
                                      //     Icons.favorite_border,
                                      //     color: Colors.red,
                                      //     size: 18,
                                      //   ),
                                ),
                              ),
                            )
                          ],
                        ),
                        //SizedBox(height: 5),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                CustomText(
                                  text:
                                  foodNotifier.foodList[index].image != null
                                      ? foodNotifier.foodList[index].price
                                      : '',
                                  size: 18,
                                  color: Colors.orange,
                                  weight: FontWeight.bold,
                                  //family: "",
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
        onRefresh: _refreshList,
      ),
    );
  }
}
