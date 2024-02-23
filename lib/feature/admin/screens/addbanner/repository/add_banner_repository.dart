import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/contants1.dart';
import 'package:riverpodconnection/model/bannerModel.dart';
import 'package:riverpodconnection/model/product_model.dart';

import '../../../../../core/constants/firebase_constants.dart';


final bannerRepositoryProvider = Provider<AddBannerrepository>((ref) {
  return AddBannerrepository(firestore: FirebaseFirestore.instance);
});

class AddBannerrepository{
  FirebaseFirestore _firestore;
  AddBannerrepository({required FirebaseFirestore firestore}):_firestore=firestore;
  CollectionReference get _river => _firestore.collection(RiverpodConstants.offerbanner);


  getBanner({required String image}){
    DocumentReference ref= FirebaseFirestore.instance.collection(RiverpodConstants.offerbanner).doc();
    BannerModel a=BannerModel(
        imageUrl: image,
        id: '',
        reference: ref,
        delete: false

    );

    _river.add(a.toJson()).then((value) {
      BannerModel model= a.copywith(id: value.id,reference: value);
      value.update(model.toJson());
    });

  }



  Stream<List<BannerModel>> viewbanner(){
    return _river.where('delete',isEqualTo: false)
        .snapshots().map((event) {
      List<BannerModel> bannerList =[];
      for(var doc in event.docs){
        bannerList.add(BannerModel.fromJson(doc.data()));
      }
      return bannerList;
    });
  }



  updateBanner({required String image, required BannerModel bannerModel}){
    BannerModel model= bannerModel.copywith(imageUrl: image,);
    bannerModel.reference.update(model.toJson());
  }








}