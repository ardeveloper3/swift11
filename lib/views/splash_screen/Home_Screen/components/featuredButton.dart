// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swift11/consts/colors.dart';
import 'package:swift11/consts/styles.dart';
import 'package:swift11/views/splash_screen/CategoriesScreen/categries_ditails.dart';
import 'package:velocity_x/velocity_x.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon!,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4.0))
      .white
      .padding(EdgeInsets.all(4.0))
      .roundedSM
      .outerShadowSm
      .make().onTap(() {
        Get.to(()=>CategoryDetails(title: title));
  });
}
