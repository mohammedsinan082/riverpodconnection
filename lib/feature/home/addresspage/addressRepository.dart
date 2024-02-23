import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/firebase_constants.dart';
import 'package:riverpodconnection/core/providers/firebase_provider.dart';
import 'package:riverpodconnection/main.dart';
import 'package:riverpodconnection/model/user_model.dart';


final addressRepositoryProvider=Provider<addressRepository>((ref) => addressRepository(
  firestore: FirebaseFirestore.instance
));


class addressRepository{
  FirebaseFirestore _firestore;
  addressRepository({required FirebaseFirestore firestore}):_firestore=firestore;
  CollectionReference get _user => _firestore.collection(RiverpodConstants.user);




  addAddress({required List address}) async {

    return _user.doc(currentuserid).update({
      RiverpodConstants.address: FieldValue.arrayUnion(address)
    });
  }






}