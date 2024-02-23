
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/feature/admin/screens/product/screens/add_product_page.dart';
import 'package:riverpodconnection/model/product_model.dart';

import '../../../../../main.dart';
import '../controller/test_controller.dart';
import 'product_edit_page.dart';

class ViewProductPage extends ConsumerWidget {
  const ViewProductPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor.iconRed,
        title: Text("View Product"),
      ),
      body: Column(
        children: [
          Consumer(
            builder: (context1,ref1,child1) {
              return Expanded(
                child: ref1.watch(viewProductProvider).when(
                    data: (productList) {
                      return ListView.builder(
                          itemCount: productList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context,int index){
                            ProductModel userDetails = productList[index];
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InkWell(
                                  onTap: (){
                                    // var a = userDetails.copyWith(
                                    //   delete: true,
                                    // );
                                    //
                                    //
                                    // details[index].reference.update(a.toJson());


                                  },
                                  child:
                                  Container(
                                    height: h*0.45,
                                    width: w*1,
                                    child:Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: h*0.19,
                                                width: w*0.32,
                                                decoration: BoxDecoration(
                                                    color: Colors.brown,
                                                    image: DecorationImage(image: NetworkImage(productList[index].image))),

                                            ),
                                            SizedBox(width: w*0.2,),
                                            Column(
                                              children: [
                                                Container(
                                                  height: w*0.4,
                                                  width: w*0.4,
                                                  color: Colors.blue,
                                                  child: Column(
                                                    children: [
                                                      Text(productList[index].productname,style: TextStyle(
                                                        fontSize: 25,
                                                      ),),
                                                      SizedBox(height: w*0.05,),
                                                      Text(productList[index].offer,style: TextStyle(
                                                        fontSize: 25,
                                                      ),),
                                                      SizedBox(height: w*0.05,),
                                                      Text(productList[index].amount.toString(),style: TextStyle(
                                                        fontSize: 25,
                                                      ),),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductEditPage( productModel: productList[index], )));
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
                                                                var a = userDetails.copywith(delete: true);
                                                                userDetails.reference.update(a.toJson());
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
                                    ) ,
                                  )
                                ));
                          });
                    },
                    error: (error, stackTrace) => Center(child: Text(error.toString())),
                    loading: () => Center(child: CircularProgressIndicator(),),
                ),
              );
            }
          ),


        ],
      ),
    );
  }
}
