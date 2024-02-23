import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/core/constants/firebase_constants.dart';
import 'package:riverpodconnection/core/providers/firebase_provider.dart';
import 'package:riverpodconnection/feature/home/billing/screens/billing_page.dart';
import 'package:riverpodconnection/model/cartModel.dart';
import 'package:riverpodconnection/model/user_model.dart';

import '../../../../main.dart';
import '../../../auth/controller/auth_controller.dart';
import '../controller/productcartcontroller.dart';


class ProductCartPage extends ConsumerStatefulWidget {
  const ProductCartPage({super.key});



  @override
  ConsumerState createState() => _ProductCartPageState();


}

class _ProductCartPageState extends ConsumerState<ProductCartPage> {




  final cartListProvider=StateProvider<List<String>>((ref) => []);



  removeFromCart({required String productName,required String productId,
    required String productImage,required double amount,required int quantity,required int minimum,required int maximum,
    required int index, required WidgetRef ref
  }){
    ref.read(cartControllerProvider.notifier).removeFromCartList(
        productId: productId,
        productName: productName,
        productImage: productImage,
        amount: amount,
        quantity: quantity,
        index: index,
        minimum:minimum,
        maximum:maximum,
    );
  }


  increment({required CartModel cart,required WidgetRef ref}) async {
    if(cart.quantity<=cart.maximum){
      var a=CartModel(
          productName: cart.productName,
          productId: cart.productId,
          productImage: cart.productImage,
          amount: double.parse(cart.amount.toString()),
          minimum: cart.minimum,
          maximum: cart.maximum,
          quantity: cart.quantity+1);


      final snapshot =await ref.read(firestoreProvider).collection(RiverpodConstants.user).doc(currentuserid).get();
      UserModel model=UserModel.fromJson(snapshot.data());

      for(int i =0; i< model.productKart.length; i++){

        CartModel c =CartModel.fromJson(model.productKart[i]);

        if(cart.productName == c.productName&&
            cart.productId == c.productId &&
            cart.productImage == c.productImage){


           cartIndex =i;
          var cart =model.productKart;
          cart.removeAt(cartIndex);
          cart.insert(cartIndex, a.toJson());
          addCart(ref,cart);
          break;
        }
      }

    }
  }

  decrement({required CartModel cart,required WidgetRef ref,index}) async{
    if(cart.quantity>cart.minimum){
      var a=CartModel(
          productName: cart.productName,
          productId: cart.productId,
          productImage: cart.productImage,
          amount: double.parse(cart.amount.toString()),
          minimum: cart.minimum,
          maximum: cart.maximum,
          quantity: cart.quantity-1
      );


      final snapshot =await ref.read(firestoreProvider).collection(RiverpodConstants.user).doc(currentuserid).get();
      UserModel model=UserModel.fromJson(snapshot.data());

      for(int i =0; i< model.productKart.length; i++){
        CartModel c = CartModel.fromJson(model.productKart[i]);

        if(cart.productName== c.productName&&
            cart.productId == c.productId&&
            cart.productImage== c.productImage){



          cartIndex =i;

          var cart =model.productKart;
          cart.removeAt(cartIndex);
          cart.insert(cartIndex, a.toJson());
          addCart(ref,cart);
          break;
        }
      }
    }else{
      showDialog(context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text("Are You Sure")),
            actions: [
              InkWell(
                onTap: () {
                  removeFromCart(
                      productName: cart.productName,
                      productId: cart.productId,
                      productImage: cart.productImage,
                      amount: cart.amount,
                      quantity: cart.quantity,
                      minimum: cart.minimum,
                      maximum: cart.maximum,
                      index: index,
                      ref: ref);
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



    }
  }


  removeAllCartList() async {
    await ref.read(cartControllerProvider.notifier).removeAllCartList(
        id: currentuserid

    );
    total=0;
  }

  double total=0;




  int cartIndex=0;
  void addCart(WidgetRef ref,List cart){
    ref.read(cartControllerProvider.notifier).updateToCart(cart);
  }










  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeColor.iconRed,
        title: Text("cart"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                await removeAllCartList();
              },
              child: Container(
                height: w*0.1,
                width: w*1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 300,top: 5),
                  child: Text("Remove All",style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.w600,fontSize: 15,color: Colors.red),),
                ),
              ),
            ),
            ref.watch(cartListStreamProvider(currentuserid)).when(
              data: (data){
                total=0;
                for(int i=0;i<data.productKart.length;i++){
                  total+=data.productKart[i]['amount']*data.productKart[i]['quantity'];
                }
                return ListView.builder(
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
                            width: w*1,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: h*0.14,
                                        width: w*0.25,
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
                                              //  color: Colors.red,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(data.productKart[index]['productName']),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                          onTap: () async {
                                                            CartModel cart = CartModel.fromJson(data.productKart[index]);
                                                            increment(cart: cart,ref: ref);


                                                          },
                                                          child: data.productKart[index]['quantity'] >data.productKart[index]['maximum']? Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: CircleAvatar(
                                                              radius: w*0.037,
                                                              backgroundColor:Colors.transparent,
                                                              child: Text(""),

                                                            ),
                                                          ):
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: CircleAvatar(
                                                              radius: w*0.037,
                                                              backgroundColor:data.productKart[index]['quantity']==10?Colors.grey[400]: Colors.grey[400],
                                                              child: Icon(Icons.add,size: w*0.055,),

                                                            ),
                                                          )
                                                      ),
                                                      Container(
                                                        height: w*0.1,
                                                        width: w*0.1,
                                                        color: Colors.transparent,
                                                        child: Center(
                                                          child: Text(data.productKart[index]['quantity'].toString(),style: TextStyle(
                                                              fontSize: w*0.07
                                                          ),),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          // if(data.productKart[index]['quantity']==data.productKart[index]['minimum']){
                                                          //   removeFromCart(
                                                          //       productName: data.productKart[index]['productName'],
                                                          //       productId: data.productKart[index]['productId'],
                                                          //       productImage: data.productKart[index]['productImage'],
                                                          //       amount: data.productKart[index]['amount'],
                                                          //       quantity: data.productKart[index]['quantity'],
                                                          //       minimum: data.productKart[index]['minimum'],
                                                          //       maximum: data.productKart[index]['maximum'],
                                                          //       index: index,
                                                          //       ref: ref);
                                                          // }
                                                           CartModel cart =CartModel.fromJson(data.productKart[index]);
                                                          decrement(cart: cart,ref: ref,index: index);








                                                          // Decrement();
                                                        },
                                                        child:data.productKart[index]['amount'] >1? Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: CircleAvatar(
                                                            radius: w*0.037,
                                                            backgroundColor:data.productKart[index]['amount'] >0? Colors.grey[400]:Colors.grey[400],
                                                            child: Icon(Icons.remove,size: w*0.055,),
                                                          ),
                                                        ): Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: CircleAvatar(
                                                            radius: w*0.037,
                                                            backgroundColor:Colors.transparent,
                                                            child: Text(""),

                                                          ),
                                                        ),

                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                            SizedBox(width: w*0.03,),
                                            Container(
                                              height: w*0.39,
                                              width: w*0.32,
                                              //  color: Colors.red,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("\$",style: TextStyle(fontSize: 17,color: themeColor.black,fontWeight: FontWeight.bold),),
                                                      Text(data.productKart[index]['amount'] == 0 ?   data.productKart[index]['amount']  : "${data.productKart[index]['amount']*data.productKart[index]['quantity']}" ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: themeColor.black),),
                                                    ],
                                                  ),
                                                  SizedBox(height: w*0.08,),
                                                  Text("Save for Later",style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue),),
                                                  SizedBox(height: w*0.04,),
                                                  InkWell(
                                                      onTap: () {
                                                        removeFromCart(
                                                            productName: data.productKart[index]['productName'],
                                                            productId: data.productKart[index]['productId'],
                                                            productImage: data.productKart[index]['productImage'],
                                                            amount: data.productKart[index]['amount'],
                                                            quantity: data.productKart[index]['quantity'],
                                                            minimum: data.productKart[index]['minimum'],
                                                            maximum: data.productKart[index]['maximum'],
                                                            index: index,
                                                            ref: ref
                                                        );
                                                      },
                                                      child: Text("Remove",style: TextStyle(decoration: TextDecoration.underline,color: Colors.red),)),
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
                  },);
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => CircularProgressIndicator(),),
            Divider(
              color: Colors.black,
              indent: 9,
              endIndent:8,
              height: 15,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: w*0.2,
                    width: w*0.7,
                 //   color: Colors.blue,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: w*0.1,
                              width: w*0.2,
                            //  color: Colors.red,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Sub-Total"),
                                      Text("items")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("\$",style: TextStyle(fontSize: 17,color: themeColor.black,fontWeight: FontWeight.bold),),
                                Text(total.toString(),style: TextStyle(fontSize: w*0.06,fontWeight: FontWeight.bold),)
                              ],
                            )

                          ],
                        ),
                        SizedBox(height: w*0.01,),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BillingPage(total: total),));
                          },
                          child: Container(
                            height: w*0.08,
                            width: w*0.4,
                            decoration: BoxDecoration(
                                color: themeColor.iconRed,
                              boxShadow:[
                                BoxShadow(
                                color: Colors.black,
                                  blurRadius: 1,
                                  offset:Offset(1.0,2.0) ),],
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(child: Text("CheckOut")),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}





