// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swift11/Home_controller/profile_controller.dart';
import 'package:swift11/Widgets_common/Our_button.dart';
import 'package:swift11/Widgets_common/bg_widget.dart';
import 'package:swift11/Widgets_common/custom_textfield.dart';
import 'package:swift11/consts/colors.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/consts/images.dart';
import 'package:velocity_x/velocity_x.dart';

class EditeProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditeProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<profileController>();

    return bgWidget(Scaffold(
      appBar: AppBar(),
      body: Obx(
        //if there is changing somethink by using obx the ui also change
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if  image url and controller path is empty
              data['imageUrl'] == '' && controller.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 60,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
              //if data  is not empty but controller path is empty
                  : data['imageUrl'] != '' && controller.profileImagePath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
              //if both are empty
                      : Image.file(
                          File(controller.profileImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "change"),
              const Divider(),
              20.heightBox,
              customTextfiled(
                controller: controller.namecontroller,
                hint: nameHint,
                title: name,
                isPass: false,
              ),
              10.heightBox,
              customTextfiled(
                controller: controller.oldpasscontroller,
                hint: passwordHint,
                title: oldpass,
                isPass: true,
              ),
              10.heightBox,
              customTextfiled(
                controller: controller.newpasscontroller,
                hint: passwordHint,
                title: newpass,
                isPass: true,
              ),
              20.heightBox,
              controller.isLoading.value
                  ?  CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 40,
                      child: ourButton(
                          color: redColor,
                          onPress: () async {
          
          
          
                            controller.isLoading(true);
          
          
          
                            //if image is not selected
                            if(controller.profileImagePath.value.isNotEmpty){
                              await controller.uploadProfileImage();
                            }else{
                              controller.profileImageLink = data['imageUrl'];
                            }
          
                            //if old password match data base
          
                            if(data['password']==controller.oldpasscontroller.text){
          
                              controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpasscontroller.text,
                                newpassword: controller.newpasscontroller.text,
                              );
          
                              await controller.updateProfile(
                                  imgUrl: controller.profileImageLink,
                                  name: controller.namecontroller.text,
                                  password: controller.newpasscontroller.text);
                              VxToast.show(context, msg: "Updated");
          
                            }else{
                              VxToast.show(context, msg: "Wrong old password");
                              controller.isLoading(false);
                            }
          
                            },
                          textColor: whiteColor,
                          title: "save"),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50.0, left: 12.0, right: 12.0))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
