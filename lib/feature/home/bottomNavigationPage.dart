import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:riverpodconnection/core/constants/colors.dart';

import 'package:riverpodconnection/feature/home/secondpage/screens/secondpage.dart';
import 'package:riverpodconnection/feature/home/thirdpage/screens/thirdPage.dart';

import 'firstpage/screens/firstpage.dart';

class bottomNaviPage extends StatefulWidget {
  const bottomNaviPage({super.key});

  @override
  State<bottomNaviPage> createState() => _bottomNaviPageState();
}

class _bottomNaviPageState extends State<bottomNaviPage> {


  bool click=true;

  int Selectedindex=0;
  List<Widget> pages=[
    firstPage(),
    secondPage(),
    thirdPage()
  ];

  void onItemTapped(int index){
    setState(() {
      Selectedindex=index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[Selectedindex],
      bottomNavigationBar: ConvexAppBar(
        color: Colors.grey,

        backgroundColor: themeColor.secondarycolor,
        activeColor: themeColor.primarycolor,
        // height: width*0.2,
        // style: TabStyle.react,





        items: [
          TabItem(icon: Icons.home,title: "Home",),
          TabItem(icon: Icons.check_circle, title: 'Booked'),
          TabItem(icon: Icons.person, title: 'Person'),
        ],
        onTap: onItemTapped,


      ),
    );
  }
}
