import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/feature/admin/screens/product/screens/product_view_page.dart';

import '../../../../../core/constants/contants1.dart';
import '../../../../../main.dart';
import '../../../../../model/category_model.dart';
import '../../addcategory/controller/category_controller.dart';
import '../controller/test_controller.dart';


class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key});

  @override
  ConsumerState<AddProductPage> createState() => _SecondPageRiverpodState();
}

class _SecondPageRiverpodState extends ConsumerState<AddProductPage> {


  final pickImageProvider=StateProvider<File?>((ref) {
    return null;
  });


  final dropDownProvider=StateProvider<String>((ref){
    return "";
  });





// var dropdownvalue;

final dropdownvalue1 =StateProvider<String?>((ref) {
  return null;
});







  final formkey =GlobalKey<FormState>();



  TextEditingController productname_controller=TextEditingController();
  TextEditingController offer_controller=TextEditingController();
  TextEditingController amount_controller=TextEditingController();
  TextEditingController maximum_controller=TextEditingController();
  TextEditingController minimum_controller=TextEditingController();




  var imageurl='';

  pickImage() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png','jpg'],
    );
    final pick=result!.files.first;
    if(pick.size<524288){
        ref.read(pickImageProvider.notifier).update((state) =>File(result.files.single.path!));

      var uploadimage=await FirebaseStorage.instance.ref().child("upload/${DateTime.now()}").putFile(ref.watch(pickImageProvider)!);
      var geturl=await uploadimage.ref.getDownloadURL();
      imageurl=geturl;
      setState(() {
      });


    }else{
      showMessage(context, text: "Please Upload image below 500kb", color: Colors.red);
    }

  }






  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          backgroundColor: themeColor.iconRed,
          title: Text("Add Product"),
        ),
        
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: w*2.5,
            width: w*1,
            child: Form(
              key: formkey,
              child: Column(
                children: [

                  // Column(
                  //   children: List.generate(10, (index) => Container(
                  //     height: 100,
                  //     width: 100,
                  //     color: Colors.red,
                  //   )),
                  // ),




                  Container(
                    height: w*0.634,
                    width: w*1,
                    // color: colors.secondaryColor,
                    child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("Add Product Image",style: TextStyle(
                                fontSize: w*0.055,fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),),
                            ),

                          ],
                        ),
                        SizedBox(height: w*0.02,),
                        Stack(
                          children: [
                            SizedBox(
                                height: w*0.43,
                                width: w*1,
                                child:imageurl==''?
                                CircleAvatar(

                                  backgroundColor: Colors.blueGrey,
                                  radius: 20,
                                  child: Text("Upload image",style: TextStyle(
                                      color: Colors.white
                                  ),),
                                )
                                    : Center(
                                  child: Container(
                                    height: h*0.26,
                                    width: h*0.26,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(h*0.13),
                                        image: DecorationImage(image: FileImage(ref.watch(pickImageProvider)!))
                                    ),

                                    // child: Image(image: NetworkImage(imageurl!),fit: BoxFit.fitHeight,),

                                  ),
                                )
                            ),
                            Positioned(
                              top: w*0.30,
                              left: w*0.6,
                              child:
                              InkWell(
                                onTap: () {
                                  pickImage();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 23,
                                  child: Icon(CupertinoIcons.camera,color: Colors.black,size: w*0.08,),
                                ),
                              ),
                            )

                          ],
                        ),

                      ],
                    ),

                  ),


                  SizedBox(height: w*0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: w*0.1,
                        width: w*1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child:
                        ref.watch(viewCategoryProvider1).when(
                           data: (categoryList){
                            List<String> drops = [];
                            for(CategoryModelRiverpod doc in categoryList){
                              drops.add(doc.productcategory);
                            }
                            return  DropdownButton(
                              underline: SizedBox(),
                              isExpanded: true,
                              hint: Text("select Category"),
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              value: ref.watch(dropdownvalue1),
                              items: categoryList.map((CategoryModelRiverpod e) {
                                return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.productcategory,style: TextStyle(
                                        color: Colors.black,
                                        fontSize: w*0.04,
                                        fontWeight: FontWeight.w500
                                    ),));
                              }
                              ).toList() ,
                              onChanged: (newValue) {

                                ref.watch(dropdownvalue1.notifier).update((state) => newValue.toString());


                                // setState(() {
                                //   print(newValue);
                                //   print("newValue");
                                //   dropdownvalue=newValue!;
                                // }
                                // );
                              },
                            );
                          },
                            error: (error, stackTrace) => Text(error.toString()),
                            loading: () => Center(child: CircularProgressIndicator()),)



                      )
                    ],
                  ),
                  SizedBox(height: w*0.03,),
                  Container(
                    height: w*1.1,
                    width: w*1,
                    padding: EdgeInsets.all(7),
                    // color: Colors.blue,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: w*0.20,
                          width: w*1,
                          child:TextFormField(
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.done,
                            textCapitalization: TextCapitalization.sentences,
                            //maxLength: 5,
                            // maxLines: null,
                            // minLines: 5,
                            controller: productname_controller,
                            style: TextStyle(
                              fontSize: w*0.05,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                labelText: "Enter Product Name",
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
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: w*0.20,
                              width: w*1,
                              child:TextFormField(
                                keyboardType: TextInputType.phone,

                                textInputAction: TextInputAction.done,
                                maxLength: 2,
                                // maxLines: null,
                                // minLines: 5,
                                controller: offer_controller,
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                // ],
                                style: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Enter Product Offer",
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
                                            color: Colors.blueGrey
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
                            ),
                            Container(
                              height: w*0.20,
                              width: w*1,
                              child:TextFormField(
                                keyboardType: TextInputType.phone,

                                textInputAction: TextInputAction.done,
                                // maxLength: 2,
                                // maxLines: null,
                                // minLines: 5,
                                controller: amount_controller,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                ],
                                style: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Enter The Price",
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
                                            color: Colors.blueGrey
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
                            ),
                            Container(
                              height: w*0.20,
                              width: w*1,
                              child:TextFormField(
                                keyboardType: TextInputType.phone,

                                textInputAction: TextInputAction.done,
                                // maxLength: 2,
                                // maxLines: null,
                                // minLines: 5,
                                controller: minimum_controller,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                ],
                                style: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    labelText: "minimum",
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
                                            color: Colors.blueGrey
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
                            ),
                            Container(
                              height: w*0.20,
                              width: w*1,
                              child:TextFormField(
                                keyboardType: TextInputType.phone,

                                textInputAction: TextInputAction.done,
                                // maxLength: 2,
                                // maxLines: null,
                                // minLines: 5,
                                controller: maximum_controller,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                ],
                                style: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    labelText: "maximum",
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
                                            color: Colors.blueGrey
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
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                  InkWell(
                    onTap: ()  {
                      if(productname_controller.text.isNotEmpty&&
                          offer_controller.text.isNotEmpty&&
                          amount_controller.text.isNotEmpty&&
                          minimum_controller.text.isNotEmpty&&
                          maximum_controller.text.isNotEmpty&&
                          imageurl.isNotEmpty
                      ){
                        ref.read(testControllerProvider.notifier).addProduct(category: ref.watch(dropDownProvider), productname: productname_controller.text.trim(), productoffer: offer_controller.text.trim(), productprice: double.parse(amount_controller.text.trim()), image: imageurl,minimum: int.parse(minimum_controller.text.trim()),maximum: int.parse(maximum_controller.text.trim()) );
                       Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProductPage()));
                      }else{
                        productname_controller.text.isEmpty?showMessage(context, text: "Enter Product Name", color: Colors.red):
                        offer_controller.text.isEmpty?showMessage(context, text: "Enter Offer Percentage", color: Colors.red):
                        amount_controller.text.isEmpty?showMessage(context, text: "Enter Product Amount", color: Colors.red):
                        minimum_controller.text.isEmpty?showMessage(context, text: "Enter field minimum", color: Colors.red):
                        maximum_controller.text.isEmpty?showMessage(context, text: "Enter field maximum", color: Colors.red):
                        showMessage(context, text: "Please Upload Image", color: Colors.red);

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
          ),
        ),
      ),
    );

  }
}
