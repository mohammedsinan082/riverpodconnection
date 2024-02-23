import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpodconnection/core/constants/firebase_constants.dart';
import 'package:riverpodconnection/core/constants/sharedpreferconstants.dart';
import 'package:riverpodconnection/core/providers/firebase_provider.dart';
import 'package:riverpodconnection/feature/auth/screens/signup.dart';
import 'package:riverpodconnection/model/emailpasswordmodel.dart';
import 'package:riverpodconnection/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/failure.dart';
import '../../../core/type_defs.dart';
import '../../../main.dart';



final authRepositoryProvider=Provider((ref) =>AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn:ref.read(googleSignInProvider),
    ref:ref
));


class AuthRepository{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final Ref _ref;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required Ref ref
}) : _auth=auth,
     _firestore=firestore,
     _googleSignIn=googleSignIn,
     _ref=ref;

  CollectionReference get _user => _firestore.collection(RiverpodConstants.user);
  CollectionReference get _emailpassword =>_firestore.collection(RiverpodConstants.emailpassword);
  Stream<User?> get authStateChange => _auth.authStateChanges();
  
  
  
  FutureEither<emailPasswordModel>  EmailandPassword ({required String email,required String password})async{
    try{
      DocumentReference ref= _firestore.collection(RiverpodConstants.emailpassword).doc();
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setBool('login', true);

      UserCredential userCredential1= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(!userCredential1.additionalUserInfo!.isNewUser){

      currentuseremail=userCredential1.user!.email ?? "No Email";

      prefs.setString(SharedPreferConstants.userEmail,currentuseremail);
      currentuserid=userCredential1.user!.uid;

      var logindata=await _firestore.collection(RiverpodConstants.emailpassword).where('id',isEqualTo: currentuserid).get();
      emailPasswordModel emailModel;

      // if(logindata.docs.isEmpty) {
        emailModel = emailPasswordModel(
            id: '',
            email: email,
            password: password,
            reference: ref
        );
        _emailpassword.add(emailModel.toJson()).then((value) {
          emailPasswordModel model = emailModel.copywith(
              id: value.id, reference: value);
          value.update(model.toJson());
        });
      // }
      return right(emailModel);
      }else{
        throw 'Invalid Email/Password';
      }

    }on FirebaseException catch (e){
      throw e.message!;
    } catch (e){
      return left(Failure(e.toString()));
    }




    
    
  }
  
  
  
  
  
  
  
  

  FutureEither<UserModel> signInWithGoogle() async {

      try{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("login",true);

     final   GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();
     final   GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final  AuthCredential credential=GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken:googleAuth?.idToken
        );




        UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);


        currentuseremail=userCredential.user!.email ?? "No Email";
        currentusername=userCredential.user!.displayName ?? "Guest User" ;
        currentuserid=userCredential.user!.uid;
        currentuserimage=userCredential.user!.photoURL ?? "";
        //****************************************************\\
        prefs.setString(SharedPreferConstants.userName,currentusername);
        prefs.setString(SharedPreferConstants.userEmail,currentuseremail);
        prefs.setString(SharedPreferConstants.userImage,currentuserimage);
        prefs.setString(SharedPreferConstants.userId,currentuserid);
        prefs.setString(SharedPreferConstants.userNumber,currentphonenumber);

        UserModel userModel;
      var userData=await  _firestore.collection(RiverpodConstants.user).where('id',isEqualTo: currentuserid).get();
        if (userData.docs.isEmpty) {
          DocumentReference reference = _ref.read(firestoreProvider).collection(RiverpodConstants.user).doc(userCredential.user!.uid);
          userModel =UserModel(
            email: userCredential.user!.email?? "no email",
            id: userCredential.user!.uid,
            delete: false,
            date: DateTime.now(),
            name: userCredential.user!.displayName?? "no name",
            reference: reference,
            wishlist: [],
            productKart: [],
            address: [],
            image: userCredential.user!.photoURL??"no image",
          );
          await _user.doc(userCredential.user!.uid).set(userModel.toJson());
        } else {
          print("goggggggle");
          print(userCredential.user?.uid);
          print("goggggggle");
          userModel = UserModel.fromJson(userData.docs.first.data());
        }
        return right(userModel);
      } on FirebaseException catch (e){
        throw e.message!;
      } catch (e){
        return left(Failure(e.toString()));
      }

  }

  void signOut(BuildContext context,SharedPreferences prefs) async {
    prefs.remove('id');
    await _googleSignIn.signOut();
    await _auth.signOut().then((value){
    loggedIn=false;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => signupPage()), (route) => false);
    });
  }

  Stream<UserModel> getUserData(String id){
    print("userId");
    print(id);
    print("userId");
    return _user.doc(id).snapshots().map((event) => UserModel.fromJson(event.data()as Map<String,dynamic>));
  }
  



}





    //
    //   UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);

    //
    //   prefs.setString('loginId', currentuserid);
    //
    //   DocumentSnapshot user=await
    //   FirebaseFirestore.instance.collection(RiverpodConstants.user).doc(currentuserid).get();
    //   if(!user.exists){
    //     final userModel= UserModel(
    //         email: currentuseremail,
    //         id: currentuserid,
    //         delete: false,
    //         date: DateTime.now(),
    //         name: currentusername,
    //         reference: user.reference,
    //         wishlist: [],
    //         productKart: [],
    //         image: currentuserimage,
    //     );
    //
    //
    //     FirebaseFirestore.instance.collection('user').doc(currentuserid).set(userModel.toJson());
    //
    //   }
    //
    //
    //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homePage(),), (route) => false);
    // }

    









