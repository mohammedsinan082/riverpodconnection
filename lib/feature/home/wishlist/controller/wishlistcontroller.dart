import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/feature/home/wishlist/repository/wishlistrepository.dart';

final WishListControllerProvider=StateNotifierProvider<WishListController,bool>((ref) {
  return WishListController(repository: ref.read(wishListRepositoryProvider));
});

class WishListController extends StateNotifier<bool>{
  WishListRepository _repository;
  WishListController({required WishListRepository repository}):_repository=repository,super(false);

  addToWishList({required String productId}){
    return _repository.addToWishList(productId: productId);
  }

  deleteFromWishList({required String productId}) {
    return _repository.deleteFromWishList(productId: productId);
  }

  // deleteFromWishList(Map wishListItems){
  //   return _repository.deleteFromWishList(wishListItems);
  // }


}