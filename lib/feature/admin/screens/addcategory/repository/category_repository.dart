import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/constants/firebase_constants.dart';
import '../../../../../core/failure.dart';
import '../../../../../core/type_defs.dart';
import '../../../../../model/category_model.dart';




final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository(firestore: FirebaseFirestore.instance);
});



class CategoryRepository{
  FirebaseFirestore _firestore;
  CategoryRepository({
    required FirebaseFirestore firestore
      }):_firestore=firestore;


  CollectionReference get _river => _firestore.collection(RiverpodConstants.categoryproduct);


  FutureVoid addCategory({required String productcategory,required List categorySize})async {
    int id =Timestamp.now().seconds;

    DocumentReference ref = FirebaseFirestore.instance.collection(RiverpodConstants.categoryproduct).doc();
    CategoryModelRiverpod b=CategoryModelRiverpod(
      productcategory: productcategory,
      id: '',
      delete: false,
      reference: ref,
      size: categorySize,

    );

    try{
      return right(await  _river.add(b.toJson()).then((value){
        CategoryModelRiverpod model=b.copyWith(id: value.id,reference: value);
        value.update(model.toJson());
      }));
    }on FirebaseException catch(e){
      return left(Failure(e.message!));
    }catch(e){
      return left(Failure(e.toString()));
    }



    _river.add(b.toJson()).then((value){
      CategoryModelRiverpod model=b.copyWith(id: value.id,reference: value);
      value.update(model.toJson());
  });
    }


  Stream<List<CategoryModelRiverpod>> viewCategory(){
    return _river.where("delete",isEqualTo: false)
        .snapshots().map((event) {
          List<CategoryModelRiverpod> categoryList=[];
          for(var doc in event.docs){
            categoryList.add(CategoryModelRiverpod.fromJson(doc.data()));
            print("categoryList");
            print(categoryList);
            print("categoryList");
          }
          return categoryList;
    }
    );
  }

  updateCategory({required CategoryModelRiverpod categoryModelRiverpod,required String productcategory}){
    CategoryModelRiverpod categorymodel = categoryModelRiverpod.copyWith(productcategory: productcategory);
    categoryModelRiverpod.reference.update(categorymodel.toJson());
  }


}