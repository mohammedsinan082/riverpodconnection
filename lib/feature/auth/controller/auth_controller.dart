


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/feature/auth/repository/auth-repository.dart';
import 'package:riverpodconnection/feature/auth/screens/selectionpage.dart';
import 'package:riverpodconnection/model/emailpasswordmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/providers/providers.dart';
import '../../../core/utils.dart';
import '../../../model/user_model.dart';
import '../../home/secondpage/screens/secondpage.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);
final emailPasswordProvider = StateProvider<emailPasswordModel?>((ref) => null);




// final authControllerProvider=Provider<AuthController>((ref) {
//   return AuthController(authRepository: ref.read(authRepositoryProvider));
// });
//
//
final authControllerProvider=StateNotifierProvider<AuthController,bool>((ref) =>
  AuthController(
      authRepository: ref.read(authRepositoryProvider),
    ref: ref,
  )
);

final wishListStreamProvider = StreamProvider.autoDispose.family((ref,String id)  {
  return ref.watch(authControllerProvider.notifier).getUserData(id);
});

final cartListStreamProvider = StreamProvider.autoDispose.family((ref,String id)  {
  return ref.watch(authControllerProvider.notifier).getUserData(id);
});



class AuthController extends StateNotifier<bool>{
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref
  }) : _authRepository =authRepository,_ref=ref,super(false);



  void EmailandPassword({required String email,required String password,required BuildContext context}) async {
    state=true;
    final user =await _authRepository.EmailandPassword(email: email, password: password);
    state=false;
    user.fold(
            (l) => showSnackBar(context, l.message),
    (emailPasswordModel) {
      _ref.read(emailPasswordProvider.notifier).update((state) => emailPasswordModel);
      Navigator.push(context, MaterialPageRoute(builder: (context) => homePage(),));
    },
    );
  }



  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;

        user.fold((l) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l.message)));
        },(r) async {
            print(r.toJson());
            var prefs = await _ref.watch(sharedPrefsProvider.future);
            prefs.setString("id", r.id);

            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const homePage(),), (route) => false);
          });


          // (l) => showSnackBar(context, l.message),
          // (userModel) {
          //    _ref.read(userProvider.notifier).update((state) => userModel);
          //    Navigator.push(context, MaterialPageRoute(builder: (context) => homePage(),));
          // },
        //  );
  }

  // signInWithGoogle(BuildContext context) {
  //   _authRepository.signInWithGoogle(context);
  // }

  signOut(BuildContext context,SharedPreferences prefs) async {
    _authRepository.signOut(context,prefs);
  }

  Stream<UserModel> getUserData(String id){
    return _authRepository.getUserData(id);
  }
}