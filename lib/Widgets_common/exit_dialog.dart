import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swift11/Widgets_common/Our_button.dart';
import 'package:swift11/consts/consts.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Conform".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you sure you want to exit?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            ourButton(
              color: redColor,
              textColor: whiteColor,
              onPress: (){
                SystemNavigator.pop();
              },
              title: "Yes"
            ),


            ourButton(
                color: redColor,
                textColor: whiteColor,
                onPress: (){
                  Navigator.pop(context);
                },
                title: "No"
            ),

          ],
        )
      ],
    ).box
        .color(lightGrey)
    .rounded
    .padding(EdgeInsets.all(12))
        .make(),
  );
}