import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/consts/firebase_const.dart';

class AuthController extends GetxController{
  var isLoading = false.obs;

  //textcontroller
  var emailController=TextEditingController();
  var passwordController=TextEditingController();




  //login methode
Future<UserCredential?>loginMethode({context})async{
  UserCredential? userCredential;
  try{
   userCredential= await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  }on FirebaseAuthException catch(e){
    VxToast.show(context, msg: e.toString());
  }
  return userCredential;
}

//signupmethode
  Future<UserCredential?>signUpMethode({email,password,context})async{
    UserCredential? userCredential;
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }
////storing data methode
storeUserData({name,password,email})async{
  DocumentReference store= await firestore.collection(usersCollection).doc(currentUser!.uid);
  store.set({
    'name':name,
    'password':password,
    'email':email,
   'imageUrl':'',
    'id': currentUser!.uid,
    'cart_count':"00",
    'order_count':"00",
    'wishlist_count':"00",

  });
}
//signout
signOutMethode({context})async{
  try{
    await auth.signOut();
  }catch(e){
    VxToast.show(context, msg: e.toString());
  }
}

}

