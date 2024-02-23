import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/feature/admin/screens/addcategory/screens/riverpod_view_page.dart';


import '../../../../../core/constants/contants1.dart';
import '../../../../../main.dart';
import '../../../../../model/category_model.dart';
import '../controller/category_controller.dart';

class RiverpodEditPage extends ConsumerStatefulWidget {
   final CategoryModelRiverpod categoryModelRiverpod;
  const RiverpodEditPage({super.key, required this.categoryModelRiverpod});

  @override
  ConsumerState<RiverpodEditPage> createState() => _categoryeditpageState();
}

class _categoryeditpageState extends ConsumerState<RiverpodEditPage> {

  final selectedProvider=StateProvider<List<int>>((ref) {
    return [];
  });
  List c=[7,8,9,10];
  List selected=[];


  TextEditingController productcategory_controller=TextEditingController();
  TextEditingController description_controller=TextEditingController();




  @override
  void initState() {
    productcategory_controller =TextEditingController(text: widget.categoryModelRiverpod.productcategory);
    selected=widget.categoryModelRiverpod.size;
    print(selected);
    print("))))))))))))))))))))))))))))))0");
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeColor.iconRed,
        title: Text("Edit Category Page"),
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
                        labelText: "Product Name",
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
                  Text("Add product Size",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  Consumer(
                      builder: (context,ref,child) {
                        var data= ref.watch(selectedProvider);
                        return Container(
                          height: w*0.25,
                          width: w*1,
                          child: ListView.builder(
                            itemCount: c.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder:(context, index) {
                              return  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(right: 50,left:10 ),
                                    child: InkWell(
                                      onTap: () {
                                        List<int> newlist= ref.watch(selectedProvider);
                                        if(newlist.contains(c[index])){
                                          newlist.remove(c[index]);
                                          ref.read(selectedProvider.notifier).update((state) => newlist);
                                          print(selected);
                                        }
                                        else{
                                          newlist.add(c[index]);

                                          ref.read(selectedProvider.notifier).update((state) => newlist);
                                          print(selected);
                                        }
                                      },
                                      child: Container(
                                        height: w*0.1,
                                        width: w*0.12,
                                        color: selected.contains(c[index])?Colors.red:Colors.green,
                                        child: Center(child:Text(c[index].toString(),style: TextStyle(fontWeight: FontWeight.bold),)),
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
                  ref.watch(CategoryControllerProvider.notifier).updateCategory(categoryModelRiverpod: widget.categoryModelRiverpod, productcategory: productcategory_controller.text.trim());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RiverpodViewPage(),));
                }else{
                  productcategory_controller.text.isEmpty? showMessage(context, text: "Update new gender", color: Colors.red):
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
