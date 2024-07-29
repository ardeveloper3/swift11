import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift11/consts/consts.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    getUserName();
    super.onInit();
  }


  var currentNavIndex=0.obs;


  var username = '';

  var featuredlist = [];

  var searchController = TextEditingController();

  getUserName()async{
  var n  =  await firestore.collection(usersCollection).where('id',isEqualTo: currentUser!.uid).get().then((value){

    if(value.docs.isNotEmpty){
      return value.docs.single['name'];
    }

    });
  username = n;

  }

}