import 'package:flutter/Material.dart';

class OrderSucess extends StatelessWidget {
  const OrderSucess({Key key}) : super(key: key);

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
                        child: Center(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 450),
                            child: Text(
                              "Your order is successfully placed",
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
                      ),
                      Text(
                        'Thank You',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KaushanScript'),
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
                        Column(
                          children: [
                            Container(
                              child: TextButton(
                                onPressed: () {
                                  // order id eka yatathe user Id ekath eka feedback table ekata yanna oni feedback eka
                                  Navigator.pushReplacementNamed(
                                      context, "CustomerFeedback");
                                },
                                child: Text(
                                  'Give Feedback',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'KaushanScript'),
                                ),
                              ),
                            ),
                            Container(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "Menu");
                                },
                                child: Text(
                                  'Go back to Home',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // FlatButton.icon(
                  //   icon: Icon(Icons.person),
                  //   label: Text('logout'),
                  //   onPressed: () async {
                  //     await _auth.signOut();
                  //     Navigator.of(context)
                  //         .push(MaterialPageRoute(builder: (_) {
                  //       return Home();
                  //     }));
                  //   },
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
