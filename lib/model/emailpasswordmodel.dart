import 'package:cloud_firestore/cloud_firestore.dart';

class emailPasswordModel{
  String id;
  String email;
  String password;
  DocumentReference reference;

  emailPasswordModel({
    required this.id,
    required this.email,
    required this.password,
    required this.reference
  });

  emailPasswordModel copywith({
   String? id,
   String? email,
    String? password,
    DocumentReference? reference,

})=> emailPasswordModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      reference: reference ?? this.reference,
  );

  factory emailPasswordModel.fromJson(dynamic json) => emailPasswordModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      reference: json['reference']
  );

  Map<String,dynamic> toJson() => {
    'id':id,
    'email':email,
    'password':password,
    'reference':reference,
  };




}