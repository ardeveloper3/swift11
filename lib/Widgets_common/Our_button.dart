
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swift11/consts/styles.dart';
import 'package:velocity_x/velocity_x.dart';
Widget ourButton({onPress,color,textColor,String? title}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.all(12),

      ),

      onPressed: onPress, child: title!.text.color(textColor).fontFamily(bold).make());
}