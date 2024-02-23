
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/feature/admin/screens/addbanner/screens/add_banner.dart';
import 'package:riverpodconnection/feature/admin/screens/product/screens/add_product_page.dart';
import 'package:riverpodconnection/feature/admin/screens/product/screens/product_view_page.dart';

import '../../../main.dart';
import 'addbanner/screens/viewBanner.dart';
import 'addcategory/screens/riverpod_category_page.dart';
import 'addcategory/screens/riverpod_view_page.dart';


class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _firstPageState();
}

class _firstPageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          elevation: 0,
          backgroundColor: themeColor.white,
        ),
        body: Container(
            height: w*1.9,
            width: w*1,
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(w*0.04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("E COM",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: w*0.15,
                        color: themeColor.iconRed,
                      ),),
                      SizedBox(
                        height: w*0.2,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,CupertinoPageRoute(builder: (context) => AddBanner(),));
                        },
                        child: Text("Add Banner",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.08,
                          color: themeColor.iconRed,

                        ),),
                      ),
                      SizedBox(
                        height: w*0.07,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => Viewbanner(),));
                        },
                        child:  Text("view Banner",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.08,
                          color: themeColor.iconRed,

                        ),),
                      ),
                      SizedBox(
                        height: w*0.07,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,CupertinoPageRoute(builder: (context) => AddProductPage(),));
                        },
                        child:  Text("Add product",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.08,
                          color: themeColor.iconRed,

                        ),),
                      ),
                      SizedBox(
                        height: w*0.07,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductCategory(),));
                        },
                        child: Text('Add Category',style:TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.08,
                          color: themeColor.iconRed,
                        ) ,),
                      ),
                      SizedBox(
                        height: w*0.07,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,CupertinoPageRoute(builder: (context) => ViewProductPage(),));
                        },
                        child: Text("Product Details",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.08,
                          color: themeColor.iconRed,

                        ),),
                      ),

                      SizedBox(
                        height: w*0.07,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,CupertinoPageRoute(builder: (context) => RiverpodViewPage(),));
                        },
                        child: Text("Category Details",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.08,
                          color: themeColor.iconRed,

                        ),),
                      )
                    ],

                  ),
                )
            )
    ));

  }
}
