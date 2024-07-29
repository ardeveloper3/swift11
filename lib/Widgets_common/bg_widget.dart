// ignore_for_file: prefer_const_constructors



import 'package:flutter/material.dart';
import 'package:swift11/consts/images.dart';

Widget bgWidget(Widget? child){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imgBackground),fit: BoxFit.fill,

      ),

    ),
    child: child,
  );
}