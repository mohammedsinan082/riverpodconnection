import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  String image;
  String productname;
  String offer;
  double amount;
  String id;
  bool delete;
  double rating;
  DateTime date;
  DocumentReference reference;
  String category;
  int minimum;
  int maximum;


  ProductModel({
    required this.image,
    required this.productname,
    required this.offer,
    required this.amount,
    required this.rating,
    required this.date,
    required this.id,
    required this.reference,
    required this.category,
    required this.delete,
    required this.minimum,
    required this.maximum,
});

  ProductModel copywith({
    String? image,
    String? productname,
    String? offer,
    double? amount,
    double? rating,
    DateTime? date,
    String? id,
    DocumentReference? reference,
    String? category,
    bool? delete,
    int? minimum,
    int? maximum,
}) =>
      ProductModel(
          image: image ?? this.image,
          productname: productname ?? this.productname,
          offer: offer ?? this.offer,
          amount: amount ?? this.amount,
          rating: rating ?? this.rating,
          date: date ?? this.date,
          id: id ?? this.id,
          reference: reference ?? this.reference,
          category: category ?? this.category,
          delete: delete ?? this.delete,
          minimum: minimum ?? this.minimum,
          maximum: maximum ?? this.maximum,
      );

  factory ProductModel.fromJson(dynamic json) => ProductModel(
  image: json['image'],
  productname: json ['productname'],
  offer: json ['offer'],
  amount: double.tryParse(json ['amount'].toString()) ?? 0,
    rating: double.tryParse(json ['rating'].toString()) ?? 0,
  date: json ['date'].toDate(),
  id: json ['id'],
  reference: json ['reference'],
  category: json ['category'], delete: json ['delete'],
  minimum: json ['minimum'], maximum: json ['maximum'],
  );

  Map<String,dynamic> toJson() =>{
    'image':image,
    'productname':productname,
    'offer':offer,
    'amount':amount,
    'rating':rating,
    'date':date,
    'id':id,
    'reference':reference,
    'category':category,
    'delete':delete,
    'minimum':minimum,
    'maximum':maximum,
  };

}

