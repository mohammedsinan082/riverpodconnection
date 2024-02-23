import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/firebase_constants.dart';

import '../../../../main.dart';
import '../../../../model/user_model.dart';


final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository(firestore: FirebaseFirestore.instance);
});

class CartRepository{
  FirebaseFirestore _firestore;
  CartRepository({required FirebaseFirestore firestore}):_firestore=firestore;
  CollectionReference get _user => _firestore.collection(RiverpodConstants.user);



  removeAllCartList({required String id}) async {

    final snapshot= await _user.doc(id).get();
    UserModel userModel = UserModel.fromJson(snapshot.data());
    List<Map<String,dynamic>> list = userModel.productKart;
    list.clear();
    UserModel model = userModel.copywith(productKart: list);
    userModel.reference.update(model.toJson());
  }



  addToCartList({required List cart}) async {

    return _user.doc(currentuserid).update({
      RiverpodConstants.productcart: FieldValue.arrayUnion(cart)
    });
  }

  updateToCart(List cart){
    return _user.doc(currentuserid).update({
      RiverpodConstants.productcart:cart
    });
  }

  removeFromCartList({required String productName,required String productId,
    required String productImage,required double amount,required int quantity,required int minimum, required int maximum,required int index}) async {

    final snapshot= await _user.doc(currentuserid).get();
    UserModel userModel = UserModel.fromJson(snapshot.data());
    List<Map<String,dynamic>> list = userModel.productKart;
    final map = list.elementAt(index);
    list.remove(map);
    UserModel model = userModel.copywith(productKart: list);
    userModel.reference.update(model.toJson());
  }



}