import 'package:firebase_messaging/firebase_messaging.dart';

class notification{
  static  final _firebasemessaging =FirebaseMessaging.instance;


  static Future init() async{
    await _firebasemessaging.requestPermission(
         alert :true,
         announcement : false,
         badge : true,
         carPlay : false,
         criticalAlert : false,
         provisional : false,
         sound : true
      );

    final token= await _firebasemessaging.getToken();

    print("device token :$token");

  }
}