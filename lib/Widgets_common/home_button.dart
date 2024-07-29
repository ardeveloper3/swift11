


import 'package:flutter/material.dart';
import 'package:swift11/consts/colors.dart';
import 'package:swift11/consts/styles.dart';
import 'package:velocity_x/velocity_x.dart';

Widget homeButton({width, height, icon,String? title, onpress}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon,width: 26,),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),

    ],
  ).box.rounded.white.size(width, height).make();
}