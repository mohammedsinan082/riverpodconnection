import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModelRiverpod{
  String productcategory;
  String id;
  bool delete;
  DocumentReference reference;
  List size;

  CategoryModelRiverpod({
    required this.productcategory,
    required this.id,
    required this.delete,
    required this.reference,
    required this.size,
  });


  CategoryModelRiverpod copyWith({
    String? productcategory,
    String? id,
    bool? delete,
    DocumentReference? reference,
    String? details,
    List? size,
  })=>
      CategoryModelRiverpod
        (productcategory: productcategory?? this.productcategory,
        id: id?? this.id,
        delete: delete?? this.delete,
        reference: reference?? this.reference,
        size: size?? this.size,
      );
  factory CategoryModelRiverpod.fromJson(dynamic json)=>CategoryModelRiverpod(
    productcategory: json["productcategory"],
    id: json["id"],
    delete: json["delete"],
    reference: json["reference"],
    size: json["size"],
  );
  Map<String,dynamic> toJson()=>{
    "productcategory":productcategory,
    "id":id,
    "delete":delete,
    "reference":reference,
    "size":size,
  };}