import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  static const ID = "id";
  static const NAME = "name";
  static const ADDRESS = "address";
  static const MOBILENO = "mobileNo";

  String _name;
  String _address;
  String _id;
  String _mobileNo;

  String get name => _name;
  String get address => _address;
  String get id => _id;
  String get mobileNo => _mobileNo;

}
