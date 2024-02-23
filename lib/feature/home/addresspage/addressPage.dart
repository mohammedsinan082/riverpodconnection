import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/core/constants/firebase_constants.dart';
import 'package:riverpodconnection/core/providers/firebase_provider.dart';
import 'package:riverpodconnection/feature/home/addresspage/addressController.dart';
import 'package:riverpodconnection/model/addressModel.dart';
import 'package:riverpodconnection/model/user_model.dart';

import '../../../core/constants/contants1.dart';
import '../../../main.dart';

class addressPage extends ConsumerStatefulWidget {
  const addressPage({super.key});

  @override
  ConsumerState createState() => _addressPageState();
}

class _addressPageState extends ConsumerState<addressPage> {



  TextEditingController fullname_controller=TextEditingController();
  TextEditingController phonenumber_controller=TextEditingController();
  TextEditingController pincode_controller=TextEditingController();
  TextEditingController state_controller=TextEditingController();
  TextEditingController city_controller=TextEditingController();
  TextEditingController housenumber_controller=TextEditingController();
  TextEditingController area_controller=TextEditingController();

  final formKey = GlobalKey<FormState>();


  
  final SelectProvider= StateProvider<bool>((ref) {
    return true;
  });



  addAddress(List address){
    ref.read(addressControllerProvider.notifier).addAddress(address: address);
  }






  @override
  Widget build(BuildContext context) {
   var selected= ref.watch(SelectProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add delivery address"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: h*1,
                  width: w*0.9,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          height: w*0.20,
                          width: w*1,
                          child:TextFormField(
                            keyboardType: TextInputType.name,

                            textInputAction: TextInputAction.done,
                            // maxLength: 2,
                            // maxLines: null,
                            // minLines: 5,
                            controller: fullname_controller,
                            style: TextStyle(
                              fontSize: w*0.05,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                labelText: "Full Name(Required)",
                                labelStyle: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.grey,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w*0.01),
                                    borderSide:BorderSide(
                                        color: Colors.blueGrey
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w*0.01),
                                    borderSide:BorderSide(
                                      color: Colors.blueGrey,
                                    )
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: w*0.01,),
                        Container(
                          height: w*0.20,
                          width: w*1,
                          child:TextFormField(
                            keyboardType: TextInputType.phone,

                            textInputAction: TextInputAction.done,
                            maxLength: 10,
                            // maxLength: 2,
                            // maxLines: null,
                            // minLines: 5,
                            controller: phonenumber_controller,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                            ],
                            style: TextStyle(
                              fontSize: w*0.05,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                labelText: "Phone Number(Required)",
                                labelStyle: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.grey,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w*0.01),
                                    borderSide:BorderSide(
                                        color: Colors.blueGrey
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w*0.01),
                                    borderSide:BorderSide(
                                      color: Colors.blueGrey,
                                    )
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 120),
                          child: Text("+ Add Alternative Phone Number",style: TextStyle(color: Colors.blue,fontSize: 17,fontWeight:FontWeight.w500
                          ),),
                        ),
                        SizedBox(height: w*0.02,),
                        Padding(
                          padding: const EdgeInsets.only(right: 100),
                          child: Text("Provide location permission for the app",style: TextStyle(color: Colors.red,fontSize: 15),),
                        ),
                        SizedBox(height: w*0.02,),
                        Row(
                          children: [
                            Container(
                              height: w*0.20,
                              width: w*0.4,
                              child:TextFormField(
                                keyboardType: TextInputType.number,

                                textInputAction: TextInputAction.done,
                                maxLength: 6,
                                // maxLength: 2,
                                // maxLines: null,
                                // minLines: 5,
                                controller: pincode_controller,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                ],
                                style: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    labelText: "pincode",
                                    labelStyle: TextStyle(
                                      fontSize: w*0.05,
                                      color: Colors.grey,
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: w*0.05,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(w*0.01),
                                        borderSide:BorderSide(
                                            color: Colors.blueGrey
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(w*0.01),
                                        borderSide:BorderSide(
                                          color: Colors.blueGrey,
                                        )
                                    )
                                ),
                              ),
                            ),
                            SizedBox(width: w*0.1,),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                height: h*0.06,
                                width: w*0.4,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.my_location,color: Colors.white,),
                                    Text("Use My Location",style: TextStyle(color: Colors.white,fontSize: 17),)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: w*0.02,),
                        Row(
                          children: [
                            Container(
                              height: w*0.20,
                              width: w*0.4,
                              child:TextFormField(
                                keyboardType: TextInputType.name,

                                textInputAction: TextInputAction.done,
                                // maxLength: 2,
                                // maxLines: null,
                                // minLines: 5,
                                controller: state_controller,

                                style: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    labelText: "State(Required)",
                                    labelStyle: TextStyle(
                                      fontSize: w*0.05,
                                      color: Colors.grey,
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: w*0.05,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(w*0.01),
                                        borderSide:BorderSide(
                                            color: Colors.blueGrey
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(w*0.01),
                                        borderSide:BorderSide(
                                          color: Colors.blueGrey,
                                        )
                                    )
                                ),
                              ),
                            ),
                            SizedBox(width: w*0.1,),
                            Container(
                              height: w*0.20,
                              width: w*0.4,
                              child:TextFormField(
                                keyboardType: TextInputType.name,

                                textInputAction: TextInputAction.done,
                                // maxLength: 2,
                                // maxLines: null,
                                // minLines: 5,
                                controller: city_controller,
                                style: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    labelText: "City(Required)",
                                    labelStyle: TextStyle(
                                      fontSize: w*0.05,
                                      color: Colors.grey,
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: w*0.05,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(w*0.01),
                                        borderSide:BorderSide(
                                            color: Colors.blueGrey
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(w*0.01),
                                        borderSide:BorderSide(
                                          color: Colors.blueGrey,
                                        )
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: w*0.02,),
                        Container(
                          height: w*0.20,
                          width: w*1,
                          child:TextFormField(
                            keyboardType: TextInputType.name,

                            textInputAction: TextInputAction.done,
                            // maxLength: 2,
                            // maxLines: null,
                            // minLines: 5,
                            controller:  housenumber_controller,
                            style: TextStyle(
                              fontSize: w*0.05,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                labelText: "House No.,Building Name(Required)",
                                labelStyle: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.grey,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w*0.01),
                                    borderSide:BorderSide(
                                        color: Colors.blueGrey
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w*0.01),
                                    borderSide:BorderSide(
                                      color: Colors.blueGrey,
                                    )
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: w*0.02,),
                        Container(
                          height: w*0.20,
                          width: w*1,
                          child:TextFormField(
                            keyboardType: TextInputType.name,

                            textInputAction: TextInputAction.done,
                            // maxLength: 2,
                            // maxLines: null,
                            // minLines: 5,
                            controller:  area_controller,
                            style: TextStyle(
                              fontSize: w*0.05,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                labelText: "Road name,Area,Colony,(Required)",
                                labelStyle: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.grey,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w*0.01),
                                    borderSide:BorderSide(
                                        color: Colors.blueGrey
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w*0.01),
                                    borderSide:BorderSide(
                                      color: Colors.blueGrey,
                                    )
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 35),
                          child: Text("+ Add Nearby Famous Shop/Mall/LandMark",style: TextStyle(color: Colors.blue,fontSize: 17,fontWeight:FontWeight.w500
                          ),),
                        ),
                        SizedBox(height: w*0.02,),
                        Padding(
                          padding: const EdgeInsets.only(right: 220),
                          child: Text("Type Of Address",style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight:FontWeight.w500
                          ),),
                        ),
                        SizedBox(height: w*0.02,),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                             //   selected=!selected;
                                ref.read(SelectProvider.notifier).update((state) => !selected);
                              },
                              child: Container(
                                height: h*0.045,
                                width: w*0.32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all( color:selected==true ? Colors.grey:Colors.blue,width: 1.3)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.home,color: selected==true ? Colors.grey.shade700:Colors.blue,size: 30,),
                                    Text("Home",style: TextStyle(color: selected==true ?Colors.grey.shade700:Colors.blue,fontSize: 20),)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: w*0.1,),
                            InkWell(
                              onTap: () {
                                ref.read(SelectProvider.notifier).update((state) => !selected);
                              },
                              child: Container(
                                height: h*0.045,
                                width: w*0.32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color:selected==false ? Colors.grey:Colors.blue,width: 1.3)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.work_history,color: selected==false ? Colors.grey.shade700:Colors.blue,size: 25,),
                                    Text("Work",style: TextStyle(color: selected==false ? Colors.grey.shade700:Colors.blue,fontSize: 20),)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: w*0.02,),
                        InkWell(
                          onTap: ()async {
                            // final snapshot=await ref.read(firestoreProvider).collection(RiverpodConstants.user).doc(currentuserid).get();
                            // UserModel model =UserModel.fromJson(snapshot.data());
                            //
                            // var a = AddressModel(
                            //   fullname: fullname_controller.text.trim(),
                            //   phonenumber: phonenumber_controller.text.trim(),
                            //   pincode: pincode_controller.text.trim(),
                            //   state: state_controller.text.trim(),
                            //   city: city_controller.text.trim(),
                            //   housenumber: housenumber_controller.text.trim(),
                            //   area: area_controller.text.trim(),
                            //   name: '',
                            //   address: '',
                            // );
                            //
                            // if(formKey.currentState!.validate()&&
                            //    fullname_controller.text!=""&&
                            //    phonenumber_controller.text!=""&&
                            //    pincode_controller.text!=""&&
                            //    state_controller.text!=""&&
                            //    city_controller.text!=""&&
                            //    housenumber_controller.text!=""&&
                            //    area_controller.text!=""){
                            //
                            //
                            //
                            //
                            //
                            //
                            //
                            //
                            //   if(model.address.isNotEmpty){
                            //     for(int i=0;i<=model.address.length;i++){
                            //
                            //       addressModel c =addressModel.fromJson(model.address[i]);
                            //       addressModel address =addressModel.fromJson(snapshot.data());
                            //
                            //       if(c.fullname == address.fullname&&
                            //           c.phonenumber == address.phonenumber&&
                            //           c.pincode == address.pincode&&
                            //           c.state == address.state&&
                            //           c.city == address.city&&
                            //           c.housenumber == address.housenumber&&
                            //           c.area == address.area
                            //       ){
                            //         print('55555555555555555555555555555555555');
                            //         print(address.fullname);
                            //               showMessage(context, text: "Already submitted", color: Colors.red);
                            //
                            //       }else{
                            //         addAddress([a.toJson()]);
                            //         showMessage(context, text: "Submitted Succesfully", color: Colors.green);
                            //         Navigator.pop(context);
                            //
                            //       }
                            //
                            //     }
                            //   }else{
                            //     addAddress([a.toJson()]);
                            //   }
                            //
                            //
                            // }else{
                            //   fullname_controller.text.isEmpty ? showMessage(context, text: "Enter Your Name", color: Colors.red):
                            //   phonenumber_controller.text.isEmpty ? showMessage(context, text: "Enter Your Phonenumber", color: Colors.red):
                            //       pincode_controller.text.isEmpty ? showMessage(context, text: "Enter your PostalPin", color: Colors.red):
                            //       state_controller.text.isEmpty ? showMessage(context, text: "Enter your State", color: Colors.red):
                            //       city_controller.text.isEmpty ? showMessage(context, text: "Enter your City", color: Colors.red):
                            //       housenumber_controller.text.isEmpty ? showMessage(context, text: "Enter your housenumber", color: Colors.red):
                            //       showMessage(context, text: "Enter your Area/Colony", color: Colors.red);
                            //
                            // }


                          },
                          child: Container(
                            height: h*0.08,
                            width: w*0.9,
                            color: themeColor.iconRed,
                            child: Center(child: Text("Save Address",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25))),
                          ),
                        )


                      ],
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
