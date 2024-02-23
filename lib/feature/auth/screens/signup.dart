import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodconnection/feature/auth/controller/auth_controller.dart';
import 'package:riverpodconnection/feature/auth/screens/selectionpage.dart';

import '../../../core/constants/images.dart';
import '../../../main.dart';

class signupPage extends ConsumerStatefulWidget {
  const signupPage({super.key});

  @override
  ConsumerState<signupPage> createState() => _signupPageState();
}

class _signupPageState extends ConsumerState<signupPage> {




  final tapProvider = StateProvider<bool>((ref) {
    return true;
  });


//  bool tap=true;

  RegExp email_validation = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{3,4}$");
  RegExp password_validation = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{10}$");
  FocusNode focusnode1 =FocusNode();
  FocusNode focusnode2 =FocusNode();
  FocusNode focusnode3 =FocusNode();


  final formkey=GlobalKey<FormState>();

  void signInWithGoogle(){
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }


  TextEditingController password_controller=TextEditingController();
  TextEditingController email_controller=TextEditingController();
  TextEditingController confirm_controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var tap=ref.watch(tapProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SignUp"),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Container(
                    height: h*0.40,
                    width: w*1,
                    padding: EdgeInsets.all(12),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: email_controller,
                            inputFormatters: [
                         //     FilteringTextInputFormatter.allow(RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{3,4}$"))
                            ],
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if(!email_validation.hasMatch(value!)){
                                return "enter valid email";
                              }else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your Email",
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                          SizedBox(height: h*0.05,),
                          TextFormField(
                            controller: password_controller,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:tap,
                            autofocus: false,
                            focusNode: focusnode1,
                            inputFormatters: [
                           //   FilteringTextInputFormatter.allow(password_validation)
                            ],
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                             if(!password_validation.hasMatch(value!)){
                               return "Enter valid Password";
                             }else{
                               return null;
                             }
                            },
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () {
                                    ref.read(tapProvider.notifier).update((state) => !tap);
                                  },
                                  child: tap==true?Icon(Icons.visibility):Icon(Icons.visibility_off) ),
                                disabledBorder: OutlineInputBorder(),
                                hintText: "Enter your Password",

                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                            ),
                          ),
                          SizedBox(height: h*0.05,),
                          TextFormField(
                            controller: confirm_controller,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:tap,
                            autofocus: false,
                            focusNode: focusnode3,
                            inputFormatters: [
                         //     FilteringTextInputFormatter.allow(password_validation)
                            ],
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if(!password_validation.hasMatch(value!)){
                                return "Enter valid Password";
                              }else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () {
                                    ref.read(tapProvider.notifier).update((state) => !tap);
                                  },
                                  child: tap==true?Icon(Icons.visibility):Icon(Icons.visibility_off) ),


                              disabledBorder: OutlineInputBorder(),
                              hintText: "Enter Confirm Password",

                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),

                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  if(formkey.currentState!.validate()&&
                  email_controller.text.isNotEmpty&&
                  password_controller.text.isNotEmpty==confirm_controller.text.isNotEmpty
                  ){
                    ref.read(authControllerProvider.notifier).EmailandPassword(email: email_controller.text.trim(), password: password_controller.text.trim(),context: context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage(),));
                  }

                },
                child: Text("Signup")),
            SizedBox(height: h*0.2,),
            InkWell(
             onTap: () {
               signInWithGoogle();
             },
              child: Container(
                height: h*0.045,
                width: w*0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.red, Colors.yellow, Colors.green,Colors.blue],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Learn.Build.Connect.",style: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15
                    ),),
                    SizedBox(width: 5,),
                    Container(
                      height: w*0.07,
                      width: w*0.07,
                      child: Image.asset(Pictures.googleIcon),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
