import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/core/constants/images.dart';
import 'package:riverpodconnection/feature/home/productcart/screens/productcart.dart';
import 'package:riverpodconnection/feature/home/productdetails.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math' as math;

import '../../../../main.dart';
import '../../wishlist/screens/wishlistpage.dart';
import '../controller/firstpage_controller.dart';


final selectedIndexProvider = StateProvider<int>((ref) {
  return 1;
});



final carouselIndexProvider = StateProvider<int>((ref) {
  return 0;
});


class firstPage extends ConsumerStatefulWidget {
  const firstPage({super.key});

  @override
  ConsumerState<firstPage> createState() => _firstPageState();
}

int v=0;
int count=4;
bool view=true;


List ad=[];


List<Map> categories=[
  {
    "icon": Icon(Icons.widgets,color: themeColor.primarycolor,),
    "Text":"All"
  },
  {
    "icon": Image.asset(Pictures.footwears),
    "Text":"Footwear"
  },
  {
    "icon": Image.asset(Pictures.watch),
    "Text":"Watch"
  },
  {
    "icon": Image.asset(Pictures.clothings),
    "Text":"clothings"
  }
];


List<Map> popular=[
  {
    "image":  Image.asset("images/nike1.png",),
    "Text": "Shoes",
    "price": "\$ 100.00",
    "color": Colors.deepOrange.shade300,
  },
  {
    "image":  Image.asset("images/chair.png"),
    "Text": "Shoes",
    "price": "\$ 100.00",
    "color":Colors.blue.shade200,
  },
  {
    "image":   Image.asset("images/watchnew.png"),
    "Text": "Shoes",
    "price": "\$ 100.00",
    "color":Colors.green.shade200,
  },
  {
    "image":  Image.asset("images/walletnew.png"),
    "Text": "Shoes",
    "price": "\$ 100.00",
    "color":Colors.red.shade200,
  },
  {
    "image":  Image.asset("images/nike1.png",),
    "Text": "Shoes",
    "price": "\$ 100.00",
    "color": Colors.deepOrange.shade300,
  },
  {
    "image":  Image.asset("images/chair.png"),
    "Text": "Shoes",
    "price": "\$ 100.00",
    "color":Colors.blue.shade200,
  },
  {
    "image":   Image.asset("images/watchnew.png"),
    "Text": "Shoes",
    "price": "\$ 100.00",
    "color":Colors.green.shade200,
  },
  {
    "image":  Image.asset("images/walletnew.png"),
    "Text": "Shoes",
    "price": "\$ 100.00",
    "color":Colors.red.shade200,
  },
];




class _firstPageState extends ConsumerState<firstPage> {
  @override
  Widget build(BuildContext context) {
    int carouselcount= ref.watch(carouselIndexProvider);
    print(currentuserid);
    int selectedIndex = ref.watch(selectedIndexProvider);
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

          title: InkWell(
            onTap: (){
       //       Navigator.push(context, MaterialPageRoute(builder: (context)=>TestPage()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 95),
              child: Text("Home",style: TextStyle(
                  color: themeColor.blackcolor,fontWeight: FontWeight.bold
              ),),
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
                Navigator.push(context, MaterialPageRoute(builder:(context) => ProductCartPage(),));
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
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                height: h*0.1,
                width: w*0.1,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                    image: DecorationImage(image: NetworkImage(currentuserimage))
                ),
              ),
            ),




          ],
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
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
                              hintText: "Search.."
                          ),



                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Container(
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
                      ),
                    )
                  ],
                ),
                SizedBox(height: w*0.03,),
                Container(
                    height: w*0.51,
                    width: w*1,
                    child: ref.watch(getDataProvider).when(
                      data: (dataList){

                        return CarouselSlider.builder(
                          itemCount: dataList.length,
                          options: CarouselOptions(
                            autoPlay: true,
                            viewportFraction:1,
                            autoPlayAnimationDuration: Duration(seconds: 1 ),
                            scrollPhysics: BouncingScrollPhysics(),
                            onPageChanged: (index, reason) {

                              ref.read(carouselIndexProvider.notifier).update((state) => index);
                              print(v);
                            },
                          ),
                          itemBuilder: (context, index, realIndex) {
                            // v=index;
                            // print(v);
                            return Container(
                              height: w*0.6,
                              width: w*1,
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(w*0.05),
                                  image: DecorationImage(image:NetworkImage(dataList[index].imageUrl),fit: BoxFit.fill)
                              ),


                              //  margin: EdgeInsets.only(right: w*0.02),
                            );

                          },

                        );
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => Center(child: CircularProgressIndicator()),)

                ),

                SizedBox(height: w*0.03,),
                AnimatedSmoothIndicator(
                  activeIndex: carouselcount,
                  count: ref.read(getDataProvider).value?.length??0,
                  effect: ExpandingDotsEffect(activeDotColor: Colors.black,dotHeight: w*(0.00255*6)),

                ),

                      SizedBox(
                        height: h*0.1,
                        child: Consumer(
                          builder: (context,ref,child) {
                            var data=ref.watch(getCategoryProvider);
                            return  data.when(
                                data: (data){
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          ref.read(selectedIndexProvider.notifier).update((state) => index);
                                        },
                                        child: Container(
                                          height: 10,
                                          width: w*0.3,
                                          margin: EdgeInsets.only(right: w*0.05,top: 9,bottom: 5),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Center(
                                            child: Text(data[index].productcategory,style: TextStyle(
                                                color: selectedIndex==index?themeColor.primarycolor:themeColor.blackcolor),),
                                          ),
                                        ),
                                      );
                                    },);
                                } ,
                                error: (error, stackTrace) => Text(error.toString()),
                                loading: () => CircularProgressIndicator(),);

                          }
                        ),
                      ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Popular",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: w*0.05
                    ),),
                    InkWell(
                      onTap: () {
                        setState(() {

                        });
                      },
                      child: Text("View all",style: TextStyle(
                          color: Colors.grey.shade500
                      ),),
                    )
                  ],
                ),
                ref.watch(productStreamProvider(ref.watch(getCategoryProvider).when(
                    data: (data){
                      return data[selectedIndex].productcategory;
                    },
                    error: (error, stackTrace) => error.toString(),
                    loading: () =>"jjhyh" ,))
                ).when(
                  data: (productList){

                    return SizedBox(
                      // height: h*0.3,
                      child: MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        itemCount: productList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList(productList[index]),));
                              },
                              child: Container(
                                height: (index % 4==0||index % 4==3)?175 : 200,

                                decoration: BoxDecoration(
                                    color:popular[index]["color"],
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                padding: EdgeInsets.all(6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: w*0.27,
                                      width: w*0.4,
                                      decoration:
                                      BoxDecoration(
                                        image: DecorationImage(image: NetworkImage(productList[index].image)),
                                      ),


                                    ),
                                    Text(productList[index].productname,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                    Text(productList[index].amount.toStringAsFixed(2),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)

                                  ],
                                ),
                              ),
                            );

                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) {
                    print(error);
                    return Text(error.toString());
                  },
                  loading: () => Center(child: CircularProgressIndicator()),)




              ]),

        ),
      ),
    );
  }
  Widget actionButton(Widget child){
    return CircleAvatar(
      radius: w*0.04,
      backgroundColor: Colors.grey.shade300,
      child: child,
    );
  }
}

