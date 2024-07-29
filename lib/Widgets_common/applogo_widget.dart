
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swift11/consts/images.dart';

Container applogoWidget(){
  return Container(
    height: 77,
   width: 77,
   padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color:Colors.white,
      borderRadius: BorderRadius.circular(20.0),


    ),
    child: Center(child: Image.asset(icAppLogo)),
  );
}