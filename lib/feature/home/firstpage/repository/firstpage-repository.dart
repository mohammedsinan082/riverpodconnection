import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/contants1.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../../model/bannerModel.dart';
import '../../../../model/product_model.dart';
import '../../../../model/category_model.dart';



final homeRepositoryProvider= Provider( (ref) {
  return HomeRepository(
      firestore: FirebaseFirestore.instance);
});


class HomeRepository{
  FirebaseFirestore _firestore;

  HomeRepository({
    required FirebaseFirestore firestore
}):_firestore=firestore;


  Stream<List<ProductModel>>getCategoryProduct(String productCategory){
    return FirebaseFirestore.instance.collection(RiverpodConstants.productcollection)
        .where("delete",isEqualTo: false)
        .where("category",isEqualTo: productCategory)
        .orderBy("date",descending: true)
        .snapshots().map((event) => event.docs.map((e) => ProductModel.fromJson(e.data())).toList());
  }

  Stream<List<ProductModel>>getProduct(){
    return FirebaseFirestore.instance.collection(RiverpodConstants.productcollection)
        .where("delete",isEqualTo: false)
        .orderBy('date',descending: true)
        .snapshots().map((event) =>
        event.docs.map((e) =>
            ProductModel.fromJson(e.data())).toList());
  }



 Stream<List<BannerModel>> getData(){
    return FirebaseFirestore.instance.collection(RiverpodConstants.offerbanner)
        .snapshots().map((event) => event.docs.map((e) => BannerModel.fromJson(e.data())).toList());
  }
  
  Stream<List<CategoryModelRiverpod>>getCategory(){
    return FirebaseFirestore.instance.collection(RiverpodConstants.categoryproduct)
        .where("delete",isEqualTo: false)
        .snapshots().map((event) => event.docs.map((e) => CategoryModelRiverpod.fromJson(e.data())).toList());
  }

}