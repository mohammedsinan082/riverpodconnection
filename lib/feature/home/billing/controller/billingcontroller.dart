import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/feature/home/billing/repository/billingrepository.dart';

import '../../../../model/user_model.dart';



final billingControllerProvider=StateNotifierProvider<billingController,bool>((ref){
  return billingController(repository: ref.read(billingRepositoryProvider));
} );

class billingController extends StateNotifier<bool>{
  billingRepository _repository;
  billingController({required billingRepository repository}):_repository=repository,super(false);







}

