import 'dart:io';

import 'package:lavajava/model/food.dart';
import 'package:lavajava/model/user.dart';
import 'package:lavajava/notifier/auth_notifier.dart';
import 'package:lavajava/notifier/food_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

login(UserData user, AuthNotifier authNotifier) async {
  UserCredential authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    User firebaseUser = authResult.user;

    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(authResult.user);
    }
  }
}

signUp(UserData user, AuthNotifier authNotifier) async {
  UserCredential authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    User firebaseUser = authResult.user;

    if (firebaseUser != null) {
      await firebaseUser.updateProfile(displayName: user.displayUserName);
      await firebaseUser.reload();

      print("Sign up: $firebaseUser");

      User currentUser = FirebaseAuth.instance.currentUser;
      authNotifier.setUser(currentUser);
    }
  }
}

signOut(User firebaseUser) async {
  await FirebaseAuth.instance.signOut().catchError((error) => print(error.code));
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  User firebaseUser = FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

getFoods(FoodNotifier foodNotifier,String userNIC) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Products').doc('Reports').collection('piyumikathisari@gmail.com')
      .orderBy("createdAt", descending: true).get();

  List<Food> _foodList = [];

  snapshot.docs.forEach((document) {
    Food food = Food.fromMap(document.data());
    _foodList.add(food);
  });

  foodNotifier.foodList = _foodList;
}

uploadFoodAndImage(Food food, bool isUpdating, File localFile, Function foodUploaded,String userNIC) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('Products/$userNIC/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile).catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadFood(food, isUpdating, foodUploaded, userNIC ,imageUrl: url);
  } else {
    print('...skipping image upload');
    _uploadFood(food, isUpdating, foodUploaded,userNIC);
  }
}

_uploadFood(Food food, bool isUpdating, Function foodUploaded,String userNIC, {String imageUrl}) async {
  CollectionReference foodRef = FirebaseFirestore.instance.collection('Products').doc('Reports').collection('piyumikathisari@gmail.com');

  if (imageUrl != null) {
    food.image = imageUrl;
  }

  if (isUpdating) {
    food.updatedAt = Timestamp.now();

    await foodRef.doc(food.id).update(food.toMap());

    foodUploaded(food);
    print('updated report with id: ${food.id}');
  } else {
    food.createdAt = Timestamp.now();

    DocumentReference documentRef = await foodRef.add(food.toMap());

    food.id = documentRef.id;

    print('uploaded report successfully: ${food.toString()}');

    await documentRef.update(food.toMap());

    foodUploaded(food);
  }
}

deleteFood(Food food, Function foodDeleted,String userNic) async {
  if (food.image != null) {
    Reference storageReference = FirebaseStorage.instance.refFromURL(food.image);


    await storageReference.delete();

    print('image deleted');
  }

  await FirebaseFirestore.instance.collection('Products').doc('Reports').collection('piyumikathisari@gmail.com').doc(food.id).delete();
  foodDeleted(food);
}
