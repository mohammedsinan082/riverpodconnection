
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../model/category_model.dart';
import '../repository/category_repository.dart';


final CategoryControllerProvider = StateNotifierProvider<CategoryController,bool>((ref) {
  return CategoryController(repository: ref.read(categoryRepositoryProvider));
});

final viewCategoryProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(CategoryControllerProvider.notifier).viewCategory();
});


class CategoryController extends StateNotifier<bool>{
  CategoryRepository _repository;
  CategoryController({
    required CategoryRepository repository
  }):_repository=repository,super(false);


  addCategory({required String productcategory,required List categoryList}){
    _repository.addCategory(productcategory: productcategory,categorySize:categoryList);
  }

  Stream<List<CategoryModelRiverpod>> viewCategory(){
    return _repository.viewCategory();
}

  updateCategory({required CategoryModelRiverpod categoryModelRiverpod,required String productcategory}){
    return _repository.updateCategory(categoryModelRiverpod: categoryModelRiverpod, productcategory: productcategory);
  }



}