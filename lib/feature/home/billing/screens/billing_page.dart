import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/feature/auth/controller/auth_controller.dart';
import 'package:riverpodconnection/feature/home/addresspage/addressPage.dart';
import 'package:riverpodconnection/feature/home/productcart/controller/productcartcontroller.dart';

import '../../../../main.dart';
import '../../../../model/cartModel.dart';

class BillingPage extends ConsumerStatefulWidget {
  final double total;
  const BillingPage({super.key,required this.total});

  @override
  ConsumerState<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends ConsumerState<BillingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Billing Page",style: TextStyle(color: Colors.black,fontSize: w*0.06),),
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => addressPage(),));
            },
              child: Icon(Icons.add,size: w*0.09,color: Colors.black,)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: h*0.75,
                width: w*1,
                child: Column(
                  children: [

                    ref.watch(cartListStreamProvider(currentuserid)).when(
                      data: (data){
                        return Expanded(
                          child: ListView.builder(
                            itemCount: data.productKart.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              // return ListBuilder1(data: data.productKart[index],index: index,);
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      height: h*0.17,
                                      width: w*0.97,
                                   decoration: BoxDecoration(
                                     color: Colors.grey.shade300,),
                                   //   color: Colors.red,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: h*0.11,
                                                  width: w*0.2,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black,
                                                          blurRadius: 2.0,
                                                          offset: Offset(1.0, 1.0),),],
                                                      image: DecorationImage(
                                                        image:NetworkImage(data.productKart[index]['productImage']),fit: BoxFit.fill,)
                                                  ),
                                                ),
                                                Container(
                                                  height: w*0.29,
                                                  width: w*0.7,
                                                  //   color: Colors.blue,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: w*0.4,
                                                        width: w*0.35,
                                                      //   color: Colors.orange,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                Text(data.productKart[index]['productName'],style: TextStyle(
                                                                  fontSize: 17,fontWeight: FontWeight.bold
                                                                ),),
                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                      ),

                                                      Container(
                                                        height: w*0.2,
                                                        width: w*0.35,
                                                    //      color: Colors.green,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text("\$",style: TextStyle(fontSize: 17,color: themeColor.black,fontWeight: FontWeight.bold),),
                                                                Text(data.productKart[index]['amount'] == 0 ?   data.productKart[index]['amount']  : "${data.productKart[index]['amount']*data.productKart[index]['quantity']}" ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: themeColor.black),),
                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },),
                        );
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => CircularProgressIndicator(),),


                  ],
                ),
              ),
            ),
            Container(
              height: h*0.15,
              width: w*0.9,
           //   color: Colors.red,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: w*0.3,
                        width: w*0.3,
                      //  color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Gst : ",style: TextStyle(fontSize: 15),),

                              ],
                            ),
                            SizedBox(height: w*0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("delivery charge : ",style: TextStyle(fontSize: 15),),

                              ],
                            ),
                            SizedBox(height: w*0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Grand Total : ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),


                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: w*0.3,
                        width: w*0.25,
                     //   color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text("5",style: TextStyle(fontSize: 15),),

                              ],
                            ),
                            SizedBox(height: w*0.02,),
                            Row(

                              children: [
                                Text("30",style: TextStyle(fontSize: 15),),

                              ],
                            ),
                            SizedBox(height: w*0.02,),
                            Row(

                              children: [
                                Text(widget.total.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),


                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Container(
                          height: h*0.045,
                          width: w*0.35,
                          decoration: BoxDecoration(
                              color: themeColor.iconRed,
                              borderRadius: BorderRadius.circular(7)),
                          child:Center(child: Text("Make Payment",style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.04),)),
                        ),
                      )
                    ],
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
