import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/feature/admin/screens/addcategory/screens/riverpod_edit_page.dart';

import '../../../../../main.dart';
import '../../../../../model/category_model.dart';
import '../controller/category_controller.dart';


class RiverpodViewPage extends ConsumerStatefulWidget {
  const RiverpodViewPage({super.key});

  @override
  ConsumerState<RiverpodViewPage> createState() => _RiverpodViewPageState();
}

class _RiverpodViewPageState extends ConsumerState<RiverpodViewPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor.iconRed,
        title: Text("View Category"),
      ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: ref.watch(viewCategoryProvider).when(
                      data: (categoryList){
                        return ListView.builder(
                            itemCount: categoryList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context,int index){
                              CategoryModelRiverpod categoryDetails = categoryList[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: h*0.3,
                                  width: w*1,
                                  color: Colors.red,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(categoryDetails.productcategory),
                                              Container(
                                                height: h*0.1,
                                                width: w*0.7,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: categoryDetails.size.length,
                                                    itemBuilder: (context, index) {
                                                      return  Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [

                                                          Padding(
                                                            padding: const EdgeInsets.all(10.0),
                                                            child: Container(
                                                              height: w*0.1,
                                                              width: w*0.12,
                                                              color: Colors.blue,
                                                              child: Center(child: Text(categoryDetails.size[index].toString(),style: TextStyle(fontWeight: FontWeight.bold),)),
                                                            ),
                                                          ),

                                                        ],
                                                      );
                                                    },

                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: w*0.1,),
                                          Container(
                                            height: w*0.4,
                                            child: InkWell(
                                                onTap: () {
                                                  showDialog(context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Center(child: Text("Are You Sure")),
                                                        actions: [
                                                          InkWell(
                                                            onTap: () {
                                                              var b = categoryDetails.copyWith(
                                                                delete: true,
                                                              );
                                                              categoryList[index].reference.update(b.toJson());
                                                              Navigator.pop(context);

                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  height: 60,
                                                                  width: 60,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      color: Colors.blue
                                                                  ),
                                                                  child: Center(child: Text("Yes",style: TextStyle(fontSize: 25,color: Colors.white))),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Container(
                                                                    height: 60,
                                                                    width: 60,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(15),
                                                                        color: Colors.blue
                                                                    ),
                                                                    child: Center(child: Text("No",style: TextStyle(fontSize: 25,color: Colors.white))),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    },);




                                                },
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Icon(Icons.delete),
                                                    InkWell(
                                                        onTap: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>RiverpodEditPage(categoryModelRiverpod: categoryList[index],)));
                                                        },
                                                        child: Icon(Icons.edit))
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );

                            });
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => Center(child: CircularProgressIndicator()),)),
            ],
          ),
        ));
  }
}
