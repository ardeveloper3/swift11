import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swift11/consts/consts.dart';

Widget orderStatus({icon, color, title,  showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.padding(EdgeInsets.all(4.0)).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
         " $title".text.color(darkFontGrey).make(),
        showDone?  Icon(
            Icons.done,
            color: redColor,
          ):Container(),
        ],
      ),
    ),
  );
}
