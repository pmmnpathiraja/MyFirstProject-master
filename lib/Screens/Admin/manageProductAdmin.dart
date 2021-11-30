import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lavajava/Models/Products.dart';
import 'package:lavajava/Screens/Admin/Images/uploadImage.dart';
import 'package:lavajava/Widgets/CustomText.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ManageProductAdmin extends StatefulWidget {
  ManageProductAdmin() : super();

  @override
  _ManageProductAdminState createState() => _ManageProductAdminState();
}

class _ManageProductAdminState extends State<ManageProductAdmin> {
  TextEditingController productNameContoller = TextEditingController();
  TextEditingController productDescriptionContoller = TextEditingController();
  TextEditingController productPriceContoller = TextEditingController();
  TextEditingController productCategoryContoller = TextEditingController();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('product');

  bool texiFieldVisibility = true;

  Product currentProduct;

  addProduct() {
    Product product = Product(
      name: productCategoryContoller.text,
      image: "image",
      description: productDescriptionContoller.text,
      wishList: false,
      price: int.parse(productPriceContoller.text),
      category: productDescriptionContoller.text,
    );
  }

  button1() {
    return SizedBox(
      width: double.infinity,
      child: OutlineButton(
        child: Text("ADD"),
        onPressed: () async {
          await collectionReference.add({
            'pname': productNameContoller.text,
            'pdescription': productDescriptionContoller.text,
            'price': int.parse(productPriceContoller.text),
            'category': productCategoryContoller.text,
            'wishList': false,
            'plink': "fmjfff"
          }).then((value) => {
                productNameContoller.clear(),
                productDescriptionContoller.clear(),
                productPriceContoller.clear(),
                productCategoryContoller.clear()
              });
        },
      ),
    );
  }

  button() {
    return SizedBox(
      width: double.infinity,
      child: OutlineButton(
          child: Text("UPLOAD IMAGE"),
          onPressed: () {
            // Navigator.pushReplacementNamed(context, "UploadImage");
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Manage Products"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextFormField(
                      controller: productNameContoller,
                      decoration: InputDecoration(labelText: "Name"),
                    ),
                    TextFormField(
                      controller: productDescriptionContoller,
                      decoration: InputDecoration(labelText: "Description"),
                    ),
                    TextFormField(
                      controller: productPriceContoller,
                      decoration: InputDecoration(labelText: "Price"),
                    ),
                    TextFormField(
                      controller: productCategoryContoller,
                      decoration: InputDecoration(labelText: "Category"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                button(),
                SizedBox(
                  height: 10,
                ),
                button1()
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomText(text: "Products"),
            Expanded(
                child: StreamBuilder(
                    stream: collectionReference.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                          children: snapshot.data.docs
                              .map((e) => ListTile(
                                    title: Text(e['pname']),
                                  ))
                              .toList(),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
