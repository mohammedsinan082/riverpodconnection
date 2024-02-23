
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/model/product_model.dart';

import '../../../../../model/category_model.dart';
import '../repository/test_repository.dart';


final testControllerProvider = StateNotifierProvider<TestController,bool>((ref) {
  return TestController(repository:ref.read(testRepositoryProvider));
});

final viewProductProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(testControllerProvider.notifier).viewProduct();
});

final streamDataWishList = StreamProvider.autoDispose.family((ref,String id) {
  return ref.watch(testControllerProvider.notifier).viewProduct1(id: id);
});

final streamDataCartList = StreamProvider.autoDispose.family((ref,String id) {
  return ref.watch(testControllerProvider.notifier).viewProduct2(id: id);
});

final viewCategoryProvider1= StreamProvider.autoDispose((ref) {
  return ref.watch(testControllerProvider.notifier).getRiverpodCategory();
});


class TestController extends StateNotifier<bool>{
  TestRepository _repository;    //same as String name
  TestController({required TestRepository repository}):_repository=repository,super(false);

  addProduct({required String productname,required String productoffer,required double productprice,required String image,required String category,required int minimum,required int maximum}){
    _repository.addProduct(productname: productname,image: image,productprice: productprice,productoffer: productoffer,category: category,minimum: minimum,maximum: maximum);
  }

  Stream<List<ProductModel>> viewProduct(){
    return _repository.viewProduct();
  }

  Stream<ProductModel> viewProduct1({required String id}){
    return _repository.viewProduct1(id: id);
  }

  Stream<ProductModel> viewProduct2({required String id}){
    return _repository.viewProduct2(id: id);
  }


  updateProduct({required ProductModel productModel,required String productname,required double productprice,required String productoffer,required String image, required String category,required int minimum,required int maximum}){
    _repository.updateProduct(productname: productname,productoffer: productoffer,productprice: productprice,image: image,category: category, productModel: productModel,minimum: minimum,maximum: maximum);
  }

  Stream<List<CategoryModelRiverpod>> getRiverpodCategory() {
    return _repository.getRiverpodCategory();
  }
}