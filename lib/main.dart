import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/feature/auth/screens/selectionpage.dart';
import 'package:riverpodconnection/feature/auth/screens/signup.dart';
import 'package:riverpodconnection/feature/auth/screens/splashscreen.dart';
import 'package:riverpodconnection/feature/home/addresspage/addressPage.dart';
import 'package:riverpodconnection/feature/home/secondpage/screens/secondpage.dart';
import 'package:riverpodconnection/feature/notification/notificationclass.dart';

import 'feature/admin/screens/addbanner/screens/add_banner.dart';
import 'feature/admin/screens/addcategory/screens/riverpod_category_page.dart';
import 'feature/admin/screens/addcategory/screens/riverpod_view_page.dart';
import 'feature/admin/screens/admin_first_page.dart';
import 'feature/admin/screens/product/screens/add_product_page.dart';
import 'feature/home/billing/screens/billing_page.dart';
import 'feature/home/bottomNavigationPage.dart';
import 'feature/home/firstpage/screens/firstpage.dart';
import 'feature/home/productdetails.dart';
import 'feature/notification/notificationpage.dart';
import 'firebase_options.dart';


Future _firebasebackgroundmessage(RemoteMessage message) async{
  if(message.notification!=null){
    print("some notification recieved");
  }
}


var h;
var w;

String currentuserid="";
String currentusername="";
String currentuseremail="";
String currentphonenumber="";
String currentuserimage="";
String currentuserlogindate="";
bool loggedIn=false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  notification.init();
  FirebaseMessaging.onBackgroundMessage(_firebasebackgroundmessage);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    w=MediaQuery.of(context).size.width;
    h=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}