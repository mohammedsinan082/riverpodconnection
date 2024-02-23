import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/feature/home/productcart/repository/productcartrepository.dart';


final cartControllerProvider = StateNotifierProvider<CartController,bool >((ref) {
  return CartController(repository: ref.read(cartRepositoryProvider));
});


class CartController extends StateNotifier<bool>{
  CartRepository _repository;
  CartController({required CartRepository repository}):_repository=repository,super(false);


  addToCartList({required List cart}) {
    return _repository.addToCartList(cart:cart );
  }

  updateToCart(List cart){
    _repository.updateToCart(cart);
  }


  removeFromCartList({required String productName,required String productId,
    required String productImage,required double amount,required int quantity,required int minimum,required int maximum, required int index})  {
    return _repository.removeFromCartList(productName: productName, productId: productId, productImage: productImage, amount: amount, quantity: quantity,index: index,minimum:minimum,maximum:maximum);
  }

  removeAllCartList({required String id})  {
    return _repository.removeAllCartList(id: id);
  }



}