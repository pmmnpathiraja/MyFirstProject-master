import 'package:flutter/material.dart';
import 'package:lavajava/Screens/Authentication/Register.dart';
import 'package:lavajava/Screens/Customer/CustomerHome.dart';
import 'package:lavajava/Screens/Services/auth.dart';
import 'package:lavajava/Shared/constants.dart';
import 'package:lavajava/Shared/loading.dart';
import 'package:lavajava/Screens/home.dart';
import 'package:lavajava/api/food_api.dart';
import 'package:lavajava/model/user.dart';
import 'package:lavajava/notifier/auth_notifier.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  UserData _user = UserData();
  String error = '';

  String email = '';
  String passward = '';

  @override
  void initState() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);

    initializeCurrentUser(authNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            // appBar: AppBar(
            //   backgroundColor: Colors.black,
            //   elevation: 0.0,
            //   title: Text('Sign in to LavaJava'),
            //   actions: <Widget>[
            //     FlatButton.icon(
            //       color: Colors.yellow[800],
            //       label: Text('Register'),
            //       icon: Icon(
            //         Icons.person,
            //       ),
            //       onPressed: () {
            //         widget.toggleView();
            //       },
            //     )
            //   ],
            // ),
            body: Column(
              children: <Widget>[
                Container(
                    height: 150.0,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20),
                    decoration: new BoxDecoration(
                        color: Colors.yellow[800],
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(80),
                        )),
                    child: Column(children: <Widget>[
                      Container(
                        height: 10,
                        color: Colors.yellow[800],
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, "Home");
                              },
                              color: Colors.yellow[800],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )),
                      ),
                      Center(
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                            fontFamily: 'KaushanScript',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'Hello Customer!!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Caveat',
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Add your details to login..',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Caveat',
                          ),
                        ),
                      ),
                    ])),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          style: TextStyle(color: Colors.white),
                          decoration:
                              textInputDecprations.copyWith(hintText: 'Email'),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: (val) => val.length < 6
                              ? 'Enter an password 6+ chars long'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => passward = val);
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: textInputDecprations.copyWith(
                              hintText: 'Password'),
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                            color: Colors.yellow[800],
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                // dynamic result =
                                //     await _auth.signInWithEmailAndPassword(
                                //         email, passward);
                                //
                                // if (result == null) {
                                //   setState(() {
                                //     error = 'Could not sign in';
                                //     loading = false;
                                //   });
                                // } else {
                                //   setState(() => loading = false);
                                //   Navigator.pushReplacementNamed(
                                //       context, "CustomerHome");
                                // }
                                AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
                                _user.email = email;
                                _user.password = passward;
                                  login(_user, authNotifier);
                              }
                            }),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        SizedBox(height: 12.0),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'New Customer?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'Caveat'),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (BuildContext context) {
                                      return Register();
                                    }));
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Caveat'),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
