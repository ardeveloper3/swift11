// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swift11/Home_controller/auth_controller.dart';
import 'package:swift11/Widgets_common/applogo_widget.dart';
import 'package:swift11/Widgets_common/bg_widget.dart';
import 'package:swift11/Widgets_common/custom_textfield.dart';
import 'package:swift11/consts/colors.dart';
import 'package:swift11/consts/firebase_const.dart';
import 'package:swift11/consts/strings.dart';
import 'package:swift11/consts/styles.dart';
import 'package:swift11/views/splash_screen/Home_Screen/home.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../Widgets_common/Our_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? ischeked=false;
  var controller=Get.put(AuthController());
  //text controller
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var passwordRetypeController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,

            "join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(()=> Column(
                children: [
                  customTextfiled(hint: nameHint, title: name,controller: nameController,isPass: false),
                  10.heightBox,
                  customTextfiled(hint: emailHint, title: email,controller: emailController,isPass: false),
                  10.heightBox,
                  customTextfiled(hint: passwordHint, title: password,controller: passwordController,isPass: true),
                  10.heightBox,
                  customTextfiled(hint: passwordHint, title: retypePassword,controller: passwordRetypeController,isPass: true),
                  20.heightBox,
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: TextButton(
                  //         onPressed: () {}, child: forgetPassord.text.make())),

                  Row(
                    children: [
                      Checkbox(
                        checkColor: redColor,
                          value: ischeked,
                          onChanged: (newvalue){
                            setState(() {
                              ischeked=newvalue;
                            });
                          },),
                      //when we need different color word in one line we can use RichText widget
                      Expanded(
                        child: RichText(text: TextSpan(
                          children: [
                            TextSpan(
                              text: "I agree to the",
                              style: TextStyle(
                                fontFamily: bold,
                                color: Colors.lightBlueAccent
                              ),
                            ),
                            TextSpan(
                              text: termsAndCond,
                              style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                              ),
                            ),
                            TextSpan(
                              text: "&",
                              style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                              ),
                            ),

                          ]
                        )),
                      )

                    ],
                  ),
                  10.heightBox,
                controller.isLoading.value?   CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ):ourButton(
                      color:ischeked==true? redColor:lightGrey,
                      title: signUp,
                      textColor: whiteColor,
                      onPress: () async{

                        if(ischeked!=false){
                          controller.isLoading(true);
                          try{
                            await controller.signUpMethode(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                            ).then((value){
                              return controller.storeUserData(
                                email: emailController.text,
                                name: nameController.text,
                                password: passwordController.text,
                              );
                            }).then((value){
                              VxToast.show(context, msg: loggedin);
                              Get.off(()=>Home());
                            });
                          }catch(e){
                            auth.signOut();
                            VxToast.show(context, msg: e.toString());
                            controller.isLoading(false);
                          }

                        }
                      })
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                 5.heightBox,
                 Row(
                   children: [

                     alreadyhaveacount.text.color(fontGrey).make(),
                     login.text.color(redColor).make().onTap(() {
                       Get.back();
                     })
                   ],
                 )


                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70).shadowSm.make(),
            ),
          ],
        ),
      ),
    ));
  }
}
