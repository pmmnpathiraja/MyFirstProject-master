import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lavajava/Screens/Customer/orderSuccess.dart';
import 'package:lavajava/notifier/food_notifier.dart';
import 'package:provider/provider.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder(this.total, {Key key}) : super(key: key);
final double total;
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  TextEditingController orderAddressContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    Future<void> uploadData() async {
      var time = Timestamp.now();
      CollectionReference foodRef = FirebaseFirestore.instance.collection('Order').doc(FirebaseAuth.instance.currentUser.email).collection(orderAddressContoller.text+'     $time');
      foodNotifier.cartList.forEach((document) async {
        await foodRef.add(document.toMap());
      });
      foodRef.doc('General').set({'TimeStamp': time,'Address':orderAddressContoller.text});
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            height: 750.0,
            width: double.infinity,
            color: Colors.black,
            child: Container(
              height: 100.0,
              width: double.infinity,
              // color: Colors.yellow[800],
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fitHeight,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.75), BlendMode.darken),
                image: AssetImage(
                  "asset/lavajava.jpg",
                ),
              )),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 100),
                          child: Text(
                            "${widget.total}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.yellow,
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              fontFamily: 'KaushanScript',
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 100),
                          child: Text(
                            "Enter your Address",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.yellow,
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              fontFamily: 'KaushanScript',
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 50),
                          child: TextFormField(
                            controller: orderAddressContoller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              labelText: "Address",
                              counterText: "",
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: () {
                              //Address eka ekka order details DB ekata Yannaoni User Email ekath ekka
                              //order details wada ada date ekay time ekay thiyenna oni
                              if(orderAddressContoller.text != null){
                                uploadData();
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) {
                                    return OrderSucess();
                                  }),
                                );
                              }
                            },
                            child: Text(
                              'Confirm Order',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'KaushanScript'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
