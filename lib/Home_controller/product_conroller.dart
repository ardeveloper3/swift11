import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/models/category_model.dart';

class ProductController extends GetxController{

  var totalPrice = 0.obs;
  var quentity = 0.obs;
  var colorIndex = 0.obs;
  var subcat=[];

  var isFav = false.obs;

  getSubCategories(title)async{
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);

    var s = decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory ){

      subcat.add(e);

    }
  }

  changeColorIndex(index){
    colorIndex.value = index;

  }

  increaseQuantity(totalQuantity){
  if(quentity.value<totalQuantity){
    quentity.value++;
  }
  }
  decreaseQuentity(){
   if(quentity.value>0){
     quentity.value--;
   }
  }
  calculateTotalPrice(price){
  totalPrice.value =  price*quentity.value;
  }

  addToCart({
    title,img,sellerName,color,qty,tprice,context,vendorID
})async{
    await firestore.collection(cartCollection).doc().set({
      'title':title,
      'img': img,
      'sellerName':sellerName,
      'color':color,
      'qty':qty,
      'vendor_id':vendorID,
      'tprice':tprice,
      'added_by':currentUser!.uid
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues(){
    totalPrice.value=0;
    quentity.value =0;
    colorIndex.value=0;
  }
  
  addToWishList(docId,context )async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    },SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: 'Added favorite');
  }

  removeFromWishList(docId,context)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    },SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed favorite");
  }

  checkIfFav(data){
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }else{

      isFav(false);

    }
  }

}