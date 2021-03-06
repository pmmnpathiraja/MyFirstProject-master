import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lavajava/main.dart';

class CustomerFeedback extends StatefulWidget {
  const CustomerFeedback({Key key}) : super(key: key);

  @override
  _CustomerFeedbackState createState() => _CustomerFeedbackState();
}

class _CustomerFeedbackState extends State<CustomerFeedback> {
  TextEditingController orderFeedbackContoller = TextEditingController();
  Future<void> uploadData() async {
    var time = Timestamp.now();
    CollectionReference foodRef = FirebaseFirestore.instance.collection('Feedback').doc(FirebaseAuth.instance.currentUser.email).collection( "$time");
    foodRef.doc('Feedback').set({'TimeStamp': time,'Feedback':orderFeedbackContoller.text});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            height: 750.0,
            width: double.infinity,
            color: Colors.black,
            child: Container(
              height: 750.0,
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
                          height: 500,
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 450),
                          child: Text(
                            "Give your Feedback",
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
                            controller: orderFeedbackContoller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              labelText: "Feedback",
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
                              if(orderFeedbackContoller.text != null){
                                uploadData();
                              }
                              //orderId eka yatathe Feedback kiyata table ekatata feedback eka yanna oni user ID ekath ekka
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return MyApp();
                                }),
                              );
                            },
                            child: Text(
                              'Send Feedback',
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
