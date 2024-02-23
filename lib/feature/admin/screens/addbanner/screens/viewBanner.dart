import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/feature/admin/screens/addbanner/controller/add_banner_controller.dart';
import 'package:riverpodconnection/feature/admin/screens/addbanner/screens/banner_edit_page.dart';
import 'package:riverpodconnection/model/bannerModel.dart';

import '../../../../../main.dart';

class Viewbanner extends ConsumerWidget {
  const Viewbanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor.iconRed,
        centerTitle: true,
        title:Text("View Banner") ,),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              return Expanded(
                  child:ref.watch(bannerStreamProvider).when(
                  data: (bannerList){
                      return ListView.builder(
                        itemCount: bannerList.length,
                        itemBuilder: (context, index) {
                          BannerModel bannerDetails = bannerList[index];
                          return Container(
                                height: h*0.7,
                                width: w*0.9,
                                child: Column(
                                  children: [
                                    Container(
                                      height: h*0.5,
                                      width: w*0.9,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(image: NetworkImage(bannerDetails.imageUrl))
                                      ),


                                    ),
                                    SizedBox(height: h*0.03,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditBannerPage(bannerModel: bannerList[index] )));
                                            },
                                            child: Text("Edit"),),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red
                                          ),
                                            onPressed: () {
                                             showDialog(context: context,
                                                 builder: (context) {
                                                   return AlertDialog(
                                                     title: Center(child: Text("Are you Sure")),
                                                     actions: [
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                         children: [
                                                           InkWell(
                                                             onTap: () {
                                                               var a = bannerDetails.copywith(delete: true);
                                                               bannerDetails.reference.update(a.toJson());
                                                               Navigator.pop(context);
                                                             },
                                                             child: Container(
                                                               height: w*0.14,
                                                               width: w*0.17,
                                                               decoration: BoxDecoration(
                                                                   color: Colors.black,
                                                                 borderRadius: BorderRadius.circular(10)
                                                               ),

                                                               child: Center(child: Text("Yes",style: TextStyle(color: Colors.white),)),
                                                             ),
                                                           ),
                                                           Container(
                                                             height: w*0.14,
                                                             width: w*0.17,
                                                             decoration: BoxDecoration(
                                                                 color: Colors.black,
                                                               borderRadius: BorderRadius.circular(10)
                                                             ),

                                                             child: Center(child: Text("No",style: TextStyle(color: Colors.white),)),
                                                           ),
                                                         ],
                                                       )
                                                     ],
                                                   );
                                                 },);
                                            },
                                            child: Text("Delete"),),

                                      ],
                                    ),

                                  ],
                                ),
                              );


                        },
                    );
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => Center(child: CircularProgressIndicator()),
              ));
            },
          )

        ],
      ),
    );
  }
}
