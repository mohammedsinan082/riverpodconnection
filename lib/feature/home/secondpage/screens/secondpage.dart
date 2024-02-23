
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/feature/home/productdetails.dart';
import 'package:riverpodconnection/feature/home/wishlist/controller/wishlistcontroller.dart';
import 'package:riverpodconnection/feature/home/wishlist/screens/wishlistpage.dart';

import '../../../../main.dart';
import '../../../../model/category_model.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../productcart/screens/productcart.dart';
import '../controller/SecondPage_controller.dart';

List <String> category1=["Watch","Shoes","Shirt","Bags"];


final res=StateProvider<bool>((ref) => false);




final categoryItemsProvider1 = StateProvider<String?>((ref) {
  return null;
});

final ratingItemsProvider1 = StateProvider<double>((ref) {
  return 0;
});



final wishListProvider=StateProvider<List<String>>((ref) => []);

final cartListProvider=StateProvider<List<String>>((ref) => []);

class secondPage extends ConsumerStatefulWidget {
  const secondPage( {super.key});

  @override
  ConsumerState<secondPage> createState() => _secondPageState();
}

class _secondPageState extends ConsumerState<secondPage> {


  var dropdownvalue;





addToWishList({required String productId,
}){
  ref.read(WishListControllerProvider.notifier).addToWishList(productId: productId);
}

deleteFromWishList({required String productId}){
  ref.read(WishListControllerProvider.notifier).deleteFromWishList(productId: productId);
}





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
// }







  List<Map> sportsshoes=[
    {
      "image":Image.asset("images/nike1.png"),
      "backgroundcolor":Colors.orange.shade50,
      "backgroundcolor1":Colors.orange.shade100,
      "backgroundcolor2":Colors.orange.shade200,
      "backgroundcolor3":Colors.orange.shade300,


    },
    {
      "image":Image.asset("images/img_shoes.png"),
      "backgroundcolor":Colors.red.shade50,
      "backgroundcolor1":Colors.red.shade100,
      "backgroundcolor2":Colors.red.shade200,
      "backgroundcolor3":Colors.red.shade300,
    },
    {
      "image":Image.asset("images/shoes_1.png"),
      "backgroundcolor":Colors.blue.shade50,
      "backgroundcolor1":Colors.blue.shade100,
      "backgroundcolor2":Colors.blue.shade200,
      "backgroundcolor3":Colors.blue.shade300,
    },
    {
      "image":Image.asset("images/shoes_2.png"),
      "backgroundcolor":Colors.green.shade50,
      "backgroundcolor1":Colors.green.shade100,
      "backgroundcolor2":Colors.green.shade200,
      "backgroundcolor3":Colors.green.shade300,
    },
    {
      "image":Image.asset("images/shoes_3.png"),
      "backgroundcolor":Colors.purple.shade50,
      "backgroundcolor1":Colors.purple.shade100,
      "backgroundcolor2":Colors.purple.shade200,
      "backgroundcolor3":Colors.purple.shade300,
    },
    {
      "image":Image.asset("images/shoes_4.png"),
      "backgroundcolor":Colors.yellow.shade50,
      "backgroundcolor1":Colors.yellow.shade100,
      "backgroundcolor2":Colors.yellow.shade200,
      "backgroundcolor3":Colors.yellow.shade300,
    },
    {
      "image":Image.asset("images/img_shoes.png"),
      "backgroundcolor":Colors.red.shade50,
      "backgroundcolor1":Colors.red.shade100,
      "backgroundcolor2":Colors.red.shade200,
      "backgroundcolor3":Colors.red.shade300,
    },
    {
      "image":Image.asset("images/shoes_1.png"),
      "backgroundcolor":Colors.blue.shade50,
      "backgroundcolor1":Colors.blue.shade100,
      "backgroundcolor2":Colors.blue.shade200,
      "backgroundcolor3":Colors.blue.shade300,
    },
    {
      "image":Image.asset("images/shoes_2.png"),
      "backgroundcolor":Colors.green.shade50,
      "backgroundcolor1":Colors.green.shade100,
      "backgroundcolor2":Colors.green.shade200,
      "backgroundcolor3":Colors.green.shade300,
    },
  ];

  int selected=0;



  List<String> fav=[];
  bool borde=true;





  @override
  Widget build(BuildContext context) {
    final rating=ref.watch(ratingItemsProvider1);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          elevation: 0,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundColor: themeColor.secondarycolor,
              radius: w*0.03,
              child: Icon(Icons.widgets,color: themeColor.primarycolor,),
            ),
          ),

          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WishListPage(),));
              },
              child: Container(
                  height: h*0.1,
                  width: w*0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(Icons.favorite_border,color: themeColor.primarycolor,)
              ),
            ),
            SizedBox(width: w*0.02,),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCartPage(),));
              },
              child: Container(
                  height: h*0.1,
                  width: w*0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                     ),
                  child: Icon(Icons.shopping_bag,color: themeColor.primarycolor,)
                  ),
            ),

            SizedBox(width: w*0.03,),
            Container(
              height: h*0.1,
              width: w*0.1,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                  image: DecorationImage(image: NetworkImage(currentuserimage))
              ),
            ),




          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 5,right: 5,top: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: h*0.07,
                    width: w*0.75,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          // enabledBorder:InputBorder.none,
                          suffixIcon: Icon(Icons.search,color: Colors.grey,),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w*0.02),
                              borderSide: BorderSide.none
                          ),
                          hintText: "Sports shoes"
                      ),



                    ),
                  ),
                  Container(
                    height: h*0.07,
                    width: w*0.14,
                    decoration: BoxDecoration(
                        color: themeColor.primarycolor,
                        borderRadius: BorderRadius.circular(w*0.02)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: w*0.02,
                              width: w*0.02,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2)
                              ),
                            ),
                            SizedBox(width: w*0.008,),
                            Container(
                              height: w*0.013,
                              width: w*0.04,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2)
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: w*0.013,
                              width: w*0.04,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2)
                              ),
                            ),
                            SizedBox(width: w*0.008,),
                            Container(
                              height: w*0.02,
                              width: w*0.02,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2)
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: w*0.04,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( ref.watch(categoryItemsProvider1)??'All' ,style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: w*0.05
                  ),),
                  Container(
                    height: w*0.07,
                    width: w*0.25,
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Consumer(
                      builder: (context,ref,child) {
                        var data=ref.watch(CategoryStreamProvider1);
                        return data.when(
                          data: (data){
                          print("data");
                          print(data.length);
                          print("data");
                          return DropdownButton(
                            underline: SizedBox(),
                            isExpanded: true,
                            hint: Text("Category"),
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            value: ref.watch(categoryItemsProvider1),
                            items: data.map((CategoryModelRiverpod e) {
                              return DropdownMenuItem(
                                  value: e.productcategory,
                                  child: Text(e.productcategory,style: TextStyle(
                                      color: Colors.black,
                                      fontSize: w*0.04,
                                      fontWeight: FontWeight.w500
                                  ),));
                            }
                            ).toList() ,
                            onChanged: (newValue) {
                              print(newValue);

                              print("newValue");
                              ref.read(categoryItemsProvider1.notifier).update((state) => newValue.toString());
                              //  dropdownvalue=newValue!;

                            },);
                        }, error: (error, stackTrace) {
                          print(error);
                          return SizedBox();
                        }, loading: () => CircularProgressIndicator(),);
                      }
                    )
                    // ref.watch(CategoryStreamProvider1).when(
                    //     data: (categoryList){
                    //       return    DropdownButton(
                    //         underline: SizedBox(),
                    //         isExpanded: true,
                    //         hint: Text("Categories"),
                    //         icon: Icon(Icons.keyboard_arrow_down_outlined),
                    //         value: "Watch",
                    //         items: category1.map((String e) {
                    //           return DropdownMenuItem(
                    //                 value: e,
                    //                 child: Text(e,style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: w*0.04,
                    //                     fontWeight: FontWeight.w500
                    //                 ),));
                    //         }
                    //         ).toList() ,
                    //         onChanged: (newValue) {
                    //           setState(() {
                    //             print(newValue);
                    //             print("newValue");
                    //              ref.read(categoryItemsProvider1.notifier).update((state) => newValue.toString());
                    //           //  dropdownvalue=newValue!;
                    //           });
                    //         },);
                    //     },
                    //     error: (error, stackTrace) => Text(error.toString()),
                    //     loading: () => Center(child: CircularProgressIndicator()),)

                      

                  )
                ],
              ),
              SizedBox(height: w*0.02,),
              ref.watch(wishListStreamProvider(currentuserid)).when(
                  data: (userdata){
                   return ref.watch(ref.watch(categoryItemsProvider1) == null ?
                    fullProductStreamProvider1 :
                    productStreamProvider1(ref.watch(categoryItemsProvider1))).when(
                      data: (productList){
                        print("product data");
                        print(ref.watch(categoryItemsProvider1));
                        print(productList.length);
                        print("product data");
                        return Expanded(
                            child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: productList.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 1),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList(productList[index]),));
                                  },
                                  child: Container(
                                    height: h*2,

                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left:35,
                                          child: Container(
                                              height: h*0.5,
                                              width: w*0.6,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    child: CircleAvatar(
                                                        radius: 55,
                                                        backgroundColor:sportsshoes[index]['backgroundcolor'],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 9,
                                                    top:9,
                                                    child: CircleAvatar(
                                                        radius: 45,
                                                        backgroundColor: sportsshoes[index]['backgroundcolor1']
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 20,
                                                    left: 19,

                                                    child: CircleAvatar(

                                                        radius: 35,
                                                        backgroundColor: sportsshoes[index]['backgroundcolor2']
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left:30,
                                                    top:30,
                                                    child: CircleAvatar(
                                                        radius: 25,
                                                        backgroundColor:sportsshoes[index]['backgroundcolor3']
                                                    ),
                                                  ),
                                                  CircleAvatar(
                                                      radius: 55,
                                                      backgroundColor: Colors.transparent,

                                                      child:Image.network(productList[index].image)
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),

                                        Positioned(
                                            right: 10,
                                            child: Consumer(builder: (context, ref, child) {
                                              return InkWell(
                                                  onTap: () {
                                                    ref.read(res);
                                                    if(ref.watch(wishListProvider).contains(productList[index].id)){
                                                      ref.read(wishListProvider.notifier).update((state) {
                                                         deleteFromWishList(productId: productList[index].id);
                                                        state.remove(productList[index].id);
                                                        return state;
                                                      });
                                                      // fav=!fav;

                                                    }
                                                    else{
                                                      addToWishList(
                                                      productId: productList[index].id);
                                                      ref.read(wishListProvider.notifier).update((state) =>state+[productList[index].id]);
                                                    }
                                                    ref.read(res.notifier).update((state) => !state);
                                                  },
                                                  child:userdata.wishlist.contains(productList[index].id)? Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border,color: themeColor.greycolor,));
                                            },)),
                                        Positioned(
                                          bottom: 10,
                                          right: 15,
                                          child: InkWell(
                                             onTap: () {
                                             },
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: themeColor.primarycolor,
                                              child: Icon(Icons.add,color: Colors.white,),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 25,
                                          child: Container(
                                              height: h*0.06,
                                              width: w*0.25,
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(productList[index].productname,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                                                  Row(
                                                    children: [
                                                      Text("\$",style: TextStyle(fontSize: 10),),
                                                      Text(productList[index].amount.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                    ],
                                                  )
                                                ],
                                              )
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 5,
                                          child: Container(
                                            height: h*0.03,
                                            width: w*0.22,
                                            child:
                                            PannableRatingBar(
                                              direction: Axis.horizontal,
                                              crossAxisAlignment: WrapCrossAlignment.start ,

                                              rate: productList[index].rating,
                                              items: List.generate(5, (index) =>
                                              const RatingWidget(
                                                selectedColor: Colors.yellow,
                                                unSelectedColor: Colors.grey,
                                                child: Icon(
                                                  Icons.star,
                                                  size: 13,
                                                ),
                                              )),
                                              onChanged: (value) { // the rating value is updated on tap or drag.
                                                // setState(() {
                                                //   rating = value;
                                                // });
                                                ref.read(ratingItemsProvider1.notifier).update((state) => value);
                                              },
                                            ),
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                        );



                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => Center(child: CircularProgressIndicator()),);
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => Center(child: CircularProgressIndicator()))


            ],
          ),
        ),
      ),
    );
  }
}

