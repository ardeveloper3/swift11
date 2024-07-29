// ignore_for_file: prefer_const_constructors


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:swift11/Home_controller/auth.dart';
import 'package:swift11/Home_controller/auth_controller.dart';
import 'package:swift11/Widgets_common/Our_button.dart';
import 'package:swift11/Widgets_common/applogo_widget.dart';
import 'package:swift11/Widgets_common/bg_widget.dart';
import 'package:swift11/consts/colors.dart';
import 'package:swift11/consts/lists.dart';
import 'package:swift11/consts/strings.dart';
import 'package:swift11/consts/styles.dart';
import 'package:swift11/views/splash_screen/Home_Screen/home.dart';
import 'package:swift11/views/splash_screen/auth_screen/SignUp.dart';
import 'package:velocity_x/velocity_x.dart';


import '../../../Widgets_common/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  //i just creat it a statefull widget
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //defferentway





  //////////////////
  var controller = Get.put(AuthController());
  //
  var passwordController=TextEditingController();
  var emailController=TextEditingController();

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
            "log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(()=> Column(
                children: [
                  customTextfiled(hint: emailHint, title: email,isPass: false,controller:controller.emailController ),

                  10.heightBox,
                  customTextfiled(hint: passwordHint, title: password,isPass: true,controller: controller.passwordController),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPassord.text.make())),

                 controller.isLoading.value?
                 CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(redColor),
                 ):
                 ourButton(
                          color: redColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: ()async{
                            controller.isLoading(true);
                            await controller.loginMethode(context:context).then((value){
                              if(value!=null){
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(()=>Home());
                              }else{

                                controller.isLoading(false);

                              }
                            });
                          })
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  10.heightBox,

                  ourButton(
                          color:golden,
                          title: signUp,
                          textColor: redColor,
                          onPress: () {
                            Get.to(()=>SignUpScreen());
                          })
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: lightGrey,
                        radius: 25,
                        child: Image.asset(socialIconList[index],
                        width: 35,
                        ),

                      ),
                    )),
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
