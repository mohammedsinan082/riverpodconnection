import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/firebase_constants.dart';
import 'package:riverpodconnection/core/providers/firebase_provider.dart';


final billingRepositoryProvider=Provider<billingRepository>((ref) {
  return billingRepository(firestore: FirebaseFirestore.instance);
});


class billingRepository{
  FirebaseFirestore _firestore;
  billingRepository({required FirebaseFirestore firestore}):_firestore=firestore;
  CollectionReference get _billing => _firestore.collection(RiverpodConstants.billingproduct);

}

