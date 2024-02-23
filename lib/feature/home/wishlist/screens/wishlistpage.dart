import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/feature/admin/screens/product/controller/test_controller.dart';
import 'package:riverpodconnection/feature/auth/controller/auth_controller.dart';

import '../../../../main.dart';
import '../controller/wishlistcontroller.dart';

class WishListPage extends ConsumerStatefulWidget {
  const WishListPage({super.key});

  @override
  ConsumerState createState() => _WishListPageState();
}

class _WishListPageState extends ConsumerState<WishListPage> {

  final wishListProvider=StateProvider<List<String>>((ref) => []);




  // removeFromWishList({required String productName, required String productId,
  //   required String productImage, required double amount
  // }){
  //   ref.read(WishListControllerProvider.notifier).deleteFromWishList({
  //
  //     "productName" : productName,
  //     "productId" : productId,
  //     "productImage" : productImage,
  //     "amount" : amount
  //
  //   });
  //   print("+++++++++++++++");
  // }

  deleteFromWishList({required String productId}){
    ref.read(WishListControllerProvider.notifier).deleteFromWishList(
        productId: productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Favourites"),
        backgroundColor: themeColor.iconRed,
      ),
      body: Column(
        children: [
          Expanded(
            child: ref.watch(wishListStreamProvider(currentuserid)).when(
                data: (data){
                  return ListView.builder(
                    itemCount: data.wishlist.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ref.watch(streamDataWishList(data.wishlist[index])).when(
                          data: (product) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: h*0.17,
                                    width: w*0.9,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(w*0.02)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: h*0.149,
                                                width: w*0.33,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 8.0,
                                                        offset: Offset(1.0, 1.0),),],
                                                    borderRadius: BorderRadius.circular(w*0.03),
                                                    image: DecorationImage(
                                                      image:NetworkImage(product.image),fit: BoxFit.fill,)
                                                ),
                                              ),
                                              Container(
                                                height: h*0.1,
                                                width: w*0.5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Product Name:   ${product.productname}",style: TextStyle(fontWeight: FontWeight.w500),),
                                                    SizedBox(height: w*0.1,),
                                                    Text("Product Price:   ${product.amount}", style: TextStyle(fontWeight: FontWeight.w500),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: h*0.1,
                                    width: w*0.9,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                             ref.read(wishListProvider.notifier).update((state) {
                                             deleteFromWishList(productId:product.id );
                                             state.remove(product.id);
                                             return state;



                                                Navigator.pop(context);
                                              });
                                              },
                                              child: Text("Remove"),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red
                                              )),
                                          ElevatedButton(
                                              onPressed: () {

                                              },
                                              child: Text("Add to cart")
                                              ,style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue
                                          )),
                                        ]
                                    ),
                                  )
                                ],
                              ),

                            );
                          },
                          error: (error, stackTrace) => Text(error.toString()),
                          loading: () => CircularProgressIndicator(),
                      );
                    },);
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => CircularProgressIndicator(),),
          )
        ],
      ),
    );
  }
}
