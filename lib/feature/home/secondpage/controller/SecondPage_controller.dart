import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/feature/home/secondpage/repository/secondpage_repository.dart';
import 'package:riverpodconnection/feature/home/secondpage/screens/secondpage.dart';
import '../../../../model/product_model.dart';
import '../../../../model/category_model.dart';


final secondPageControllerProvider = StateNotifierProvider<SecondPageController,bool>((ref)  {
  return SecondPageController(repository: ref.read(secondPageProvder));
});

final productStreamProvider1 = StreamProvider.autoDispose.family((ref,String? categoryname)  {
  return ref.read(secondPageControllerProvider.notifier).getProduct1(categoryname:categoryname );
});

final fullProductStreamProvider1 = StreamProvider.autoDispose((ref)  {
  return ref.read(secondPageControllerProvider.notifier).getFullProduct1();
});

final CategoryStreamProvider1 = StreamProvider.autoDispose((ref)  {
  return ref.read(secondPageControllerProvider.notifier).getCategory1();
});


class SecondPageController extends StateNotifier<bool>{
  SecondPageRepository _repository;
  SecondPageController({required SecondPageRepository repository}):_repository=repository,super(false);


  Stream<List<ProductModel>> getProduct1({required String? categoryname}){
    return _repository.getProduct1(categoryname: categoryname);
  }

  Stream<List<ProductModel>>getFullProduct1(){
    return _repository.getFullProduct1();
  }

  Stream<List<CategoryModelRiverpod>>getCategory1() {
    return _repository.getCategory1();
  }


}