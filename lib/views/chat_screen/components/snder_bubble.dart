// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:swift11/consts/consts.dart';



Widget senderBubble(DocumentSnapshot data){
  var t = data['created_on'] == null ? DateTime.now(): data['created_on'].toDate();

  var time = intl.DateFormat("h:mma").format(t);

  return   Directionality(
    textDirection: data['uid'] == currentUser!.uid?TextDirection.ltr:TextDirection.rtl,
    child: Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid?redColor:darkFontGrey,
        borderRadius: data['uid'] == currentUser!.uid?
        BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),bottomLeft: Radius.circular(20),

        ):  BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),bottomRight: Radius.circular(20),

        )
      ),
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.white.make(),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).make(),
        ],
      ),
    ),
  );
}