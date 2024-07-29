
import 'package:flutter/material.dart';
import 'package:swift11/Home_controller/auth.dart';
import 'package:swift11/Widgets_common/applogo_widget.dart';
import 'package:swift11/consts/images.dart';
import 'package:swift11/consts/strings.dart';
import 'package:swift11/consts/styles.dart';
import 'package:swift11/views/splash_screen/Home_Screen/home.dart';
import 'package:swift11/views/splash_screen/auth_screen/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
    Future.delayed(Duration(seconds: 3),(){
      //getx mean we are using get property insted of navigator.push
      Get.to(()=>StreamBuilder(
          stream: Auth().authStateChenges,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Home();
            }else{
              return const LoginScreen();
            }
          }));
    });

  }
  @override
  void initState() {
    changeScreen();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          children: [
            Align(

                alignment: Alignment.topLeft,

                child: Image.asset(icSplashBg,width: 300,),
            ),
            20.heightBox,
            applogoWidget(),
            //easy system for coding by using velocity and get packeges
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            5.heightBox,
            Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
            //our splashscreen ui is created






          ],
        ),
      ),
    );
  }
}
