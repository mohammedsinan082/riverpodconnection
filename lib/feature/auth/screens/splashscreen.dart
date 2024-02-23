import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/images.dart';
import 'package:riverpodconnection/feature/auth/screens/selectionpage.dart';
import 'package:riverpodconnection/feature/auth/screens/signup.dart';
import 'package:riverpodconnection/feature/home/firstpage/screens/firstpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/sharedpreferconstants.dart';
import '../../../main.dart';
import '../../home/bottomNavigationPage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {



  loggedInCheck() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();

    loggedIn=prefs.getBool("login")??false;
    currentusername =prefs.getString(SharedPreferConstants.userName)??"no name given";
    currentuseremail =prefs.getString(SharedPreferConstants.userEmail)??"no email given";
    currentuserimage = prefs.getString(SharedPreferConstants.userImage)??"no image given";
    currentuserid = prefs.getString(SharedPreferConstants.userId)??"no id given";
    currentphonenumber =prefs.getString(SharedPreferConstants.userNumber)??"no phonenumber given";

    Future.delayed(Duration(seconds: 2)).then((value) => {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loggedIn==false? signupPage():homePage(),))
    });


  }


@override
  void initState() {
  loggedInCheck();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         height: h*1,
         width: w*1,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Container(
               height: h*0.35,
               width: w*0.6,
               child: Image(image: AssetImage(Pictures.splashLogo)),
             )
           ],
         ),
       ),
    );
  }
}
