

import 'package:flutter/material.dart';
import 'package:swift11/consts/colors.dart';

Widget loadingIndicator(){
  return  const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}