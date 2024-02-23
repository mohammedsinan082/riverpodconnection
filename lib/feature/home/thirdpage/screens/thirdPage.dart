import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';
import 'package:riverpodconnection/core/constants/colors.dart';

import '../../../../main.dart';



class thirdPage extends StatefulWidget {
  const thirdPage({super.key});

  @override
  State<thirdPage> createState() => _thirdPageState();
}

class _thirdPageState extends State<thirdPage> {
  List<ImageProvider> imageList=[];
  bool autorotate=false;
  int rotationcount = 22;
  int swipesensitivity=2;
  bool swipetorotate=true;

  @override
  void initState() {
    updateimagelist(context);
    super.initState();
  }
  void updateimagelist(BuildContext context){
    for(int i=1;i<=22;i++){
     imageList.add(AssetImage("images/s$i.png"));
    }
  }

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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(
        onPressed: (){

        },
        backgroundColor: themeColor.primarycolor,
        child: Icon(Icons.shopping_bag),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios,size: 15,color: Colors.grey,),
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
                height: h*0.5,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding:EdgeInsets.only(bottom: 10,top: 170),
                      child: Image.asset("images/ring.png"),),
                    ),
                    ImageView360(
                      key: UniqueKey(),
                      imageList: imageList,
                      rotationCount: rotationcount,
                      autoRotate: autorotate,
                      swipeSensitivity: swipesensitivity,
                      allowSwipeToRotate: swipetorotate,)
                  ],
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
                              Text("Puma Max",style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 20
                              ),),
                              Row(
                                children: [
                                  Text("\$",style: TextStyle(fontSize: 10,color: themeColor.primarycolor),),
                                  Text("100.00",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: themeColor.primarycolor),),
                                ],
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("By Puma",style: TextStyle(
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

                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                  itemBuilder: (context, index) {

                                    return
                                      Padding(
                                        padding: const EdgeInsets.only(right: 25),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              size=index;
                                              text=index;

                                            });

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
                                  },),
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
                          Text("Color",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),

                          Container(
                            width: w*0.63,
                            height: w*0.1,
                            child: Container(
                              height: w*0.04,
                              width: w*0.05,

                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                  itemBuilder: (context, index) {

                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectcolor=index;
                                        });
                                      },
                                      child: Container(
                                        child:index==selectcolor? Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15),
                                              child: CircleAvatar(
                                                backgroundColor:background[index]["color"] ,
                                                radius: 24,
                                              ),
                                            ),
                                            Positioned(
                                              left: 27,
                                                top:6,
                                                child: Icon(Icons.check,color: Colors.white,))
                                          ],
                                        ):
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: CircleAvatar(
                                            backgroundColor:background[index]["color"] ,
                                            radius: 20,
                                          ),
                                        ),
                                      ),
                                    );
                                    

                                    
                                  },),
                            )

                          )
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



