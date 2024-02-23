import 'dart:core';


class CartModel{
  String productName;
  String productId;
  String productImage;
  double amount;
  int quantity;
  int minimum;
  int maximum;

  CartModel({
    required this.productName,
    required this.productId,
    required this.productImage,
    required this.amount,
    required this.quantity,
    required this.minimum,
    required this.maximum,
});

  CartModel copywith({
    String? productName,
    String? productId,
    String? productImage,
    double? amount,
    int? quantity,
    int? minimum,
    int? maximum,
  }) => CartModel(
      productName: productName ?? this.productName,
      productId: productId ?? this.productId,
      productImage: productImage ?? this.productImage,
      amount: amount ?? this.amount,
      quantity: quantity ?? this.quantity,
      minimum: minimum ?? this.minimum,
      maximum: maximum ?? this.maximum,
  );
  factory CartModel.fromJson(dynamic json) => CartModel(
      productName: json ['productName'],
      productId: json ['productId'],
      productImage: json ['productImage'],
      amount: double.tryParse(json ['amount'].toString())??0,
      quantity: json ['quantity'],
      minimum: json ['minimum'],
      maximum: json ['maximum'],
  );

  Map<String,dynamic> toJson() => {
    'productName':productName,
    'productId':productId,
    'productImage':productImage,
    'amount':amount,
    'quantity':quantity,
    'minimum':minimum,
    'maximum':maximum,
  };





}