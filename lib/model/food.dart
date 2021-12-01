import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String id;
  String name;
  String category;
  String image;
  String description;
  String price;
  Timestamp createdAt;
  Timestamp updatedAt;
  double amount;

  Food();

  Food.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    category = data['category'];
    image = data['image'];
    price = data['price'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
    description  = data['description'];
    amount = data['amount'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'price': price,
      'description':description,
      'amount':amount
    };
  }
}
