
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpodconnection/feature/auth/screens/signup.dart';
import 'package:riverpodconnection/feature/home/bottomNavigationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../admin/screens/admin_first_page.dart';
import '../controller/auth_controller.dart';


class homePage extends ConsumerStatefulWidget {
  const homePage({super.key});

  @override
  ConsumerState<homePage> createState() => _homePageRiverpodState();
}

class _homePageRiverpodState extends ConsumerState<homePage> {

  signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loginId');
    await GoogleSignIn().signOut().then((value) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => signupPage()), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    final isLoading= ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body:isLoading? Center(child: CircularProgressIndicator()): Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: h*0.4,
            width: w*1,
            child: Column(
              children: [
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => bottomNaviPage(),));
                    },
                    child: Text("E-commerce")),
                SizedBox(
                  height: w*0.05,
                ),
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>AdminHomePage(),));
                    },
                    child: Text("Admin E-commerce")),
                SizedBox(
                  height: w*0.1,
                ),
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      signOut();
                    },
                    child: Text("Sign Out")),
              ],
            ),
          )

        ],
      ),
    );
  }
}
