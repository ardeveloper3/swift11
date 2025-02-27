import 'package:swift11/consts/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestorServices {
  //get users data in this methode i can collect the data useres frome firebase  from under the coolections id
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get products according to category
  static getproducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //get subcatygories

  static getSubCategoryProducts(title){
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: title)
        .snapshots();
  }

//get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }
  //delete document

  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

//get all chat messages

  static getChatMessages(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
  }

  static getWishLists(){
    return firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
  }


  static getAllMessages(){
    return firestore.collection(chatCollection).where('fromId',isEqualTo: currentUser!.uid).snapshots();
  }

 static getCounts()async{

    var res =await  Future.wait([

      firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value){

        return value.docs.length;
      }),
      firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value){

        return value.docs.length;
      }),
      firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value){

        return value.docs.length;
      }),
    ]);
    return res;
 }

 static allProducts(){
   return firestore
       .collection(productsCollection)
       .get();
 }
 
 //get featured products methode

static getFeaturedProducts(){
    return firestore.collection(productsCollection).where('is_Featured',isEqualTo: true).get();


}



static searchProducts(title){
    return firestore.collection(productsCollection).get();
}
 
 
}
