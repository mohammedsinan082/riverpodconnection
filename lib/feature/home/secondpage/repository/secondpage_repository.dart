import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/firebase_constants.dart';

import '../../../../model/product_model.dart';
import '../../../../model/category_model.dart';

final secondPageProvder=Provider((ref) {
  return SecondPageRepository(firestore: FirebaseFirestore.instance);
});

class SecondPageRepository{
  FirebaseFirestore _firestore;
  SecondPageRepository({required FirebaseFirestore firestore}):_firestore=firestore;
  CollectionReference get _category => _firestore.collection(RiverpodConstants.categoryproduct);
  CollectionReference get _product => _firestore.collection(RiverpodConstants.productcollection);


 Stream<List<ProductModel>> getProduct1({required String? categoryname}){
    return _product
        .where("delete",isEqualTo: false)
        .where("category",isEqualTo: categoryname)
        .orderBy("date",descending: true)
        .snapshots().map((event) => event.docs.map((e) => ProductModel.fromJson(e.data())).toList());
  }

  Stream<List<ProductModel>>getFullProduct1(){
    return _product
        .where("delete",isEqualTo: false)
        .orderBy("date",descending: true)
        .snapshots().map((event) => event.docs.map((e) {
          return ProductModel.fromJson(e.data());
        }).toList());
  }


  Stream<List<CategoryModelRiverpod>>getCategory1() {
    return _category
        .where("delete",isEqualTo: false)
        .snapshots().map((event) => event.docs.map((e) => CategoryModelRiverpod.fromJson(e.data())).toList());
  }

}