import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/feature/home/addresspage/addressRepository.dart';


final addressControllerProvider = StateNotifierProvider<addressController,bool>((ref) {
   return addressController(repository: ref.read(addressRepositoryProvider));
});




class addressController extends StateNotifier<bool>{
  addressRepository _repository;
  addressController({required addressRepository repository}):_repository=repository,super(false);



  addAddress({required List address}) async {
    return _repository.addAddress(address: address);
  }


}