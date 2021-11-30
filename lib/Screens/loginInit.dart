

//import 'package:user/map/map_load.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lavajava/model/user.dart';
import 'package:lavajava/notifier/food_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lavajava/notifier/auth_notifier.dart';

import 'Authentication/signin.dart';
import 'Customer/CustomerHome.dart';


class LoginInit extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => FoodNotifier(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Emergency Informer',
         theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue,
       ),
             home: Consumer<AuthNotifier>(
                builder: (context, notifier, child) {
                 return notifier.user != null ? CustomerHome() : SignIn();
          },
        ),
     ),
    );
  }
}


