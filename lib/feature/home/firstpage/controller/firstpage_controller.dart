
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/bannerModel.dart';
import '../../../../model/product_model.dart';
import '../../../../model/category_model.dart';
import '../repository/firstpage-repository.dart';


final homeControllerProvider = StateNotifierProvider<HomeController,bool>((ref) {
  return HomeController(repository: ref.read(homeRepositoryProvider));
});

final getProductProvider = StreamProvider.autoDispose((ref)  {
  return ref.watch(homeControllerProvider.notifier).getProduct();
});

final getDataProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(homeControllerProvider.notifier).getData();
});

final getCategoryProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(homeControllerProvider.notifier).getCategory();
});

final productStreamProvider=StreamProvider.autoDispose.family((ref,String productCategory) {
  return ref.watch(homeControllerProvider.notifier).getCategoryProduct(productCategory);
} );


class HomeController extends StateNotifier<bool>{
  HomeRepository _repository;

  HomeController({
    required HomeRepository repository
}):_repository=repository,super(false);


  Stream<List<ProductModel>>getCategoryProduct(String productCategory){
   return _repository.getCategoryProduct(productCategory);
  }

  Stream<List<ProductModel>>getProduct(){
    return _repository.getProduct();
  }


  Stream<List<BannerModel>> getData(){
    return _repository.getData();
  }


  Stream<List<CategoryModelRiverpod>>getCategory(){
    return _repository.getCategory();
  }
}