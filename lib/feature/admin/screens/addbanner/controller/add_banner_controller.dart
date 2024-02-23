import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../model/bannerModel.dart';
import '../repository/add_banner_repository.dart';


final bannerControllerProvider = StateNotifierProvider<AddBannerController,bool>((ref) {
  return AddBannerController(repository: ref.read(bannerRepositoryProvider));
});

final bannerStreamProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(bannerControllerProvider.notifier).viewbanner();
});


class AddBannerController extends StateNotifier<bool>{
  AddBannerrepository _repository;
  AddBannerController({required AddBannerrepository repository}):_repository=repository,super(false);

  getBanner({required String image}){
    _repository.getBanner(image: image,);
  }

  Stream<List<BannerModel>> viewbanner(){
    return _repository.viewbanner();
  }

  updateBanner({required String image,required BannerModel bannerModel}){
    return _repository.updateBanner(image: image, bannerModel: bannerModel);
  }


}