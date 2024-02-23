import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/core/constants/contants1.dart';
import 'package:riverpodconnection/core/constants/firebase_constants.dart';
import 'package:riverpodconnection/core/providers/firebase_provider.dart';
import 'package:riverpodconnection/feature/admin/screens/product/screens/add_product_page.dart';
import 'package:riverpodconnection/feature/home/productcart/controller/productcartcontroller.dart';
import 'package:riverpodconnection/feature/home/productcart/screens/productcart.dart';
import 'package:riverpodconnection/model/cartModel.dart';
import 'package:riverpodconnection/model/product_model.dart';
import 'package:riverpodconnection/model/user_model.dart';

import '../../main.dart';

class ProductList extends ConsumerStatefulWidget {
  final ProductModel productModel;
  const ProductList(this.productModel, {super.key});

  @override
  ConsumerState<ProductList> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {


  // void updateProduct(){
  //   ref.read(provider)
  // }


  addProductToCart(List cart){
    ref.read(cartControllerProvider.notifier).addToCartList(cart: cart);
  }




  final countProvider=StateProvider.autoDispose<int>((ref) {
    return 1;
  });

  final amountProvider=StateProvider<double>((ref) {
    return 0;
  });

  final sizeProvider=StateProvider<int>((ref) {
    return 0;
  });

  final textProvider=StateProvider<int>((ref) {
    return 0;
  });

  List<Map> background=[
    {
      "color":Colors.black,

    },
    {
      "color":Colors.red,
    },
    {
      "color":Colors.green,
    },
    {
      "color":Colors.blue,
    }
  ];


  List<Map> sizecount=[
    {
      "text":"US 6",

    },
    {
      "text":"US 7",
    },
    {
      "text":"US 8",
    },
    {
      "text":"US 9",
    }
  ];


  int size=0;
  int text=0;


  int selectcolor=0;



  int count =0;
  void Increment (){
    if(count==10){
      count=10;
    }else{
      count++;
    }

    setState(() {

    });
  }

  void Decrement (){
    if(count<=0){
      count=0;
    }else {
      count--;
      setState(() {

      });
    }
  }



  @override
  Widget build(BuildContext context) {
    var productName=widget.productModel.productname;
    var productImage=widget.productModel.image;
    var productId=widget.productModel.id;
    var productPrice=widget.productModel.amount;
    var image=widget.productModel.image;
    int counting = ref.watch(countProvider);

    var a=CartModel(
        productName: widget.productModel.productname,
        productId: widget.productModel.id,
        productImage: widget.productModel.image,
        amount: widget.productModel.amount,
        quantity: ref.watch(countProvider) == 1 ? widget.productModel.minimum : ref.watch(countProvider),
        minimum: widget.productModel.minimum,
        maximum: widget.productModel.maximum
    );
    return Scaffold(
      floatingActionButton:FloatingActionButton(
        onPressed: () async {
          final snapshot =await ref.read(firestoreProvider).collection(RiverpodConstants.user).doc(currentuserid).get();
          UserModel model=UserModel.fromJson(snapshot.data());
          if(model.productKart.isNotEmpty){
            print("+++++++++++++++++++++++");
            print(model.productKart);
            for(int i = 0; i <= model.productKart.length; i++){
              if(model.productKart[i]['productId'] == widget.productModel.id){
                int qut = model.productKart[i]['quantity'];
                Map<String,dynamic> map = model.productKart[i];
                map['quantity'] = counting==1?widget.productModel.minimum+qut: counting+qut;
                print("********************");
                print(model.productKart);
                if(model.productKart[i]['quantity']<=widget.productModel.maximum){

                  UserModel user = model.copywith(productKart: model.productKart);
                  model.reference.update(user.toJson());
                }

                break;
              }
              else{
                addProductToCart([a.toJson()]);
              }
              // print("________________________");
              //
              // if(productName == model.productKart[i]['productName']&&
              //     productId == model.productKart[i]['productId'] &&
              //     productImage == model.productKart[i]['productImage']){
              //   print("+++++++++++++++++++++++");
              //   int qut=model.productKart[i]['quantity'];
              //   int cartIndex =i;
              //   var count =model.productKart;
              //   var ab=CartModel(
              //       productName: widget.productModel.productname,
              //       productId: widget.productModel.id,
              //       productImage: widget.productModel.image,
              //       amount: widget.productModel.amount,
              //       quantity: counting==1?widget.productModel.minimum+qut: counting+qut,
              //       minimum: widget.productModel.minimum,
              //       maximum: widget.productModel.maximum
              //   );
              //
              //     var cart =model.productKart;
              //    cart.removeAt(cartIndex);
              //     cart.insert(cartIndex, ab.toJson());
              //      addProductToCart(cart);
              //
              //      showMessage(context, text: "Product Added To Cart", color: Colors.green);
              //
              //
              //
              //
              //  //   var cart =model.productKart;
              // //  cart.removeAt(cartIndex);
              // //   cart.insert(cartIndex, a.toJson());
              // //   addProductToCart(cart);
              //   break;
              // }else{
              //   print("************************");
              //   print(a.minimum);
              //   addProductToCart([a.toJson()]);
              // }
            }
          }
          else{
            print(a.minimum);
            print(")))))))))))))))))))0");
            addProductToCart([a.toJson()]);
          }


          // ref.read(cartControllerProvider.notifier).addToCartList(
          //     cart:[a.toJson()]);
         Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCartPage(),));

        },
        backgroundColor: themeColor.primarycolor,
        child: Icon(Icons.shopping_bag),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.grey,)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 15,
              child: Icon(Icons.favorite,color: Colors.red,size: 15,),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color:  Colors.grey.shade200,
          child: Column(
            children: [
              Container(
                height: h*0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(image))
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Container(
                      height: w*0.17,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(productName,style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 20
                              ),),
                              Row(
                                children: [
                                  Text("\$",style: TextStyle(fontSize: 10,color: themeColor.primarycolor),),
                                  Text(counting == 0 ? productPrice.toString() : "${counting*productPrice}" ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: themeColor.primarycolor),),
                                ],
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("",style: TextStyle(
                                  fontSize: 13,color: themeColor.greycolor
                              ),),
                              Row(
                                children: [
                                  Icon(Icons.star,color: Colors.yellow,size: 15,),
                                  SizedBox(width: w*0.01,),
                                  Text("4.3",style: TextStyle(
                                      color: themeColor.greycolor,fontSize: 11
                                  ),)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: w*0.07,),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Size",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),

                          Container(
                              width: w*0.7,
                              height: w*0.1,
                              child: Container(
                                height: w*0.04,
                                width: w*0.1,

                                child: Consumer(
                                  builder: (context,ref,child) {
                                    int size=ref.watch(sizeProvider);
                                    int text=ref.watch(textProvider);
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 4,
                                      itemBuilder: (context, index) {

                                        return
                                          Padding(
                                            padding: const EdgeInsets.only(right: 25),
                                            child: InkWell(
                                              onTap: () {

                                                ref.read(sizeProvider.notifier).update((state) => index);
                                                ref.read(textProvider.notifier).update((state) => index);


                                                // setState(() {
                                                //   size=index;
                                                //   text=index;
                                                //
                                                // });

                                              },
                                              child: Container(
                                                height: w*0.04,
                                                width: w*0.12,
                                                decoration: BoxDecoration(
                                                    color:index==size?Colors.black:Colors.white,
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(width: 1,color: themeColor.greycolor)
                                                ),
                                                child: Center(child: Text(sizecount[index]['text'],style: TextStyle(
                                                    color: index==text?Colors.white:Colors.grey.shade600
                                                ),),),
                                              ),
                                            ),
                                          );
                                      },);
                                  }
                                ),
                              )

                          )
                        ],
                      ),
                    ),
                    SizedBox(height: w*0.05,),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Count",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),

                          Container(
                            height: w*0.15,
                            width: w*0.5,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if(counting <= widget.productModel.maximum) {
                                          if (counting == 1) {
                                            ref.read(countProvider.notifier).update((state) => widget.productModel.minimum );
                                          }
                                          else {
                                            ref.read(countProvider.notifier).state++;
                                          }
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: w*0.05,
                                        backgroundColor:counting>=widget.productModel.maximum?Colors.grey[400]: Colors.white,
                                        child: Icon(Icons.add,size: w*0.09,),

                                      ),
                                    ),
                                    Container(
                                      height: w*0.1,
                                      width: w*0.1,
                                      color: Colors.transparent,
                                      child: Center(
                                        child: Text(counting == 1 ? widget.productModel.minimum.toString() : counting.toString(),style: TextStyle(
                                            fontSize: w*0.08
                                        ),),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if(counting>widget.productModel.minimum){
                                          ref.read(countProvider.notifier).state--;
                                        }
                                        // Decrement();
                                      },
                                      child: CircleAvatar(
                                        radius: w*0.05,
                                        backgroundColor:counting >widget.productModel.minimum? Colors.white:Colors.grey[400],
                                        child: Icon(Icons.remove,size: w*0.09,),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Description",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Text("someetimes fashion looks fast.these sci-fi inspired trained are bold and colourful because their named retro design notes optimistically point to better")
                          ],
                        )),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
