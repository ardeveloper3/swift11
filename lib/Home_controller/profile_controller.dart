import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swift11/consts/consts.dart';
import 'package:path/path.dart';

class profileController extends GetxController{

  var isLoading = false.obs;
  //textfield

  var namecontroller = TextEditingController();
  var oldpasscontroller = TextEditingController();
  var newpasscontroller = TextEditingController();



  var profileImagePath="".obs;
  var profileImageLink = '';
changeImage(context)async{

  try{
    final img =await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
    //if nulll this happened

    if(img==null) return;
    //if not =null
    profileImagePath.value=img.path;
  }on PlatformException   catch(e){
    VxToast.show(context, msg: e.toString());
  }
}
uploadProfileImage()async{
  var filename = basename(profileImagePath.value);
  var destination = 'images/${currentUser!.uid}/$filename';
  Reference ref = FirebaseStorage.instance.ref().child(destination);
  await ref.putFile(File(profileImagePath.value));
  profileImageLink=await ref.getDownloadURL();
}
updateProfile({name,password,imgUrl})async{
  var store = firestore.collection(usersCollection).doc(currentUser!.uid);
 await store.set({
    'name':name,
    'password':password,
    'imageUrl':imgUrl
  },SetOptions(merge: true));
 isLoading(false);
}

changeAuthPassword({email,password,newpassword})async{
  final cred = EmailAuthProvider.credential(email: email, password: password);
  await currentUser!.reauthenticateWithCredential(cred).then((value){
    currentUser!.updatePassword(newpassword);
  }).catchError((error){
    print(error.toString());
  });
}

}