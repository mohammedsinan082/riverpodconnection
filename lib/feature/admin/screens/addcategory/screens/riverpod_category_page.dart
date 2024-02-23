import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/feature/admin/screens/addcategory/screens/riverpod_view_page.dart';

import '../../../../../core/constants/contants1.dart';
import '../../../../../main.dart';
import '../controller/category_controller.dart';


class ProductCategory extends ConsumerStatefulWidget {
  const ProductCategory({super.key});

  @override
  ConsumerState<ProductCategory> createState() => _RiverpodCategoryState();
}

class _RiverpodCategoryState extends ConsumerState<ProductCategory> {

  final selectedProvider=StateProvider<List<int>>((ref) {
    return [];
  });


  TextEditingController productcategory_controller=TextEditingController();
  TextEditingController description_controller=TextEditingController();

 List a=[7,8,9,10];

 List selected=[];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeColor.iconRed,
        title: Text("Add Category"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: w*0.08,
            ),
            Container(
              height: w*0.75,
              width: w*1,
              child:Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.sentences,
                    //maxLength: 5,
                    // maxLines: null,
                    // minLines: 5,
                    controller: productcategory_controller,
                    style: TextStyle(
                      fontSize: w*0.05,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        labelText: "Enter Product Category",
                        labelStyle: TextStyle(
                          fontSize: w*0.05,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                          fontSize: w*0.05,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w*0.03),
                            borderSide:BorderSide(
                              color: Colors.blueGrey,
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w*0.03),
                            borderSide:BorderSide(
                              color: Colors.blueGrey,
                            )
                        )
                    ),
                  ),
                  SizedBox(height: w*0.1,),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.sentences,
                    //maxLength: 5,
                    // maxLines: null,
                    // minLines: 5,
                    controller: description_controller,
                    style: TextStyle(
                      fontSize: w*0.05,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        labelText: "Enter Product Description",
                        labelStyle: TextStyle(
                          fontSize: w*0.05,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                          fontSize: w*0.05,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w*0.03),
                            borderSide:BorderSide(
                              color: Colors.blueGrey,
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w*0.03),
                            borderSide:BorderSide(
                              color: Colors.blueGrey,
                            )
                        )
                    ),
                  ),
                  SizedBox(height: w*0.05,),
                  Text("Add product Size",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  Consumer(
                    builder: (context,ref,child) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: a.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder:(context, index) {
                              return  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: InkWell(
                                      onTap: () {
                                        List<int> newlist= ref.watch(selectedProvider);
                                        if(newlist.contains(a[index])){
                                          newlist.remove(a[index]);
                                          ref.read(selectedProvider.notifier).update((state) => newlist);
                                          print(selected);
                                        }
                                        else{
                                          newlist.add(a[index]);
                                          ref.read(selectedProvider.notifier).update((state) => newlist);
                                          print(selected);
                                        }
                                      },
                                      child: Container(
                                        height: w*0.1,
                                        width: w*0.12,
                                        color: Colors.red,
                                        child: Center(child: Text(a[index].toString(),style: TextStyle(fontWeight: FontWeight.bold),)),
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   height: w*0.1,
                                  //   width: w*0.12,
                                  //   color: Colors.red,
                                  //   child: Center(child: Text("$b",style: TextStyle(fontWeight: FontWeight.bold),)),
                                  // ),
                                  // Container(
                                  //   height: w*0.1,
                                  //   width: w*0.12,
                                  //   color: Colors.red,
                                  //   child: Center(child: Text("$c",style: TextStyle(fontWeight: FontWeight.bold),)),
                                  // ),
                                  // Container(
                                  //   height: w*0.1,
                                  //   width: w*0.12,
                                  //   color: Colors.red,
                                  //   child: Center(child: Text("$d",style: TextStyle(fontWeight: FontWeight.bold),)),
                                  // ),
                                ],
                              );
                            }, ),
                      );
                    }
                  )

                ],
              ),
            ),
            SizedBox(height: w*0.1,),
            InkWell(
              onTap: () {
                if(
                productcategory_controller.text.isNotEmpty

                ){
                  ref.read(CategoryControllerProvider.notifier).addCategory(productcategory: productcategory_controller.text.trim(),categoryList: ref.watch(selectedProvider),);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RiverpodViewPage(),));
                }else{
                  productcategory_controller.text.isEmpty?showMessage(context, text: "Enter Category", color: Colors.red):
                  showMessage(context, text: "Complete your field", color: Colors.red);
                }

              },
              child: Container(
                height: w*0.13,
                width: w*0.95,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(w*0.02),
                ),
                child: Center(child: Text("ADD",style:
                TextStyle(
                    fontSize: w*0.070,color: Colors.white
                ),)),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
