import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/contants1.dart';
import '../../../../../core/constants/firebase_constants.dart';
import '../../../../../model/product_model.dart';
import '../../../../../model/category_model.dart';


final testRepositoryProvider = Provider<TestRepository>((ref) {
  return TestRepository(firestore: FirebaseFirestore.instance);
});

class TestRepository{
  FirebaseFirestore _firestore;
  TestRepository({required FirebaseFirestore firestore}):_firestore=firestore;
  CollectionReference get _river => _firestore.collection(RiverpodConstants.productcollection);



  addProduct({required String productname,required double productprice,required String productoffer,required String image,required String category,required int minimum,required int maximum}){
    DocumentReference ref = _firestore.collection(RiverpodConstants.productcollection).doc();
    ProductModel a =ProductModel(
        image: image,
        rating: 0,
        productname: productname,
        offer: productoffer,
        amount: productprice,
        date: DateTime.now(),
        id: '',
        reference: ref,
        category: category,
        delete: false,
        minimum: minimum,
        maximum:minimum,
        );
    _river.add(a.toJson()).then((value){
      ProductModel model=a.copywith(id: value.id,reference: value);
      value.update(model.toJson());
    });
  }

  Stream<List<ProductModel>> viewProduct(){
    return _river.where('delete',isEqualTo: false).snapshots().map((event) {
      List<ProductModel> userList =[];
      for(var doc in event.docs){
        userList.add(ProductModel.fromJson(doc.data()));
      }
      return userList;
    });
  }

  Stream<ProductModel> viewProduct1({required String id}){
    return _river.doc(id).snapshots().map((event) => ProductModel.fromJson(event.data()));
  }


  Stream<ProductModel> viewProduct2({required String id}){
    return _river.doc(id).snapshots().map((event) => ProductModel.fromJson(event.data()));
  }

  updateProduct({required ProductModel productModel,required String productname,required double productprice,required String productoffer,required String image, required String category,required int minimum,required int maximum}){
    ProductModel model= productModel.copywith(productname: productname,offer: productoffer,amount: productprice,image: image,category: category,minimum: minimum,maximum: maximum);
    productModel.reference.update(model.toJson());
  }




  Stream<List<CategoryModelRiverpod>> getRiverpodCategory() {
    return FirebaseFirestore.instance.collection(RiverpodConstants.categoryproduct)
        .where("delete",isEqualTo: false).snapshots().map((event) {
      List <CategoryModelRiverpod> category=[];
      for(var doc in event.docs){
        category.add(CategoryModelRiverpod.fromJson(doc.data()));
      }
      return category;
    });
  }


}