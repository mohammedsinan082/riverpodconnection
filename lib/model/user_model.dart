import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpodconnection/feature/home/firstpage/screens/firstpage.dart';

class UserModel{
  String name;
  String email;
  String id;
  DateTime date;
  bool delete;
  DocumentReference reference;
  List<String> wishlist;
  List<Map<String,dynamic>> productKart;
  List<Map<String,dynamic>> address;
  String image;


  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.date,
    required this.delete,
    required this.reference,
    required this.wishlist,
    required this.productKart,
    required this.image,
    required this.address,
});

  UserModel copywith({
    String? name,
    String? email,
    String? id,
    DateTime? date,
    bool? delete,
    DocumentReference? reference,
    List<String>? wishlist,
    List? cart,
    String? image,
    List<Map<String,dynamic>>? productKart,
    List<Map<String,dynamic>>? address,
}) =>
      UserModel(
          name: name ?? this.name,
          email: email ?? this.email,
          id: id ?? this.id,
          date: date ?? this.date,
          delete: delete ?? this.delete,
          reference: reference ?? this.reference,
          wishlist: wishlist ?? this.wishlist,
          productKart: productKart ?? this.productKart,
          image: image ?? this.image,
          address: address ?? this.address,
      );

  factory UserModel.fromJson(dynamic json) =>UserModel(
      name: json ['name']??'',
      email: json ['email'],
      id: json ['id'],
      date: json ['date'].toDate(),
      delete: json ['delete'],
      reference: json ['reference'],
      wishlist: List<String>.from(json ['wishlist']),
      productKart: List<Map<String,dynamic>>.from(json ['productKart']),
      image: json ['image'],
      address: List<Map<String,dynamic>>.from(json['address']??{}),
  );

  Map<String,dynamic> toJson() =>{
    'name':name,
    'email':email,
    'id':id,
    'date':date,
    'delete':delete,
    'reference':reference,
    'wishlist':wishlist,
    'productKart':productKart,
    'image':image,
    'address':address

  };


}