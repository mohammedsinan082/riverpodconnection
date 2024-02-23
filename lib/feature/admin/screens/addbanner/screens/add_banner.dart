import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpodconnection/core/constants/colors.dart';
import 'package:riverpodconnection/feature/admin/screens/addbanner/screens/viewBanner.dart';

import '../../../../../core/constants/contants1.dart';
import '../../../../../main.dart';
import '../controller/add_banner_controller.dart';

class AddBanner extends ConsumerStatefulWidget {
  const AddBanner({super.key});

  @override
  ConsumerState<AddBanner> createState() => _AddBannerState();
}

class _AddBannerState extends ConsumerState<AddBanner> {


  final pickImageProvider=StateProvider<File?>((ref) {
    return null;
  });


  final dropDownProvider=StateProvider<String>((ref){
    return "";
  });



  var imageurl='';

  pickImage() async {
    final picker=ImagePicker();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png','jpg'],
    );
    final pick=result!.files.first;
    if(pick.size<524288){
      ref.read(pickImageProvider.notifier).update((state) =>File(result.files.single.path!));

      var uploadimage=await FirebaseStorage.instance.ref().child("banner/${DateTime.now()}").putFile(ref.watch(pickImageProvider)!);
      var geturl=await uploadimage.ref.getDownloadURL();
      imageurl=geturl;
      setState(() {
      });


    }else{
      showMessage(context, text: "Upload image below 500kb", color: Colors.red);
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add Banner",style: TextStyle(
              color: themeColor.black,
              fontSize: w*0.07,
              fontWeight: FontWeight.w700
          ),),
          elevation: 0,
          backgroundColor: themeColor.iconRed,

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    imageurl!=null?
                    Container(
                      height: w*0.7,
                      width: w*0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w*0.03),
                          border: Border.all(),
                          image: DecorationImage(image: NetworkImage(imageurl!),fit: BoxFit.fill)
                      ),
                    ):
                    Container(
                      height: w*0.2,
                      width: w*0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w*0.03),
                          border: Border.all()
                      ),
                    ),
                    Positioned(
                      right: w*0.02,
                      bottom: w*0.01,
                      child: InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: CircleAvatar(
                          radius: w*0.09,
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.add_a_photo_outlined,size: w*0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: w*0.06,),

              InkWell(
                onTap: () {
                  if(imageurl.isNotEmpty){
                    ref.read(bannerControllerProvider.notifier).getBanner(image: imageurl,);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Viewbanner(),));
                  }else{
                    showMessage(context, text: "Please Add Image", color: themeColor.red);
                  }

                },
                child: Container(
                  width: w*0.4,
                  height: w*0.12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w*0.03),
                      color: themeColor.iconRed
                  ),
                  child: Center(
                    child: Text("ADD",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.03,
                          color: themeColor.black
                      ),
                    ),
                  ),
                ),
              ),



            ],
          ),
        ));
  }
}
