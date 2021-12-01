import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lavajava/Widgets/CustomText.dart';
import 'package:lavajava/Models/Category.dart';
import 'package:lavajava/api/food_api.dart';
import 'package:lavajava/notifier/food_notifier.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
//  Feed(this.userSet):super();
//  final UserData userSet;
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
      height: 100,
      child:RefreshIndicator(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: foodNotifier.foodList.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(4, 6),
                          blurRadius: 20)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: 100,

                    width: 150,
                    // color: Colors.yellow[800],
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.50), BlendMode.darken),
                          // image: (
                          //   foodNotifier.foodList[index].image != null
                          //       ? foodNotifier.foodList[index].image
                          //       : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                          // ),
                          image: NetworkImage(
                            foodNotifier.foodList[index].image != null
                                ? foodNotifier.foodList[index].image
                                : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                          ),
                        )),
                    child: Center(
                      child: CustomText(
                        text:
                            //categoriesList[index].name,
                            foodNotifier.foodList[index].image != null
                                ? foodNotifier.foodList[index].name
                                : '',
                        color: Colors.white,
                        size: 23,
                        weight: FontWeight.w300,
                        family: '',
                      ),
                    ),
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
