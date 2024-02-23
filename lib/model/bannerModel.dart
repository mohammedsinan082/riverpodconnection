import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel{
  String imageUrl;
  String id;
  DocumentReference reference;
  bool delete;

  BannerModel({
    required this.imageUrl,
    required this.id,
    required this.reference,
    required this.delete,
  });

  BannerModel copywith({
    String? imageUrl,
    String? id,
    DocumentReference? reference,
    bool? delete,
}) =>
   BannerModel(
   imageUrl: imageUrl ?? this.imageUrl,
   id: id ?? this.id,
   reference: reference ?? this.reference,
   delete: delete ?? this.delete,
   );

  factory BannerModel.fromJson(dynamic json) =>BannerModel(
      imageUrl: json['imageUrl'],
      id: json['id'],
      reference: json['reference'],
      delete: json['delete'],
  );

  Map<String,dynamic> toJson()=> {
    "imageUrl":imageUrl,
    "id":id,
    "reference":reference,
    "delete":delete,
  };


}