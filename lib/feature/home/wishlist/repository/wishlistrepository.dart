import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/contants1.dart';
import 'package:riverpodconnection/core/constants/firebase_constants.dart';
import 'package:riverpodconnection/main.dart';
import 'package:riverpodconnection/model/user_model.dart';


final wishListRepositoryProvider= Provider<WishListRepository>((ref) {
  return WishListRepository(firestore: FirebaseFirestore.instance);
});

class WishListRepository{
  FirebaseFirestore _firestore;
  WishListRepository({required FirebaseFirestore firestore}):_firestore=firestore;
  CollectionReference get _user => _firestore.collection(RiverpodConstants.user);



  addToWishList({required String productId}) async {
    final snapshot= await _user.doc(currentuserid).get();
    UserModel userModel = UserModel.fromJson(snapshot.data());
    List<String> list = userModel.wishlist;
    list.add(productId);
    UserModel model = userModel.copywith(wishlist: list);
    userModel.reference.update(model.toJson());
    }


  deleteFromWishList({required String productId}) async {
    final snapshot= await _user.doc(currentuserid).get();
    UserModel usermodel =UserModel.fromJson(snapshot.data());
    List<String> list1 = usermodel.wishlist;
    list1.remove(productId);
    UserModel model=usermodel.copywith(wishlist: list1);
    usermodel.reference.update(model.toJson());

    // return _user.doc(currentuserid).update({
    //   RiverpodConstants.wishlist: FieldValue.arrayRemove([wishListItems])
    // }
    // );
  }




}